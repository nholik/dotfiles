vim.g.mapleader = ' '
vim.o.backspace = [[indent,eol,start]]
vim.o.ruler = true
vim.o.number = true
vim.o.showcmd = true
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.tabstop = 2
vim.o.softtabstop = 0
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.cmdheight = 2
vim.cmd [[
  packadd packer.nvim
  syntax enable
  colorscheme material
]]

local use = require('packer').use

require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'marko-cerovac/material.nvim'
    use "terrortylor/nvim-comment"
    use 'kyazdani42/nvim-web-devicons' -- for file icons
    use {'nvim-lualine/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true}}
    use 'jacoborus/tender.vim'
    use 'kyazdani42/nvim-tree.lua'
    use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/plenary.nvim'}}}
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
end)

require('theme')
require('file-manager')
require('dev-config')
