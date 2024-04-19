return {
    {
        'williamboman/mason.nvim',
        branch = 'main',
        dependencies = {
            -- Ensure Install LSP
            'williamboman/mason-lspconfig.nvim',

            -- LSP Support
            'neovim/nvim-lspconfig',

            -- Extended Support
            'mfussenegger/nvim-jdtls',

            -- Autocompletion
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets',

            -- DAP Support
            'mfussenegger/nvim-dap',
            'jay-babu/mason-nvim-dap.nvim',
            'rcarriga/nvim-dap-ui'
        },
        config = function (_spec)
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('user_lsp_attach', {clear = true}),
                callback = function (event)
                    local opts = {buffer = event.buf}
                    vim.keymap.set({'i', 'n'}, '<C-k><C-d>', function () vim.lsp.buf.definition() end, opts)
                    vim.keymap.set({'i', 'n'}, '<C-k><C-h>', function () vim.lsp.buf.hover() end, opts)
                    vim.keymap.set({'i', 'n'}, '<C-k>ca', function () vim.lsp.buf.code_action() end, opts)
                    vim.keymap.set({'i', 'n'}, '<C-k><C-r>', function () vim.lsp.buf.references() end, opts)
                    vim.keymap.set({'i', 'n'}, '<F2>', function () vim.lsp.buf.rename() end, opts)
                    vim.keymap.set({'i', 'n'}, '<C-k><C-e>', function() vim.diagnostic.open_float() end, opts)
                end
            })

            local cmp = require('cmp')
            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<A-Up>'] = cmp.mapping.scroll_docs(-4),
                    ['<A-Down>'] = cmp.mapping.scroll_docs(4),
                    ["<Esc>"] = cmp.mapping.abort()
                }),
                sources = {
                    { name = 'path' },
                    { name = 'nvim_lsp' },
                    { name = 'luasnip', keyword_length = 2 },
                    { name = 'buffer', keyword_length = 3 }
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered()
                },
                -- formatting = lsp_zero.cmp_format(),
                snippet = {
                    expand = function (args)
                        require('luasnip').lsp_expand(args.body)
                    end
                }
            })

            lsp_caps = vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), require('cmp_nvim_lsp.init').default_capabilities())


            require('mason').setup({})
            require('mason-lspconfig').setup({
                automatic_installation = true,
                ensure_installed = {
                    'tsserver',
                    'eslint',
                    'lua_ls',
                    "csharp_ls",
                    'rust_analyzer',
                    'clangd',
                    'arduino_language_server',
                    -- 'omnisharp',
                    'neocmake',
                    'diagnosticls',
                    'dockerls',
                    'docker_compose_language_service',
                    'gradle_ls',
                    'html',
                    'jsonls',
                    'jdtls',
                    'pyright',
                    -- 'snyk_ls',
                    'autotools_ls',
                    'marksman',
                    -- 'somesass_ls',
                    'yamlls'
                },
                handlers = {
                    -- lsp_zero.default_setup
                    function (server_name)
                        require('lspconfig')[server_name].setup({
                            capabilities = lsp_caps
                        })
                    end,
                    jdtls = function()
                    end,
                    clangd = function ()
                        require('lspconfig').clangd.setup({
                            capabilities = lsp_caps,
                            cmd = {
                                "clangd",
                                "--offset-encoding=utf-8"
                            }
                        })
                    end,
                    lua_ls = function ()
                        require('lspconfig').lua_ls.setup({
                            capabilities = lsp_caps,
                            settings = {
                                Lua = {
                                    runtime = {
                                        version = 'LuaJIT'
                                    },
                                    diagnostics = {
                                        globals = {'vim'}
                                    },
                                    workspace = {
                                        library = {
                                            vim.env.VIMRUNTIME
                                        }
                                    }
                                }
                            }
                        })
                    end
                }
            })

            require("luasnip.loaders.from_vscode").lazy_load()

            --- @module "nvim-dap.lua.dap"
            --- @diagnostic disable-next-line: assign-type-mismatch
            local dap = require('dap')
            local dapui = require('dapui')
            require('mason-nvim-dap').setup({
                automatic_installation = true,
                ensure_installed = {
                    'js',
                    'python',
                    'cppdgb',
                    'chrome',
                    'coreclr',
                    'javadbg',
                    'vscode-java-decompiler'
                },
                handlers = {
                }
            })

            dapui.setup()

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

            vim.keymap.set({'n', 'i'}, "<F5>", function()
                require("dap.ext.vscode").load_launchjs()
                dap.set_exception_breakpoints()
                dap.continue()
            end)
            vim.keymap.set({ 'n', 'i' }, "<C-S-F5>", dap.restart)
            vim.keymap.set({ 'n', 'i' }, "<S-F5>", dap.terminate)
            vim.keymap.set({ 'n', 'i' }, "<F6>", dap.pause)
        end
    }, {
        "folke/trouble.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        config = function ()
            require("trouble.init").setup({
                auto_preview = false,
                auto_open = false
            })
        end
    },
    {
        'j-hui/fidget.nvim',
        dependencies = {
            'nvim-tree/nvim-tree.lua',
        },
        config = function ()
             require("fidget").setup({
                progress = {
                    display = {
                        done_ttl = 7,
                    },
                },
                notification = {
                    history_size = 256,
                    override_vim_notify = true,
                    window = {
                        winblend = 70,
                        border = 'shadow'
                    }
                },

                logger = {
                    level = vim.log.levels.INFO
                },

                integration = {
                    ["nvim-tree"] = {
                        enable = true
                    }
                }
            })
        end
    }
}
