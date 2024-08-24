return {
    'nvim-tree/nvim-tree.lua',
    config = function (spec)
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        local explorer = require('nvim-tree').setup({
            on_attach = function (bufnr)
                local api = require('nvim-tree.api')

                local function Desc(str)
                    return { desc = str, buffer = bufnr }
                end

                local old_path = nil

                -- api.config.mappings.default_on_attach(bufnr)
                vim.keymap.set('n', '<C-J>', api.tree.change_root_to_node, Desc("Change Directory")) -- cd, C-J -> C-Enter (showkey -a)
                vim.keymap.set('n', 'i', api.node.show_info_popup, Desc("Toggle Info")) -- info
                vim.keymap.set('n', 'a', api.fs.create, Desc("Create New File")) -- create new
                vim.keymap.set('n', 'n', api.fs.create, Desc("Create New File")) -- create new
                vim.keymap.set('n', 'd', api.fs.trash, Desc("Trash")) -- send file to trash
                vim.keymap.set('n', '<Del>', api.fs.trash, Desc("Trash")) -- send file to trash
                vim.keymap.set('n', '<S-Del>', api.fs.remove, Desc("Delete")) -- remove file
                vim.keymap.set('n', 'T', function ()
                    if vim.fn.has('win32') then
                        print("Not Supported")
                        return
                    end
                    if old_path ~= nil then
                        api.tree.change_root(old_path)
                        old_path = nil
                        return
                    end
                    api.tree.change_root(os.getenv("HOME") .. "/.local/share/Trash")
                    old_path = vim.fn.getcwd()
                end, Desc("Toggle Trash Folder")) -- create new
                vim.keymap.set('n', '<CR>', api.node.open.edit, Desc("Open/Expand Folder")) -- open/expand
                vim.keymap.set('n', 't', api.node.open.tab_drop, Desc("Open in New Tab")) -- open/expand
                vim.keymap.set('n', 'r', api.fs.rename, Desc("Rename")) -- rename
                vim.keymap.set('n', '<C-r>', api.fs.rename_full, Desc("Move")) -- move
                vim.keymap.set('n', 'c', api.fs.copy.node, Desc("Copy")) -- copy to clipboard
                vim.keymap.set('n', 'x', api.fs.cut, Desc("Cut")) -- cut to clipboard
                vim.keymap.set('n', 'v', api.fs.paste, Desc("Paste")) -- paste
                vim.keymap.set('n', 'p', api.fs.copy.absolute_path, Desc("Copy Path")) -- copy path
                vim.keymap.set('n', 'q', api.tree.close, Desc("Close")) -- close nvim tree
                vim.keymap.set('n', 'R', api.tree.reload, Desc("Reload")) -- reload nvim tree
                vim.keymap.set('n', 's', api.tree.search_node, Desc("Search")) -- search for file
                vim.keymap.set('n', '<2-LeftMouse>',  api.node.open.edit, Desc("Open/Expand Folder")) -- open
                vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, Desc("Change Directory")) -- cd
                vim.keymap.set('n', '?', api.tree.toggle_help, Desc("Help")) -- help
            end,
            hijack_cursor = false,
            sync_root_with_cwd = true,
            sort = {
                sorter = "name"
            },
            view = {
                width = 30 -- change later
            },
            renderer = {
                add_trailing = true,
                special_files = {
                    "Cargo.toml",
                    "Makefile",
                    "README.md",
                    "readme.md",
                    "LICENSE",
                    "package.json",
                },
                highlight_diagnostics = "icon",
                highlight_git = "name",
                -- indent_markers = { enable = true },
            },
            diagnostics = {
                enable = true
            },
            filters = {
                git_ignored = false
            },
            filesystem_watchers = {
                enable = true
            }
        })

        vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = function()
            require('nvim-tree.api').tree.open()
        end })
    end
}
