local dap = require "dap"
dap.configurations.lua = {
    {
        type = 'nlua',
        request = 'attach',
        name = "Attach to running Neovim instance",
        host = function()
            local value = vim.fn.input('Host [127.0.0.1]: ')
            if value ~= "" then return value end
            return '127.0.0.1'
        end,
        port = function()
            local val = tonumber(vim.fn.input('Port: '))
            assert(val, "Please provide a port number")
            return val
        end
    }
}

dap.adapters.nlua = function(callback, config)
    callback({type = 'server', host = config.host, port = config.port})
end

require('telescope').load_extension('dap')

local opts = {noremap = true, silent = true}

vim.api.nvim_set_keymap("n", "<leader>dc", "<cmd>Telescope dap commands<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>dv", "<cmd>Telescope dap variables<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>dl", "<cmd>Telescope dap list_breakpoints<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
vim.fn.sign_define("DapBreakpoint", {text = '🟥', texthl = '', linehl = '', numhl = ''})

vim.fn.sign_define('DapBreakpointRejected', {text = '🟦', texthl = '', linehl = '', numhl = ''})

vim.fn.sign_define('DapStopped', {text = '⭐️', texthl = '', linehl = '', numhl = ''})
