-- Neovim Configuration

-- General Settings
vim.opt.autochdir = true
vim.opt.autoindent = true
vim.opt.backup = false
vim.opt.backspace = 'start,eol,indent'
vim.opt.background = 'dark'
vim.opt.clipboard = 'unnamedplus'
vim.opt.colorcolumn = '120'
vim.opt.cursorline = true
vim.opt.expandtab = false
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 3
vim.opt.shiftwidth = 2
vim.opt.showmode = false
vim.opt.signcolumn = 'yes'
vim.opt.smarttab = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.syntax = 'on'
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.wrap = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Dashboard
function Dashboard()
	vim.api.nvim_command("cd ~ | Alpha")
end


vim.api.nvim_create_autocmd('TermOpen', {command = 'startinsert | set nocursorcolumn nocursorline nonumber norelativenumber'})

-- Function to toggle the hlsearch state
function ToggleHlSearch()
	if vim.fn.exists('g:hlsearch_state') == 0 then
		vim.g.hlsearch_state = 1
	end

	if vim.g.hlsearch_state == 1 then
		vim.opt.hlsearch = false
		vim.g.hlsearch_state = 0
	else
		vim.opt.hlsearch = true
		vim.g.hlsearch_state = 1
	end
end


-- Highlighting Settings
vim.api.nvim_create_autocmd('VimEnter', {command = 'highlight ColorColumn guibg=#24293b'})
vim.api.nvim_create_autocmd('VimEnter', {command = 'highlight WinSeparator guibg=None guifg=#3B4261'})

-- Statusline Settings
vim.api.nvim_create_autocmd('VimEnter', {command = 'set laststatus=3'})

-- Disable Autocomment for New Lines
vim.api.nvim_create_autocmd('VimEnter', {command = 'setlocal fo-=c fo-=r fo-=o'})

-- Markdown Settings
vim.api.nvim_create_autocmd('FileType markdown', {command = 'setlocal wrap linebreak textwidth=80 formatoptions+=j'})
