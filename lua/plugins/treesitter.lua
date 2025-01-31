return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        config = function (spec)
            require("nvim-treesitter.install").prefer_git = true

            ---@diagnostic disable-next-line: missing-fields
            require('nvim-treesitter.configs').setup({
                auto_install = true,
                -- A list of parser names, or "all" (the five listed parsers should always be installed)
                ensure_installed = {
                    "c", "cpp", "lua",
                    "java", "kotlin",
                    "javascript", "typescript",
                    "css", "c_sharp", "rust",
                    "query", "css", "diff",
                    "json", "json5", "jsonc",
                    "make", "python", "html",
                    "bash", "cmake", "comment",
                    "dockerfile", "gdscript", "git_config",
                    "gitignore", "godot_resource", "scss",
                    "sql", "tsx", "yaml"
                },

                indent = {
                    enable = true
                },

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                highlight = {
                    enable = true,

                    disable = function (lang, buf)
                        if lang == 'vimdoc' then
                            return true
                        end

                        local max_filesize = 1024 * 1024 * 10 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = false,
                },
            })
        end
    }
}
