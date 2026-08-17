vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "
vim.g.maplocalleader = ";"
-- vim.g.have_nerd_font = true
vim.o.clipboard = "unnamedplus"
vim.opt.laststatus = 3
vim.o.backspace = [[indent,eol,start]]
vim.o.ruler = false
vim.o.number = true
vim.o.relativenumber = false
vim.o.cursorline = true
vim.o.cursorcolumn = false
vim.o.showmode = false
vim.o.showcmd = true
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.undofile = true
vim.o.tabstop = 2
vim.o.softtabstop = 0
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.cmdheight = 2
vim.o.pumheight = 10
vim.o.winborder = "rounded"

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic location list" })

require("config.lazy")
require("utils")
