require('telescope').setup({
	defaults = {
		sorting_strategy = 'ascending',
		layout_config = {
			horizontal = { width = { 0.9, max = 250 } }
		}
	}
})

vim.keymap.set('n', '<leader>pf', ':Telescope find_files hidden=true<CR>', {})
vim.keymap.set('n', '<leader>gf', ':Telescope git_files hidden=true<CR>', {})
vim.keymap.set('n', '<leader>ps', ':Telescope grep_string<CR>', {})
