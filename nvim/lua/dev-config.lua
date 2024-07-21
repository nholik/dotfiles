require('nvim_comment').setup()

-- slime stuff disabled
-- vim.g.slime_target = "tmux"
-- vim.g.slime_default_config = { socket_name = "default", target_pane = "{right-of}" }
-- vim.g.slime_dont_ask_default = 1
-- vim.g.slime_no_mappings = 1
-- vim.api.nvim_set_keymap('x', '<leader>sr', '<Plug>SlimeRegionSend', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>sr', '<Plug>SlimeParagraphSend', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>sl', '<Plug>SlimeLineSend', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>sc', '<Plug>SlimeSendCell', { noremap = true })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "scheme", "racket", "lisp", "clojure" },
--   callback = function()
--     vim.b.slime_cell_delimiter = "("
--   end
-- })
local lspconfig = require('lspconfig')

-- Copilot settings
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""

-- conjure settings
-- vim.g["conjure#filetypes"] = { "clojure", "fennel", "janet", "pie" } --"racket", "scheme", "sicp",
-- vim.g["conjure#filetype#pie"] = "conjure.client.racket.stdio"
-- vim.g["conjure#filetype#sicp"] = "conjure.client.racket.stdio"
-- vim.g["conjure#client#racket#stdio#command"] = "racket" --"racket -l sicp -i"
-- vim.g["conjure#highlight#enabled"] = true

-- File type detection for SICP
-- vim.cmd [[
--   function! s:DetectSICP()
--     if getline(1) =~# '#lang sicp'
--       set filetype=racket
--     endif
--   endfunction
--   augroup filetypedetect
--     autocmd!
--     autocmd BufRead,BufNewFile * call s:DetectSICP()
--   augroup END
--
-- ]]


-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = {
    'c',
    'cpp',
    'go',
    'lua',
    'python',
    'rust',
    'typescript',
    'help',
    'vim',
    'markdown',
    'latex',
    'scheme'
  },

  highlight = {
    enable = true,
    disable = {
      "latex"
    }
  },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<c-backspace>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  -- nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  nmap("<leader>fd", vim.lsp.buf.format, '[F]ormat [D]ocument')
  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  if (client.name == 'tsserver') then
    -- disable the builtin tsserver formatting to use null-ls + prettierd
    client.server_capabilities.document_formatting = false
    -- nmap("<leader>gs", require('telescope.builtin')."<cmd>TSLspOrganize<CR")
    -- nmap("<leader>gr", "<cmd>TSLspRenameFile<CR>", '')
    -- nmap("<leader>gi", "<cmd>TSLspImportAll<CR>", '')
  end
  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  clangd = {},
  dockerls = {},
  efm = {},
  gopls = {},
  pyright = {},
  rust_analyzer = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
  tsserver = {
    debug = false,
    disable_commands = false,
    enable_import_on_completion = true,

    -- import all
    import_all_timeout = 5000, -- ms
    -- lower numbers = higher priority
    import_all_priorities = {
      same_file = 1,      -- add to existing import statement
      local_files = 2,    -- git files or files with relative path markers
      buffer_content = 3, -- loaded buffer content
      buffers = 4         -- loaded buffer names
    },
    import_all_scan_buffers = 100,
    import_all_select_source = false,
    -- if false will avoid organizing imports
    always_organize_imports = true,

    -- filter diagnostics
    filter_out_diagnostics_by_severity = {},
    filter_out_diagnostics_by_code = {},

    -- inlay hints
    auto_inlay_hints = true,
    inlay_hints_highlight = "Comment",
    inlay_hints_priority = 200, -- priority of the hint extmarks
    inlay_hints_throttle = 150, -- throttle the inlay hint request
    inlay_hints_format = {      -- format options for individual hint kind
      Type = {},
      Parameter = {},
      Enum = {}
    },
    racket_langserver = {
      -- filetypes = { "racket", "scheme" },
      -- root_dir = function(fname)
      --   return vim.loop.cwd()
      -- end,
      -- settings = {
      --   ['racket-langserver'] = {
      --     ['racket-program'] = 'racket'
      --   }
      -- }
    },

    -- update imports on file move
    update_imports_on_move = false,
    require_confirmation_on_move = false,
    watch_dir = nil
  },
}

-- lspconfig.racket_langserver.setup {
--   cmd = { "racket", "--lib", "racket-langserver" },
--   filetypes = { "racket", "scheme" },
--   root_dir = function(fname)
--     return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
--   end,
--   settings = {
--     ['racket-langserver'] = {
--       ['racket-program'] = 'racket'
--     }
--   },
--   capabilities = capabilities,
--   on_attach = on_attach,
-- }

-- Setup neovim lua configuration
require('neodev').setup({ library = { plugins = { "nvim-dap-ui" }, types = true } })

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
  automatic_installation = true
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

local null_ls = require('null-ls')
null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.ruff,
    null_ls.builtins.formatting.black
  }
})

require('fidget').setup()
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete({}),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<C-j>"] = cmp.mapping(function(fallback)
      cmp.mapping.abort()
      local copilot_keys = vim.fn["copilot#Accept"]()
      if copilot_keys ~= "" then
        vim.api.nvim_feedkeys(copilot_keys, "i", true)
      else
        fallback()
      end
    end),
    ['<Tab>'] = cmp.mapping(function(fallback)
      local copilot_keys = vim.fn['copilot#Accept']()
      local copilot_enabled = vim.fn['copilot#Enabled']() == 1

      if not copilot_enabled and cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif copilot_enabled and copilot_keys ~= '' and type(copilot_keys) == 'string' then
        vim.api.nvim_feedkeys(copilot_keys, 'i', true)
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
