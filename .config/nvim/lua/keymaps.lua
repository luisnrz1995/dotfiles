-- Define map leader as space
vim.g.mapleader = ' '

-- Keymap helper function
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Open file explorer
map('n', '<C-b>', ':NvimTreeToggle<CR>', opts)

-- Go to next buffer
map('n', '<A-.>', ':BufferLineCycleNext<CR>', opts)

-- Go to previous buffer
map('n', '<A-,>', ':BufferLineCyclePrev<CR>', opts)

-- Close current buffer
map('n', '<A-x>', ':bdelete<CR>', opts)

-- Move selected code through the current file
map('x', 'J', ":m '>+1<CR>gv=gv", opts)
map('x', 'K', ":m '<-2<CR>gv=gv", opts)

-- Open a terminal
map('n', '<C-t>', ':ToggleTerm<CR>', opts)

-- Disable hlsearch
map('n', '<F5>', ':lua ToggleHlSearch()<CR>', opts)

-- Define keymap to exit from terminal mode to normal mode
map('t', '<Esc>', '<C-\\><C-n>', opts)

-- Move around windows
map('n', '<C-h>', ':wincmd h<CR>', opts)
map('n', '<C-j>', ':wincmd j<CR>', opts)
map('n', '<C-k>', ':wincmd k<CR>', opts)
map('n', '<C-l>', ':wincmd l<CR>', opts)

-- Toggle minimap
map('n', '<leader>m', ':MinimapToggle<CR>', opts)

-- Dashboard
map('n', '<leader>a', ':lua Dashboard()<CR>', opts)

-- Toggle zen mode
map('n', '<leader>z', ':ZenMode<CR>', opts)
