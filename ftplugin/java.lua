-- https://github.com/mfussenegger/nvim-jdtls/wiki/Sample-Configurations#pavva91-configuration
local jdtls = require("jdtls")
local jdtls_dap = require("jdtls.dap")
local jdtls_setup = require("jdtls.setup")

local jdt_root = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local project_root = jdtls_setup.find_root({
    '.git', 'gradlew', 'build.gradle', 'mvnw', 'pom.xml'
}) or vim.fn.getcwd()
local project_name = project_root:gsub('/', '%%')
print(project_root, project_name)
local workspace_dir = vim.fn.stdpath('cache') ..'/jdt_workspaces/' .. project_name


local settings = {
    java = {
        references = {
            includeDecompiledSources = true
        },
        eclipse = {
            downloadSources = true
        },
        maven = {
            downloadSources = true
        },
        signatureHelp = {
            enabled = true
        },
        contentProvider = {
            prefered = "fernflower"
        },
        completion = {
            enabled = true,
            importOrder = {
                "com.waterwolfies",
                "java",
                "javax",
                "com",
                "org"
            }
        },
        configuration = vim.loop.os_uname().sysname ~= "Windows" and {
            runtimes = {
                {
                    name = "JavaSE-1.8",
                    path = "/usr/lib/jvm/java-8-openjdk-amd64/"
                },
                {
                    name = "JavaSE-11",
                    path = "/usr/lib/jvm/java-11-openjdk-amd64/"
                },
                {
                    name = "JavaSE-17",
                    path = "/usr/lib/jvm/java-17-openjdk-amd64/"
                }
            }
        } or nil
    }
}

jdtls.start_or_attach({
    cmd = {
        -- jdt_root .. '/jdtls',

        'java',
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx3g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        '-jar', vim.fn.glob(jdt_root .. "/plugins/org.eclipse.equinox.launcher_*"),
        -- '-jar', vim.fs.find(function(name, _path) return name:gmatch('org%.eclipse%.equinox%.launcher_[0-9%-v]+')() end, { path = jdt_root .. '/plugins'})[1]

        '-data', workspace_dir,
        '-configuration', jdt_root .. "/config_" .. vim.loop.os_uname().sysname:lower(),
    },
    root_dir = project_root,
    settings = settings,
    flags = {
        allow_incremental_sync = true
    },
    on_init = function(client, _)
        client.notify('workspace/didChangeConfiguration', { settings = settings })
    end,
    on_attach = function()
        jdtls.setup_dap({ hotcodereplace = 'auto', config_overrides = {} })
        jdtls_dap.setup_dap_main_class_configs()
    end,
    init_options = {
        bundles = {
            vim.fn.glob(
                vim.fn.stdpath('data') ..
                "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
                true)
        }
    },
    capabilities = lsp_caps
})
