local vi_mode_utils = require('feline.providers.vi_mode')
local icons = {
    linux = ' ',
    macos = ' ',
    windows = ' ',

    errs = ' ',
    warns = ' ',
    infos = ' ',
    hints = ' ',

    lsp = ' ',
    git = ''
}

local function file_osinfo()
    local ismacos = vim.fn.has('macunix')
    local os = vim.bo.fileformat:upper()
    local icon
    if os == 'MAC' or (os == 'UNIX' and ismacos) then
        icon = icons.macos
    elseif os == 'UNIX' then
        icon = icons.linux
    else
        icon = icons.windows
    end
    return icon
end

local M = {active = {}, inactive = {}}

M.active[1] = {
    {provider = '▊ ', hl = {fg = 'skyblue'}}, {
        provider = 'vi_mode',
        hl = function()
            return {name = vi_mode_utils.get_mode_highlight_name(), fg = vi_mode_utils.get_mode_color(), style = 'bold'}
        end
    }, {
        provider = 'file_info',
        hl = {fg = 'white', bg = 'black', style = 'bold'},
        left_sep = {'block', {str = ' ', hl = {bg = 'black', fg = 'NONE'}}},
        right_sep = {{str = ' ', hl = {bg = 'black', fg = 'NONE'}}, 'block', ' '}
    }, {
        provider = 'file_size',
        enabled = function()
            return vim.fn.getfsize(vim.fn.expand('%:t')) > 0
        end,
        right_sep = {' ', {hl = {fg = 'fg', bg = 'bg'}}}
    }, {provider = 'position', left_sep = ' ', right_sep = {' ', {hl = {fg = 'fg', bg = 'bg'}}}}, {provider = 'diagnostic_errors', hl = {fg = 'red'}},
    {provider = 'diagnostic_warnings', hl = {fg = 'yellow'}}, {provider = 'diagnostic_hints', hl = {fg = 'cyan'}},
    {provider = 'diagnostic_info', hl = {fg = 'skyblue'}}
}

M.active[2] = {
    {provider = file_osinfo, left_sep = ' ', hl = {fg = 'white'}}, {provider = 'file_encoding', right_sep = ' ', left_sep = ' '},
    {provider = 'git_branch', hl = {fg = 'white', bg = 'black', style = 'bold'}, right_sep = {str = ' ', hl = {fg = 'NONE', bg = 'black'}}},
    {provider = 'git_diff_added', hl = {fg = 'green', bg = 'black'}}, {provider = 'git_diff_changed', hl = {fg = 'orange', bg = 'black'}},
    {provider = 'git_diff_removed', hl = {fg = 'red', bg = 'black'}, right_sep = {str = ' ', hl = {fg = 'NONE', bg = 'black'}}},
    {provider = 'line_percentage', hl = {style = 'bold'}, left_sep = '  ', right_sep = ' '},
    {provider = 'scroll_bar', hl = {fg = 'skyblue', style = 'bold'}}
}

M.inactive[1] = {
    {
        provider = 'file_type',
        hl = {fg = 'white', bg = 'oceanblue', style = 'bold'},
        left_sep = {str = ' ', hl = {fg = 'NONE', bg = 'oceanblue'}},
        right_sep = {{str = ' ', hl = {fg = 'NONE', bg = 'oceanblue'}}, 'slant_right'}
    }, -- Empty component to fix the highlight till the end of the statusline
    {}
}

return M

