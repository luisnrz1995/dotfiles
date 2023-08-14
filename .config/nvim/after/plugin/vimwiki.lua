-- Configure VimWiki
vim.g.vimwiki_list = {{
	path = '~/vimwiki',
	syntax = 'default',
	ext = '.wiki',
	auto_header = 1,
	auto_toc = 1,
	index = 'index',
	diary_index = 'diary/index',
	template_path = '~/vimwiki/templates',
	custom_wiki2html = 'pandoc',
	auto_tags = 1,
	auto_diary_entry_template = 1,
}}

-- Key mappings to access VimWiki
vim.api.nvim_set_keymap('n', '<leader>ww', '<Plug>VimwikiIndex', {})
vim.api.nvim_set_keymap('n', '<leader>wn', '<Plug>VimwikiTabIndex', {})
vim.api.nvim_set_keymap('n', '<leader>ws', '<Plug>VimwikiUISelect', {})
vim.api.nvim_set_keymap('n', '<leader>wr', '<Plug>VimwikiUIRename', {})
vim.api.nvim_set_keymap('n', '<leader>wd', '<Plug>VimwikiDiaryGenerateLinks', {})

-- Set working directory for VimWiki files
vim.cmd[[
autocmd FileType vimwiki lcd %:p:h
autocmd BufEnter,VimEnter,WinEnter * if &ft == 'vimwiki' | lcd %:p:h | endif
]]

vim.api.nvim_set_keymap('n', '<leader>wf', [[:Telescope find_files cwd=~/vimwiki<CR>]], { noremap = true, silent = true })

-- Enable auto-saving of VimWiki files
vim.api.nvim_exec([[
augroup AutoSaveVimwiki
autocmd!
autocmd TextChanged,TextChangedI <buffer> silent! write
augroup END
]], false)

-- Language settings (Comments in English)
vim.cmd('language en_US.utf8')
