return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.3',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        config = function (spec)
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
            vim.keymap.set('n', '<leader>gs', function ()
                builtin.grep_string({ search = vim.fn.input("Grep Search> ") })
            end)
        end
    }
}
