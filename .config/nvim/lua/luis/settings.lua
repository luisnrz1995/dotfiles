-- Neovim native settings
vim.opt.title = true

vim.opt.background = 'dark'
vim.opt.syntax = 'on'
vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smarttab = true
vim.opt.tabstop = 2

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false

vim.opt.wrap = false

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.clipboard = 'unnamedplus'

vim.opt.mouse = 'a'

vim.opt.scrolloff = 5

vim.opt.colorcolumn = "100"
vim.opt.cursorcolumn = true
vim.opt.cursorline = true

vim.opt.showmode = false

vim.opt.signcolumn = 'no'

vim.opt.list = true
vim.opt.listchars:append "eol:↴"

-- vim.opt.guicursor = "a:blinkon0"

-- Define some autocmds
vim.api.nvim_create_autocmd('VimEnter', {command = 'highlight Normal guibg=NONE ctermbg=NONE'})
vim.api.nvim_create_autocmd('VimEnter', {command = 'highlight NormalFloat guibg=NONE ctermbg=NONE'})
vim.api.nvim_create_autocmd('VimEnter', {command = 'highlight Pmenu guibg=NONE ctermbg=NONE'})
vim.api.nvim_create_autocmd('VimEnter', {command = 'highlight statusline guibg=NONE ctermbg=NONE'})

vim.api.nvim_create_autocmd('FileType', {command = 'set fo-=c fo-=r fo-=o' })

-- Functions
function Open_terminal()
  vim.api.nvim_command('split')
  vim.api.nvim_command('terminal')
  vim.api.nvim_command('resize 20')
end

vim.api.nvim_create_autocmd('TermOpen', {command = 'startinsert'})
vim.api.nvim_create_autocmd('TermOpen', {command = 'set nocursorcolumn nocursorline nonumber norelativenumber'})
vim.api.nvim_create_autocmd('TermClose', {command = 'call feedkeys("i")'})
