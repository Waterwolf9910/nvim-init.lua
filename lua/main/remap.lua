vim.g.mapleader = " "

local default_set = vim.keymap.set

--- Table of |:map-arguments|.
--- Same as |nvim_set_keymap()| {opts}, except:
--- - {replace_keycodes} defaults to `true` if "expr" is `true`.
---
--- Also accepts:
--- @class vim.keymap.set.Opts : vim.api.keyset.keymap
--- @inlinedoc
---
--- Creates buffer-local mapping, `0` or `true` for current buffer.
--- @field buffer? integer|boolean
---
--- Make the mapping recursive. Inverse of {noremap}.
--- (Default: `false`)
--- @field remap? boolean

--- Adds a new |mapping|.
--- Examples:
---
--- ```lua
--- -- Map to a Lua function:
--- vim.keymap.set('n', 'lhs', function() print("real lua function") end)
--- -- Map to multiple modes:
--- vim.keymap.set({'n', 'v'}, '<leader>lr', vim.lsp.buf.references, { buffer = true })
--- -- Buffer-local mapping:
--- vim.keymap.set('n', '<leader>w', "<cmd>w<cr>", { silent = true, buffer = 5 })
--- -- Expr mapping:
--- vim.keymap.set('i', '<Tab>', function()
---   return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
--- end, { expr = true })
--- -- <Plug> mapping:
--- vim.keymap.set('n', '[%%', '<Plug>(MatchitNormalMultiBackward)')
--- ```
---
---@param mode string|string[] Mode short-name, see |nvim_set_keymap()|.
---                            Can also be list of modes to create mapping on multiple modes.
---@param lhs string           Left-hand side |{lhs}| of the mapping.
---@param rhs string|function  Right-hand side |{rhs}| of the mapping, can be a Lua function.
---
---@param opts? vim.keymap.set.Opts
---@see |nvim_set_keymap()|
---@see |maparg()|
---@see |mapcheck()|
---@see |mapset()|
vim.keymap.set = function (mode, lhs, rhs, opt)
    local expr = false
    if (type(mode) == 'table' and type(rhs) ~= 'function') then
        expr = true
        local _rhs = rhs
        rhs = function ()
            local prev_mode = vim.api.nvim_get_mode().mode
            local prefix = ''

            if prev_mode == 'n' or prev_mode == 'nt' then
                prev_mode = ''
            else
                prefix = '<C-c>'
            end

            if prev_mode == 'i' and vim.bo.modifiable ~= true then
                prev_mode = ''
            end
            -- vim.defer_fn(function ()
            --     -- print(debug.traceback())
            --     print(dump(mode), '|', lhs, '|', _rhs, '|', dump(opt), '|', rhs, '|', prev_mode, '|', prefix)
            -- end, 250)

            return prefix .. _rhs .. prev_mode
        end
    end
    opt = vim.tbl_extend("keep", (opt or { silent = true }), { expr = expr })
    default_set(mode, lhs, rhs, opt)
end

-- Multimode

-- Basic Editing
vim.keymap.set({ 'i', 'n' }, '<S-Del>', "dd") -- delete line
vim.keymap.set({ 'i', 'n' }, '<C-z>', vim.cmd.undo) -- redo
vim.keymap.set({ 'i', 'n' }, '<C-y>', vim.cmd.redo)              -- undo
vim.keymap.set({ 'n', 'i', 'v' }, "<Home>", ":SmartHomeKey<CR>") -- home
-- vim.keymap.set({ 'i', 'n' }, '<C-Up>', '<PageUp>')
-- vim.keymap.set({ 'i', 'n' }, '<C-Down>', '<PageDown>')
vim.keymap.set({ 'i', 'n' }, '<C-Up>', '4k') -- move 4 characters up
vim.keymap.set({ 'i', 'n' }, '<C-Down>', '4j') -- move 4 characters down
vim.keymap.set({ 'i', 'n' }, '<C-[>', '<<') -- indent left
vim.keymap.set({ 'i', 'n' }, '<C-]>', '>>') -- indent right
vim.keymap.set({'i', 'n'}, '<C-Del>', 'dw') -- delete word back 

-- Tab
vim.keymap.set({ 'i', 'n' }, "<C-t>", '<C-n>') -- New Tab (TODO)
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
vim.keymap.set({ 'i', 'n' }, '<C-f>', '<C-c>/', { silent = false })


-- Insert Mode Keybinds

-- Misc
vim.keymap.set('i', '<C-Left>', '<C-c>hbi') -- move word left
vim.keymap.set('i', '<C-Right>', '<C-c>lwi') -- move word right
vim.api.nvim_set_keymap('i', '<C-h>', '<C-w>', { noremap = true }) -- delete word forward

-- Normal Mode Keybinds

-- File explorer
vim.keymap.set('n', '<leader>e', ":NvimTreeOpen<CR>") -- open file explorer

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
vim.keymap.set('n', '<C-Left>', 'b') -- move word left
vim.keymap.set('n', '<C-Right>', 'w') -- move word right
vim.api.nvim_set_keymap('n', '<C-h>', 'i<C-w>', { silent = false, noremap = true }) -- delete word left

-- Visual Mode (Highlighting) keybinds

-- 0 to LSP - thePrimeagen
vim.keymap.set('v', '<A-Up>', ":m '<-2<CR>gv=gv") -- move highlighted region up
vim.keymap.set('v', '<A-Down>', ":m '>+1<CR>gv=gv") -- move highlighted region down

-- Misc
vim.keymap.set('v', 'c', 'y') -- copy (yank)


-- Command Mode Keybinds

vim.keymap.set('c', "<Up>", "<C-p>", { silent = false }) -- go up through history
vim.keymap.set('c', "<Down>", "<C-n>", { silent = false }) -- go down through history


-- Unmaps
--
vim.keymap.set({'n', 'v'}, 'o', '<Nop>')
