vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = ' '
vim.g.maplocalleader = ';'
vim.o.clipboard = 'unnamedplus'
-- vim.g.dashboard_default_executive = 'telescope'
vim.opt.laststatus = 3
vim.wo.number = true
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
vim.cmd([[
augroup setlinenums
  autocmd!
  au BufRead * set number
augroup setlinenums END
]])
-- vim.cmd [[
--   packadd packer.nvim
--   hi clear CursorLine
--   augroup CLClear
--     autocmd! ColorScheme * hi clear CursorLine
--   augroup END
--   hi CursorLineNR cterm=bold
--   augroup CLNRSet
--     autocmd! ColorScheme * hi CursorLineNR cterm=bold
--   augroup END
--   set cursorline
--   au BufRead,BufNewFile *.g set filetype=antlr3
--   au BufRead,BufNewFile *.g4 set filetype=antlr4
--   autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
-- ]]

require('plugins')
require('utils')
require('theme')
require('file-manager')
require('dev-config')
require('telescope-config')
require('debugger')
