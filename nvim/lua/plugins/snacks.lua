local function terminal_cwd()
	local root = Snacks.git.get_root()
	if root then
		return root
	end

	local file = vim.api.nvim_buf_get_name(0)
	if file ~= "" and vim.bo.buftype == "" then
		file = vim.fs.normalize(file)
		local scratch_root = vim.fs.normalize(vim.fn.stdpath("data") .. "/scratch") .. "/"
		if file:sub(1, #scratch_root) == scratch_root then
			for _, scratch in ipairs(Snacks.scratch.list()) do
				if scratch.file == file and scratch.cwd then
					return scratch.cwd
				end
			end
		end
		return vim.fs.dirname(file)
	end

	return (vim.uv or vim.loop).cwd()
end

local function project_picker()
	Snacks.picker.projects({
		dev = {},
		confirm = { "tcd", "picker_files" },
	})
end

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		dashboard = {
			enabled = true,
			width = 54,
			preset = {
				header = "question  →  experiment  →  result",
				keys = {
					{ icon = "󰉋 ", key = "p", desc = "Projects", action = project_picker },
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = function()
							Snacks.dashboard.pick("oldfiles")
						end,
					},
					{
						icon = "󰩫 ",
						key = "s",
						desc = "Scratch",
						action = function()
							Snacks.scratch()
						end,
					},
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{
						icon = " ",
						key = "f",
						desc = "Find File",
						action = function()
							Snacks.dashboard.pick("files")
						end,
					},
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
			sections = {
				{ section = "header", padding = 1 },
				{ section = "keys", gap = 1, padding = 1 },
				{ icon = "󰉋 ", title = "Projects", section = "projects", indent = 2, limit = 4, padding = 1 },
				{ icon = " ", title = "Recent Files", section = "recent_files", indent = 2, limit = 4 },
			},
		},
		indent = { enabled = true },
		input = { enabled = true },
		picker = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		quickfile = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		terminal = {
			win = {
				position = "bottom",
				relative = "win",
				height = 0.3,
				wo = {
					winbar = " 󰆍  %{get(b:, 'term_title', 'Terminal')}",
					winfixheight = true,
				},
			},
		},
		words = { enabled = true },
		styles = {
			notification = {
				-- wo = { wrap = true } -- Wrap notifications
			},
		},
	},
	keys = {
		{
			"<leader>sp",
			project_picker,
			desc = "Search Recent Projects",
		},
		{
			"<leader>su",
			function()
				Snacks.picker.undo()
			end,
			desc = "Search Undo History",
		},
		{
			'<leader>s"',
			function()
				Snacks.picker.registers()
			end,
			desc = "Search Registers",
		},
		{
			"<leader>sj",
			function()
				Snacks.picker.jumps()
			end,
			desc = "Search Jumplist",
		},
		{
			"<leader>z",
			function()
				Snacks.zen()
			end,
			desc = "Toggle Zen Mode",
		},
		{
			"<leader>Z",
			function()
				Snacks.zen.zoom()
			end,
			desc = "Toggle Zoom",
		},
		{
			"<leader>.",
			function()
				Snacks.scratch()
			end,
			desc = "Toggle Scratch Buffer",
		},
		{
			"<leader>S",
			function()
				Snacks.scratch.select()
			end,
			desc = "Select Scratch Buffer",
		},
		{
			"<leader>n",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Notification History",
		},
		{
			"<leader>bd",
			function()
				Snacks.bufdelete()
			end,
			desc = "Delete Buffer",
		},
		{
			"<leader>cR",
			function()
				Snacks.rename.rename_file()
			end,
			desc = "Rename File",
		},
		{
			"<leader>gB",
			function()
				Snacks.gitbrowse()
			end,
			desc = "Git Browse",
			mode = { "n", "v" },
		},
		{
			"<leader>gb",
			function()
				Snacks.git.blame_line()
			end,
			desc = "Git Blame Line",
		},
		{
			"<leader>gf",
			function()
				Snacks.lazygit.log_file()
			end,
			desc = "Lazygit Current File History",
		},
		{
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<leader>gl",
			function()
				Snacks.lazygit.log()
			end,
			desc = "Lazygit Log (cwd)",
		},
		{
			"<leader>un",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Dismiss All Notifications",
		},
		{
			"<c-/>",
			function()
				Snacks.terminal(nil, { cwd = terminal_cwd() })
			end,
			desc = "Toggle Project Terminal",
		},
		{
			"<c-_>",
			function()
				Snacks.terminal(nil, { cwd = terminal_cwd() })
			end,
			desc = "which_key_ignore",
		},
		{
			"]]",
			function()
				Snacks.words.jump(vim.v.count1)
			end,
			desc = "Next Reference",
			mode = { "n", "t" },
		},
		{
			"[[",
			function()
				Snacks.words.jump(-vim.v.count1)
			end,
			desc = "Prev Reference",
			mode = { "n", "t" },
		},
		{
			"<leader>N",
			desc = "Neovim News",
			function()
				Snacks.win({
					file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
					width = 0.6,
					height = 0.6,
					wo = {
						spell = false,
						wrap = false,
						signcolumn = "yes",
						statuscolumn = " ",
						conceallevel = 3,
					},
				})
			end,
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for debugging (lazy-loaded)
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd -- Override print to use snacks for `:=` command

				-- Create some toggle mappings
				Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
				Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
				Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
				Snacks.toggle.diagnostics():map("<leader>ud")
				Snacks.toggle.line_number():map("<leader>ul")
				Snacks.toggle
					.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
					:map("<leader>uc")
				Snacks.toggle.treesitter():map("<leader>uT")
				Snacks.toggle
					.option("background", { off = "light", on = "dark", name = "Dark Background" })
					:map("<leader>ub")
				Snacks.toggle.inlay_hints():map("<leader>uh")
				Snacks.toggle.indent():map("<leader>ug")
				Snacks.toggle.dim():map("<leader>uD")
			end,
		})
	end,
}
