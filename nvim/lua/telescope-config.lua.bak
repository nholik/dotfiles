local function setup_telescope()
  local nmap = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { desc = desc })
  end

  nmap('<leader>?', require('telescope.builtin').oldfiles, '[?] Find recently opened files')
  nmap('<leader><space>', require('telescope.builtin').buffers, '[ ] Find existing buffers')
  nmap('<leader>sb', require('telescope.builtin').buffers, '[S]search [B]uffers')
  nmap('<leader>/', require('telescope.builtin').current_buffer_fuzzy_find,
    '[/] Fuzzily search in current buffer]')
  nmap('<leader>sf', require('telescope.builtin').find_files, '[S]earch [F]iles')
  nmap('<leader>sh', require('telescope.builtin').help_tags, '[S]earch [H]elp')
  nmap('<leader>sw', require('telescope.builtin').grep_string, '[S]earch current [W]ord')
  nmap('<leader>sg', require('telescope.builtin').live_grep, '[S]earch by [G]rep')
  nmap('<leader>sd', require('telescope.builtin').diagnostics, '[S]earch [D]iagnostics')
end

setup_telescope()
