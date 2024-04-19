vim.opt.nu = true

-- Window control
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.equalalways = true

-- Tabs and indentations
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

-- Undo, Backup and Copy
-- vim.opt.uc = 100 -- updatecount
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("state") .. "/undodir"
vim.opt.undofile = true
vim.opt.clipboard='unnamedplus'
if os.getenv("WSL_DISTRO_NAME") ~= nil or os.getenv("WSL_INTEROP") ~= nil then
    vim.g.clipboard = {
        name = "WslClipboard",
        copy = {
            ['+'] = "clip.exe",
            ['*'] = "clip.exe"
        },
        paste = {
            ['+'] = "powershell.exe -c [Console]::Out.Write($(Get-Clipboard - Raw).tostring().replace('`r', ''))",
            ['*'] = "powershell.exe -c [Console]::Out.Write($(Get-Clipboard - Raw).tostring().replace('`r', ''))"
        },
        cache_enabled = 0
    }
end


-- Find
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true

--- Misc
vim.opt.diffopt = vim.opt.diffopt + ',vertical'
vim.opt.fileformat = 'unix'
vim.opt.fileformats = 'unix'
vim.opt.fixeol = true
vim.opt.eof = true
