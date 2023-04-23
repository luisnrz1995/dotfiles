-- Define map leader as space
vim.g.mapleader = ' '

-- Open netrw
vim.api.nvim_set_keymap('n', '<Leader>pv', ':Explore<CR>', { noremap = true, silent = true })

-- Go to next buffer
vim.api.nvim_set_keymap('n', '<A-.>', ':bn<CR>', { noremap = true })

-- Go to previous buffer
vim.api.nvim_set_keymap('n', '<A-,>', ':bp<CR>', { noremap = true })

-- Close current buffer
vim.api.nvim_set_keymap('n', '<A-x>', ':bd<CR>', { noremap = true })

-- Move selected code through the current file
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true })

-- Opem a terminal
vim.api.nvim_set_keymap('n', '<C-t>', ':lua Open_terminal()<CR>', { noremap = true, silent = true })

-- Define keymap to exit from terminal mode to normal mode
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true })
