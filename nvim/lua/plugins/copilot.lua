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
		dependencies = {
			"zbirenbaum/copilot.lua",
			"AndreM222/copilot-lualine",
		},
		opts = function(_, opts)
			opts = opts or {}
			opts.sections = opts.sections or {}
			opts.sections.lualine_x = opts.sections.lualine_x or {}

			local has_copilot = false
			for _, component in ipairs(opts.sections.lualine_x) do
				if component == "copilot" then
					has_copilot = true
					break
				elseif type(component) == "table" and component[1] == "copilot" then
					has_copilot = true
					break
				end
			end

			if not has_copilot then
				table.insert(opts.sections.lualine_x, 1, "copilot")
			end

			return opts
		end,
	},
}
