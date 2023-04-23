require('telescope').setup({
  defaults = {
    sorting_strategy = 'ascending',
    layout_config = {
      horizontal = { width = { 0.9, max = 250 } }
    },
  },
})

require("telescope").load_extension "file_browser"

vim.keymap.set('n', '<C-n>', ':Telescope file_browser<CR>')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function ()
  builtin.grep_string({ search = vim.fn.input('Grep > ') });
end)
