return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
            "hrsh7th/nvim-cmp"
        },
        config = function (_spec)
            require("noice.init").setup({
                cmdline = {
                    enabled = true,
                    view = "cmdline_popup"
                },
                messages = {
                    enabled = true,
                    view = "notify",
                    view_history = "vsplit"
                },
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    }
                },
                presets = {
                    command_palette = true,
                    lsp_doc_border = true
                }
            })
            require("telescope.init").load_extension("noice")
        end
    },
    -- {
    --     'j-hui/fidget.nvim',
    --     dependencies = {
    --         'nvim-tree/nvim-tree.lua',
    --     },
    --     config = function ()
    --          require("fidget").setup({
    --             progress = {
    --                 display = {
    --                     done_ttl = 7,
    --                 },
    --             },
    --             notification = {
    --                 history_size = 256,
    --                 override_vim_notify = true,
    --                 window = {
    --                     winblend = 70,
    --                     border = 'shadow'
    --                 }
    --             },

    --             logger = {
    --                 level = vim.log.levels.INFO
    --             },

    --             integration = {
    --                 ["nvim-tree"] = {
    --                     enable = true
    --                 }
    --             }
    --         })
    --     end
    -- }
}
