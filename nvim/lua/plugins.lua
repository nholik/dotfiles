local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local use = require('packer').use

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'glepnir/dashboard-nvim'
    use 'marko-cerovac/material.nvim'
    use 'jacoborus/tender.vim'
    use 'terrortylor/nvim-comment'
    use 'karb94/neoscroll.nvim'
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'kyazdani42/nvim-web-devicons' -- for file icons
    use 'ray-x/lsp_signature.nvim'
    use 'windwp/nvim-autopairs'
    use {"folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons"}
    use {'feline-nvim/feline.nvim', branch = 'develop'}
    use {'Hoffs/omnisharp-extended-lsp.nvim'}
    use {
        'lewis6991/gitsigns.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config = function()
            require('gitsigns').setup()
        end
    }
    -- use {'nvim-lualine/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true}}
    use 'wlangstroth/vim-racket'
    use 'Olical/conjure'
    use 'dylon/vim-antlr'
    use 'kyazdani42/nvim-tree.lua'
    use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/plenary.nvim'}}}
    use 'mfussenegger/nvim-dap'
    use 'jbyuki/one-small-step-for-vimkind'
    use 'nvim-telescope/telescope-dap.nvim'
    use {"rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"}}
    use 'neovim/nvim-lspconfig'
    use 'glepnir/lspsaga.nvim'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use 'jose-elias-alvarez/nvim-lsp-ts-utils'
    if packer_bootstrap then require('packer').sync() end
end)
