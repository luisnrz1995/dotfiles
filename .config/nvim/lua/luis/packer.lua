return require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  -- Appearance
  use 'sainnhe/gruvbox-material'
  use 'tribela/vim-transparent'
  use 'nvim-tree/nvim-web-devicons'

  -- Syntax highlighting
  use 'nvim-treesitter/nvim-treesitter'
  use 'lilydjwg/colorizer'
  use 'kovetskiy/sxhkd-vim'

  -- LSP
  use 'VonHeikemen/lsp-zero.nvim'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/LuaSnip'

  -- Tools
  use 'jiangmiao/auto-pairs'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'tpope/vim-commentary'
  use 'ThePrimeagen/harpoon'
  use "lukas-reineke/indent-blankline.nvim"
end)
