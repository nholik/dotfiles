return {
	{
		"Vigemus/iron.nvim",
		keys = {
			{ "<leader>rr", "<cmd>IronRepl<cr>", desc = "Toggle REPL" },
			{ "<leader>rR", "<cmd>IronRestart<cr>", desc = "Restart REPL" },
			{
				"<leader>rl",
				function()
					require("iron.core").send_line()
				end,
				desc = "Send Line to REPL",
			},
			{
				"<leader>rs",
				function()
					require("iron.core").visual_send()
				end,
				mode = "x",
				desc = "Send Selection to REPL",
			},
			{
				"<leader>rp",
				function()
					require("iron.core").send_paragraph()
				end,
				desc = "Send Paragraph to REPL",
			},
			{
				"<leader>rf",
				function()
					require("iron.core").send_file()
				end,
				desc = "Send File to REPL",
			},
			{
				"<leader>rc",
				function()
					require("iron.core").clear()
				end,
				desc = "Clear REPL",
			},
		},
		config = function()
			local common = require("iron.fts.common")
			local view = require("iron.view")

			require("iron.core").setup({
				config = {
					scratch_repl = true,
					repl_definition = {
						python = {
							command = { "python" },
							format = common.bracketed_paste_python,
							block_dividers = { "# %%", "#%%" },
						},
						javascript = { command = { "node" } },
						lua = { command = { "lua" } },
						racket = { command = { "racket", "-i" } },
						scheme = { command = { "racket", "-i" } },
					},
					repl_filetype = function(_, filetype)
						return filetype
					end,
					dap_integration = false,
					repl_open_cmd = view.split.belowright("30%", {
						winbar = " 󰆍  REPL ",
						winfixheight = true,
						winfixwidth = false,
					}),
				},
				ignore_blank_lines = true,
			})
		end,
	},
	{
		"folke/flash.nvim",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash Jump",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "modern",
			win = {
				width = 0.8,
				height = { min = 4, max = 18 },
				border = "rounded",
				padding = { 1, 2 },
			},
			layout = {
				width = { min = 18, max = 32 },
				spacing = 2,
			},
			icons = {
				mappings = false,
				separator = "→",
				group = "+",
			},
			spec = {
				{ "<leader>c", group = "code" },
				{ "<leader>g", group = "git" },
				{ "<leader>h", group = "git hunks" },
				{ "<leader>r", group = "run / REPL" },
				{ "<leader>s", group = "search / recall" },
				{ "<leader>t", group = "git toggles" },
				{ "<leader>u", group = "toggles" },
				{ "<leader>x", group = "trouble" },
			},
		},
	},
	{
		"MagicDuck/grug-far.nvim",
		cmd = { "GrugFar", "GrugFarWithin" },
		opts = {
			showCompactInputs = true,
			showInputsTopPadding = false,
			showEngineInfo = false,
		},
		keys = {
			{ "<leader>sR", "<cmd>GrugFar<cr>", desc = "Search and Replace Project" },
			{ "<leader>sR", ":GrugFar<cr>", mode = "x", desc = "Search Selection in Project" },
		},
	},
}
