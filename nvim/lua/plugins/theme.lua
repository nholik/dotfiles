return {
	{
		"ribru17/bamboo.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("bamboo").setup({
				style = "vulgaris",
				transparent = false,
				term_colors = true,
				diagnostics = {
					undercurl = true,
				},
				highlights = {
					FloatBorder = { fg = "$light_grey", bg = "$bg0" },
					SnacksIndentScope = { fg = "$light_grey" },
					TelescopeBorder = { link = "FloatBorder" },
					TelescopePreviewBorder = { link = "FloatBorder" },
					TelescopePromptBorder = { link = "FloatBorder" },
					TelescopeResultsBorder = { link = "FloatBorder" },
				},
			})
			require("bamboo").load()
		end,
	},
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = function()
			local bufferline = require("bufferline")
			return {
				options = {
					style_preset = {
						bufferline.style_preset.minimal,
						bufferline.style_preset.no_italic,
					},
					diagnostics = false,
					always_show_bufferline = false,
					show_buffer_close_icons = false,
					show_close_icon = false,
					separator_style = "thin",
					offsets = {
						{
							filetype = "NvimTree",
							text = "",
							highlight = "NvimTreeNormal",
							separator = true,
						},
					},
				},
			}
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = function()
			local theme = vim.deepcopy(require("lualine.themes.bamboo"))
			local background = theme.normal.c.bg

			for _, mode in ipairs({ "normal", "insert", "visual", "replace", "command", "terminal" }) do
				if theme[mode] and theme[mode].a then
					local accent = theme[mode].a.bg
					theme[mode].a = { fg = accent, bg = background, gui = "bold" }
				end
			end
			theme.normal.b.bg = background

			return {
				options = {
					icons_enabled = true,
					theme = theme,
					component_separators = { left = "│", right = "│" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = { "snacks_dashboard" },
						winbar = {},
					},
					globalstatus = true,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff" },
					lualine_c = { { "filename", path = 1 } },
					lualine_x = {},
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { { "filename", path = 1 } },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				extensions = { "nvim-tree", "oil", "trouble" },
			}
		end,
	},
	{ "numToStr/Navigator.nvim" },
}
