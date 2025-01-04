vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "
vim.g.maplocalleader = ";"
-- vim.g.have_nerd_font = true
vim.o.clipboard = "unnamedplus"
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

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

require("config.lazy")
require("utils")
