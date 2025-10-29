return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {
			panel = { enabled = false },
			suggestion = {
				enabled = true,
				auto_trigger = true,
				hide_during_completion = true,
				debounce = 75,
				keymap = {
					accept = false,
					accept_word = false,
					accept_line = false,
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
			},
			filetypes = {
				markdown = true,
				help = true,
			},
		},
		config = function(_, opts)
			local copilot = require("copilot")
			copilot.setup(opts)

			local suggestion = require("copilot.suggestion")
			local auto_trigger_on = true
			vim.keymap.set("n", "<leader>uC", function()
				auto_trigger_on = not auto_trigger_on
				suggestion.toggle_auto_trigger()
				local state = auto_trigger_on and "enabled" or "disabled"
				vim.notify("Copilot auto-suggestions " .. state, vim.log.levels.INFO, { title = "Copilot" })
			end, { desc = "Toggle Copilot auto-suggestions" })
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		optional = true,
		dependencies = { "zbirenbaum/copilot.lua" },
		opts = function(_, opts)
			opts = opts or {}
			opts.sections = opts.sections or {}
			opts.sections.lualine_x = opts.sections.lualine_x or {}

			local component = {
				function()
					local ok, status = pcall(require, "copilot.status")
					if not ok then
						return ""
					end

					local data = status.data or {}
					local status_str = (data.status or ""):lower()
					if status_str == "" then
						return ""
					end

					local icon = ""
					if status_str == "inprogress" then
						return icon .. " …"
					elseif status_str == "warning" then
						return icon .. " !"
					elseif status_str == "normal" then
						return icon
					else
						return icon .. " " .. data.status
					end
				end,
				cond = function()
					local clients = vim.lsp.get_active_clients({ name = "copilot" })
					return next(clients or {}) ~= nil
				end,
				color = function()
					local ok, status = pcall(require, "copilot.status")
					if not ok then
						return {}
					end
					local data = status.data or {}
					local status_str = (data.status or ""):lower()
					if status_str == "warning" then
						return { fg = vim.fn.synIDattr(vim.fn.hlID("DiagnosticWarn"), "fg", "gui") }
					elseif status_str == "inprogress" then
						return { fg = vim.fn.synIDattr(vim.fn.hlID("DiagnosticInfo"), "fg", "gui") }
					end
					return {}
				end,
			}

			table.insert(opts.sections.lualine_x, 1, component)
			return opts
		end,
	},
}
