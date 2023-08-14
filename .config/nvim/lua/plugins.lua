-- Import Packer
local packer = require('packer')
local use = packer.use

-- Start Packer
packer.startup(function()
	-- Packer itself
	use {'wbthomason/packer.nvim'}

	-- Autopairs
	use 'windwp/nvim-autopairs'

	-- Code Highlighting and Parsing
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
	}

	-- Commenting
	use 'terrortylor/nvim-comment'

	-- File Navigation and Exploration
	use {
		'nvim-tree/nvim-tree.lua',
		requires = 'nvim-tree/nvim-web-devicons',
	}

	-- Git Integration
	use {
		'lewis6991/gitsigns.nvim',
		'kdheepak/lazygit.nvim',
		'tpope/vim-fugitive',
	}

	-- LSP Support and Autocompletion
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			'neovim/nvim-lspconfig',
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			'hrsh7th/nvim-cmp',
			'hrsh7th/cmp-nvim-lsp',
			'L3MON4D3/LuaSnip',
		},
	}

	-- Live Server for Web Development
	use 'barrett-ruth/live-server.nvim'

	-- Note Taking and Documentation
	use {
		'nvim-neorg/neorg',
		'vimwiki/vimwiki'
	}

	-- Markdown preview
	use({
		"iamcco/markdown-preview.nvim",
		run = function() vim.fn["mkdp#util#install"]() end,
	})

	-- Searching and Fuzzy Finding
	use {
		'nvim-telescope/telescope.nvim',
		requires = 'nvim-lua/plenary.nvim',
	}

	-- Syntax Highlighting for Configuration Files
	use 'kovetskiy/sxhkd-vim'

	-- Temrinal emulator
	use 'akinsho/toggleterm.nvim'

	-- UI and Appearance
	use {
		'folke/tokyonight.nvim',
		'tribela/vim-transparent',
		'goolord/alpha-nvim',
		'folke/zen-mode.nvim',
		'akinsho/bufferline.nvim',
		'petertriho/nvim-scrollbar',
		'nvim-lualine/lualine.nvim',
		'wfxr/minimap.vim',
		'lilydjwg/colorizer',
		'utilyre/barbecue.nvim',
		'SmiteshP/nvim-navic',
		'lukas-reineke/indent-blankline.nvim',
		'adelarsq/image_preview.nvim'
	}
end)
