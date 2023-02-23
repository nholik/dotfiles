local dap = require('dap')
local dapui = require('dapui')
dapui.setup()

require('dap-go').setup()
require('dap.ext.vscode').load_launchjs(nil, {})

vim.keymap.set('n', '<F5>', require 'dap'.continue)
vim.keymap.set('n', '<F10>', require 'dap'.step_over)
vim.keymap.set('n', '<F11>', require 'dap'.step_into)
vim.keymap.set('n', '<F12>', require 'dap'.step_out)
vim.keymap.set('n', '<F9>', require 'dap'.toggle_breakpoint)
vim.keymap.set('n', "<leader>di", require 'dapui'.eval, { desc = "DAP inspect" })
vim.keymap.set('n', "<leader>dc", "<cmd>Telescope dap commands<CR>", { desc = "DAP commands" })
vim.keymap.set('n', "<leader>dv", "<cmd>Telescope dap variables<CR>", { desc = "DAP variables" })
vim.keymap.set('n', "<leader>dl", "<cmd>Telescope dap list_breakpoints<CR>", { desc = "DAP list breakpoints" })
require('telescope').load_extension('dap')
vim.fn.sign_define('DapBreakpoint', { text = '🟥', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '▶️', texthl = '', linehl = '', numhl = '' })

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
-- require("dapui").setup({
--   icons = { expanded = "▾", collapsed = "▸" },
--   mappings = {
--     -- Use a table to apply multiple mappings
--     expand = { "<CR>", "<2-LeftMouse>" },
--     open = "o",
--     remove = "d",
--     edit = "e",
--     repl = "r",
--     toggle = "t"
--   },
--   -- Expand lines larger than the window
--   -- Requires >= 0.7
--   expand_lines = true,
--   -- Layouts define sections of the screen to place windows.
--   -- The position can be "left", "right", "top" or "bottom".
--   -- The size specifies the height/width depending on position.
--   -- Elements are the elements shown in the layout (in order).
--   -- Layouts are opened in order so that earlier layouts take priority in window sizing.
--   layouts = {
--     {
--       elements = {
--         -- Elements can be strings or table with id and size keys.
--         { id = "scopes", size = 0.25 }, "breakpoints", "stacks", "watches"
--       },
--       size = 40,
--       position = "left"
--     }, { elements = { "repl", "console" }, size = 10, position = "bottom" }
--   },
--   floating = {
--     max_height = nil, -- These can be integers or a float between 0 and 1.
--     max_width = nil, -- Floats will be treated as percentage of your screen.
--     border = "single", -- Border style. Can be "single", "double" or "rounded"
--     mappings = { close = { "q", "<Esc>" } }
--   },
--   windows = { indent = 1 },
--   render = {
--     max_type_length = nil -- Can be integer or nil.
--   }
-- })
--
-- require('telescope').load_extension('dap')
--
-- --local opts = { noremap = true, silent = true }
--
-- local nmap = function(keys, func, desc)
--   if desc then
--     desc = 'DAP: ' .. desc
--   end
--   vim.keymap.set('n', keys, func, { desc = desc })
-- end
--
-- nmap("<F5>", dap.continue, "Continue")
-- --"<cmd>lua require'dap'.continue()<CR>"
-- nmap("<F9>", dap.toggle_breakpoint, "Toggle Breakpoint")
-- -- "<cmd>lua require'dap'.toggle_breakpoint()<CR>"
-- nmap("<F10>", "<cmd>lua require'dap'.step_over()<CR>", "Step Over")
-- nmap("<F11>", "<cmd>lua require'dap'.step_into()<CR>", "Step Into")
--
-- nmap("<leader>dc", "<cmd>Telescope dap commands<CR>", "Commands")
-- nmap("<leader>dv", "<cmd>Telescope dap variables<CR>", "Variables")
-- nmap("<leader>dl", "<cmd>Telescope dap list_breakpoints<CR>", "List Breakpoints")
--
-- nmap("<leader>dx", "<cmd>lua require'dap'.terminate()<CR>", "")
-- nmap("<leader>dq", "<cmd>lua require'dap'.close()<CR>", "")
-- nmap("<leader>dr", "<cmd>lua require'dap'.run_to_cursor()<CR>", "")
-- nmap("<leader>dh", "<cmd>lua dap.ui.widgets'.hover()<CR>", "")
-- nmap("<leader>dd", "<cmd>lua require'dap'.repl.toggle()<CR>", "")
-- nmap("<leader>du", "<cmd>lua require'dapui'.toggle()<CR>", "")
--
-- -- 🟦⭐️🟥
--
-- vim.fn.sign_define("DapBreakpoint", { text = '"', texthl = '', linehl = '', numhl = '' })
--
-- vim.fn.sign_define('DapBreakpointRejected', { text = '🟦', texthl = '', linehl = '', numhl = '' })
--
-- vim.fn.sign_define('DapStopped', { text = '', texthl = '', linehl = '', numhl = '' })

-- local dap = require "dap"
--
-- dap.adapters.lldb = { type = 'executable', command = '/home/max/bin/lldb-vscode', name = 'lldb' }
-- dap.configurations.cpp = {
--   {
--     name = 'Launch',
--     type = 'lldb',
--     request = 'launch',
--     program = function()
--       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--     end,
--     cwd = '${workspaceFolder}',
--     stopOnEntry = false,
--     args = {}
--   }
-- }
--
-- dap.configurations.c = dap.configurations.cpp
--
-- dap.configurations.lua = {
--   {
--     type = 'nlua',
--     request = 'attach',
--     name = "Attach to running Neovim instance",
--     host = function()
--       local value = vim.fn.input('Host [127.0.0.1]: ')
--       if value ~= "" then return value end
--       return '127.0.0.1'
--     end,
--     port = function()
--       local val = tonumber(vim.fn.input('Port: '))
--       assert(val, "Please provide a port number")
--       return val
--     end
--   }
-- }
--
-- dap.adapters.nlua = function(callback, config)
--   callback({ type = 'server', host = config.host, port = config.port })
-- end
