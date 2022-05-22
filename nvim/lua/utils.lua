require('neoscroll').setup()

require('Navigator').setup()

-- Keybindings for vim Navigator
vim.keymap.set('n', "<C-h>", '<CMD>NavigatorLeft<CR>')
vim.keymap.set('n', "<C-l>", '<CMD>NavigatorRight<CR>')
vim.keymap.set('n', "<C-k>", '<CMD>NavigatorUp<CR>')
vim.keymap.set('n', "<C-j>", '<CMD>NavigatorDown<CR>')

vim.keymap.set('n', "<M-l>", '<CMD>vertical resize +1<CR>')
vim.keymap.set('n', "<M-h>", '<CMD>vertical resize -1<CR>')
vim.keymap.set('n', "<M-k>", '<CMD>resize +1<CR>')
vim.keymap.set('n', "<M-j>", '<CMD>resize -1<CR>')
-- vim.keymap.set('n', "<M-l>", '<CMD>resize -5<CR>')
-- vim.keymap.set('n', "<A-p>", '<CMD>NavigatorPrevious<CR>')
