local function setup_file_manager()
  vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true })
  vim.api.nvim_set_keymap("n", "<C-e>", ":NvimTreeFocus<CR>", { noremap = true })

  require('nvim-tree').setup({
    disable_netrw = true,
    hijack_netrw = true,
    -- open_on_setup = false,
    -- ignore_ft_on_setup = {},
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = false,
    --        update_to_buf_dir = {enable = true, auto_open = true},
    diagnostics = { enable = false, icons = { hint = "", info = "", warning = "", error = "" } },
    update_focused_file = { enable = false, update_cwd = false, ignore_list = {} },
    system_open = { cmd = nil, args = {} },
    filters = { dotfiles = false, custom = {} },
    git = { enable = true, ignore = true, timeout = 500 },
    actions = {
      use_system_clipboard = true,
      change_dir = { enable = true, global = false, restrict_above_cwd = false },
      open_file = {
        quit_on_open = true,
        resize_window = false,
        window_picker = {
          enable = true,
          chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
          exclude = { filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" }, buftype = { "nofile", "terminal", "help" } }
        }
      }
    },
    view = {
      width = 30,
      hide_root_folder = false,
      side = 'right',
      -- auto_resize = true,
      mappings = { custom_only = false, list = {} },
      number = true,
      relativenumber = false,
      signcolumn = "yes"
    },
    trash = { cmd = "trash", require_confirm = true }
  })
end

setup_file_manager()
