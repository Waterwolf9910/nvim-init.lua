vim.g.mapleader = " "

local default_set = vim.keymap.set

vim.keymap.set = function (mode, lhs, rhs, opt)
    local expr = false
    if (type(mode) == 'table' and type(rhs) ~= 'function') then
        expr = true
        local _rhs = rhs
        rhs = function ()
            local prev_mode = vim.api.nvim_get_mode().mode
            -- vim.defer_fn(function ()
            --     print(debug.traceback())
            --     print(rhs, prev_mode, mode, _rhs, opt)
            -- end, 250)
            local prefix = ''

            if prev_mode == 'n' or prev_mode == 'nt' then
                prev_mode = ''
            else
                prefix = '<C-c>'
            end

            if prev_mode == 'i' and vim.bo.modifiable ~= true then
                prev_mode = ''
            end

            return prefix .. _rhs .. prev_mode
        end
    end
    opt = opt or { silent = true, expr = expr }
    default_set(mode, lhs, rhs, opt)
end

-- Multimode

-- Basic Editing
vim.keymap.set({ 'i', 'n' }, '<C-Del>', "dd") -- delete line
vim.keymap.set({ 'i', 'n' }, '<C-z>', vim.cmd.undo) -- redo
vim.keymap.set({ 'i', 'n' }, '<C-y>', vim.cmd.redo)              -- undo
vim.keymap.set({ 'n', 'i', 'v' }, "<Home>", ":SmartHomeKey<CR>") -- home
-- vim.keymap.set({ 'i', 'n' }, '<C-Up>', '<PageUp>')
-- vim.keymap.set({ 'i', 'n' }, '<C-Down>', '<PageDown>')
vim.keymap.set({ 'i', 'n' }, '<C-Up>', '8k') -- move 8 characters up
vim.keymap.set({ 'i', 'n' }, '<C-Down>', '8j') -- move 8 characters down
vim.keymap.set({ 'i', 'n' }, '<C-Left>', 'b') -- move word left
vim.keymap.set({ 'i', 'n' }, '<C-Right>', 'w') -- move word right

-- Tab
vim.keymap.set({ 'i', 'n' }, '<C-\\>', ":vsplit<CR>") -- vertically split buffer
vim.keymap.set({ 'i', 'n' }, '<C-S-Left>', ":tabp<CR>") -- tab back
vim.keymap.set({ 'i', 'n' }, '<C-S-Right>', ":tabn<CR>") -- tab forward

-- Window
vim.keymap.set({ 'i', 'n' }, '<S-Up>', ":wincmd k<CR>") -- move cursor to window up
vim.keymap.set({ 'i', 'n' }, '<S-Down>', ":wincmd j<CR>") -- move cursor to window down
vim.keymap.set({ 'i', 'n' }, '<S-Left>', ":wincmd h<CR>") -- move cursor to window left
vim.keymap.set({ 'i', 'n' }, '<S-Right>', ":wincmd l<CR>") -- move cursor to window right

-- Buffers
vim.keymap.set({ 'i', 'n' }, '<A-Up>', ':bn<CR>')  -- goto next buffer
vim.keymap.set({ 'i', 'n' }, '<A-Down>', ':bp<CR>')  -- goto prev buffer
vim.keymap.set({ 'i', 'n' }, '<A-Left>', '5zh')  -- shift buffer view 5 left
vim.keymap.set({ 'i', 'n' }, '<A-Right>', '5zl') -- shift buffer view 5 right

-- Misc
vim.keymap.set({ 'i', 'n' }, "<C-b>", ":NvimTreeToggle<CR>") -- toggle explorer


-- Insert Mode Keybinds

vim.keymap.set('i', '<C-f>', '<C-c>/', { silent = false })


-- Normal Mode Keybinds

-- File explorer
vim.keymap.set("n", '<leader>e', ":NvimTreeOpen<CR>") -- open file explorer

-- Tabs
vim.keymap.set('n', '<leader>tn', ":tabnew<CR>:NvimTreeOpen<CR>") -- create new tab
vim.keymap.set('n', "<C-n>", ":tabnew<CR>:NvimTreeOpen<CR>") -- create new tab
vim.keymap.set('n', "<leader>tc", ":tabclose<CR>") -- close tab
vim.keymap.set('n', "<leader>tw", ":tabclose<CR>") -- close tab
vim.keymap.set('n', "<C-w>", ":tabclose<CR>") -- close tab
vim.keymap.set('n', "<C-S-w>", ":tabonly<CR>") -- close all tabs but current

-- Windows
vim.keymap.set('n', "<leader>w<Up>", ":above new<CR>") -- create window above
vim.keymap.set('n', "<leader>w<Down>", ":below new<CR>") -- create window below
vim.keymap.set('n', "<leader>w<Left>", ":lefta vnew<CR>") -- create window left
vim.keymap.set('n', "<leader>w<Right>", ":rightb vnew<CR>") -- create window right
vim.keymap.set('n', "<leader>we", ":wincmd =<CR>") -- equalize window layout
vim.keymap.set('n', "<leader>ww", ":q<CR>") -- close window
vim.keymap.set('n', "<leader>W", ":qa<CR>") -- close all windows (quit vim)

-- Misc
vim.keymap.set('n', "<leader>q", ":bd<CR>") -- close buffer


-- Visual Mode (Highlighting) keybinds

-- 0 to LSP - thePrimeagen
vim.keymap.set('v', '<A-Up>', ":m '<-2<CR>gv=gv") -- move highlighted region up
vim.keymap.set('v', '<A-Down>', ":m '>+1<CR>gv=gv") -- move highlighted region down

-- Misc
vim.keymap.set('v', 'c', 'y') -- copy (yank)


-- Command Mode Keybinds

vim.keymap.set('c', "<Up>", "<C-p>", { silent = false }) -- go up through history
vim.keymap.set('c', "<Down>", "<C-n>", { silent = false }) -- go down through history
