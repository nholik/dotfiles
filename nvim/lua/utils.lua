require("Navigator").setup()

-- Keybindings for vim Navigator
vim.keymap.set({ "n", "t" }, "<C-h>", "<CMD>NavigatorLeft<CR>", { desc = "Move to left split or tmux pane" })
vim.keymap.set({ "n", "t" }, "<C-l>", "<CMD>NavigatorRight<CR>", { desc = "Move to right split or tmux pane" })
vim.keymap.set({ "n", "t" }, "<C-k>", "<CMD>NavigatorUp<CR>", { desc = "Move to upper split or tmux pane" })
vim.keymap.set({ "n", "t" }, "<C-j>", "<CMD>NavigatorDown<CR>", { desc = "Move to lower split or tmux pane" })

vim.keymap.set("n", "<M-l>", "<CMD>vertical resize +1<CR>", { desc = "Increase window width" })
vim.keymap.set("n", "<M-h>", "<CMD>vertical resize -1<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<M-k>", "<CMD>resize +1<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<M-j>", "<CMD>resize -1<CR>", { desc = "Decrease window height" })
