vim.g.mapleader = ' '
vim.g.dashboard_default_executive = 'telescope'

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
]]

vim.api.nvim_set_keymap("n", ">", "gt", {noremap = true})
vim.api.nvim_set_keymap("n", "<", "gT", {noremap = true})

require('plugins')
require('utils')
require('theme')
require('file-manager')
require('dev-config')
