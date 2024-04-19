return {
    'folke/lazy.nvim',
    'nvim-neotest/nvim-nio',
    'lbrayner/vim-rzip',
    'vim-scripts/Smart-Home-Key',
    {'tpope/vim-commentary',
        config = function()
            -- vim.keymap.set({ 'n', 'i' }, '<C-_>', 'gcc', { silent = true })
            -- vim.keymap.set('v', '<C-_>', 'gc', { silent = true })
        end
    },
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        config = function(spec)
            require('tokyonight').setup({
                style = "moon",
                dim_inactive = true
            })
            vim.cmd.colorscheme('tokyonight-moon')
        end
    },
    {
        'tpope/vim-fugitive',
        config = function(spec)
            vim.keymap.set('n', '<leader>gg', vim.cmd.Git)
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', 'folke/tokyonight.nvim' },
        config = function(spec)
            require('lualine').setup {
                options = {
                    theme = 'tokyonight'
                }
            }
        end
    },
    {
        'mbbill/undotree',
        config = function(spec)
            vim.keymap.set('n', 'u', vim.cmd.UndotreeToggle)
            vim.g.undo_tree_WindowLayout = 4
        end
    }
}
