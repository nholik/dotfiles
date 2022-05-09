local function setup_telescope()
    require('telescope').setup {
        extensions = {
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case" -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            }
        }
    }
    require('telescope').load_extension('fzf')
    local opts = {noremap = true, silent = true}

    vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
    vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts)
    vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)
    vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts)
end

setup_telescope()
