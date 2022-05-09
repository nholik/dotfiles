local function setup_theme()
    vim.opt.termguicolors = true
    require('bufferline').setup {
        options = {
            diagnostics = "nvim_lsp",
            diagnostics_update_in_insert = false,
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                return "(" .. count .. ")"
            end,
            show_close_icon = false,
            offsets = {{filetype = "NvimTree", text = "Files", highlight = "Directory", text_align = "right"}},
            separator_style = "thick"
        }
    }

    vim.api.nvim_set_keymap("n", "<leader>gb", ":BufferLinePick<CR>", {noremap = true})
    vim.api.nvim_set_keymap("n", "<leader>cb", ":BufferLinePickClose<CR>", {noremap = true})

    vim.cmd [[
  syntax enable
  colorscheme material
   let g:dashboard_custom_header = [
    \'',
    \'             ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣭⣿⣶⣿⣦⣼⣆         ',
    \'              ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ',
    \'                    ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷⠄⠄⠄⠄⠻⠿⢿⣿⣧⣄     ',
    \'                     ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ',
    \'                    ⢠⣿⣿⣿⠈  ⠡⠌⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ',
    \'             ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘⠄ ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ',
    \'            ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ',
    \'           ⣠⣿⠿⠛⠄⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ',
    \'           ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇⠄⠛⠻⢷⣄ ',
    \'                ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ',
    \'                 ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ',
    \ ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
    \ ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
    \ ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
    \ ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
    \ ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
    \ ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
    \ ]
]]
    local status_theme = require('status-line')
    require'feline'.setup({components = status_theme})

    require'material'.setup({

        contrast = true, -- Enable contrast for sidebars, floating windows and popup menus like Nvim-Tree
        borders = false, -- Enable borders between verticaly split windows

        popup_menu = "dark", -- Popup menu style ( can be: 'dark', 'light', 'colorful' or 'stealth' )

        italics = {
            comments = false, -- Enable italic comments
            keywords = false, -- Enable italic keywords
            functions = false, -- Enable italic functions
            strings = false, -- Enable italic strings
            variables = false -- Enable italic variables
        },

        contrast_windows = { -- Specify which windows get the contrasted (darker) background
            "terminal", -- Darker terminal background
            "packer", -- Darker packer background
            "qf" -- Darker qf list background
        },

        text_contrast = {
            lighter = false, -- Enable higher contrast text for lighter style
            darker = true -- Enable higher contrast text for darker style
        },

        disable = {
            background = false, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
            term_colors = false, -- Prevent the theme from setting terminal colors
            eob_lines = false -- Hide the end-of-buffer lines
        },

        custom_highlights = {} -- Overwrite highlights with your own
    })
end

setup_theme()
