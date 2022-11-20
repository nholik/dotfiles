local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd [[packadd termdebug]]
local use = require('packer').use

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'glepnir/dashboard-nvim'
    use 'marko-cerovac/material.nvim'
    use 'jacoborus/tender.vim'
    use 'terrortylor/nvim-comment'
    use 'karb94/neoscroll.nvim'
    use 'numToStr/Navigator.nvim'
    use 'williamboman/nvim-lsp-installer'
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'kyazdani42/nvim-web-devicons' -- for file icons
    use 'ray-x/lsp_signature.nvim'
    use 'windwp/nvim-autopairs'
    use {"folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons"}
    use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}
    use {'feline-nvim/feline.nvim', branch = 'master'}
    use {'Hoffs/omnisharp-extended-lsp.nvim'}
    use {
        'lewis6991/gitsigns.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config = function()
            require('gitsigns').setup()
        end
    }
    use 'wlangstroth/vim-racket'
    use 'Olical/conjure'
    use 'dylon/vim-antlr'
    use 'kyazdani42/nvim-tree.lua'
    use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/plenary.nvim'}}}
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
    use 'mfussenegger/nvim-dap'
    use 'Pocco81/dap-buddy.nvim'
    use {"rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"}}
    use 'jbyuki/one-small-step-for-vimkind'
    use 'nvim-telescope/telescope-dap.nvim'
    use 'neovim/nvim-lspconfig'
    use {'jose-elias-alvarez/null-ls.nvim', requires = {'nvim-lua/plenary.nvim'}}
    use 'glepnir/lspsaga.nvim'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use 'jose-elias-alvarez/nvim-lsp-ts-utils'
    use 'ray-x/go.nvim'
    use 'ray-x/guihua.lua' -- recommanded if need floating window support
    if packer_bootstrap then require('packer').sync() end
end)
