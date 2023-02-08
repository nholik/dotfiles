local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

vim.cmd [[packadd termdebug]]

require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- languageserver plugins
  use {
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      -- 'williamboman/nvim-lsp-installer'
      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
      -- additional lsp helpers
      'ray-x/lsp_signature.nvim',
      'Hoffs/omnisharp-extended-lsp.nvim',
      'wlangstroth/vim-racket',
      'Olical/conjure',
      'dylon/vim-antlr',
      'glepnir/lspsaga.nvim',
      'jose-elias-alvarez/nvim-lsp-ts-utils',
      'j-hui/fidget.nvim'
    }
  }

  use 'ray-x/go.nvim'

  -- auto completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin

  use 'glepnir/dashboard-nvim'
  use 'marko-cerovac/material.nvim'
  use 'kyazdani42/nvim-tree.lua'

  use 'jacoborus/tender.vim'
  use 'terrortylor/nvim-comment'
  use 'karb94/neoscroll.nvim'
  use 'numToStr/Navigator.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'kyazdani42/nvim-web-devicons' -- for file icons
  use 'windwp/nvim-autopairs'
  use { "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons" }

  use { 'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons' }
  use { 'feline-nvim/feline.nvim', branch = 'master' }
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup()
    end
  }


  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

  use 'mfussenegger/nvim-dap'
  use 'Pocco81/dap-buddy.nvim'
  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }

  use 'jbyuki/one-small-step-for-vimkind'
  use 'nvim-telescope/telescope-dap.nvim'
  use { 'jose-elias-alvarez/null-ls.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use 'ray-x/guihua.lua' -- recommanded if need floating window support
  if packer_bootstrap then require('packer').sync() end
end)
