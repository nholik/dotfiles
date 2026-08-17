# Neovim computational workbench

This is a personal Neovim configuration for following curiosity: mathematics exercises, Python and ML experiments, SICP/TAOCP rabbit holes, small systems programs, language tinkering, notes, and disposable code that may only need to live for one evening.

The working loop is deliberately simple:

> book → question → buffer → experiment → result → another question

The setup favors low friction, readable source, discoverable commands, and enough visual character to make opening the editor inviting. It is not trying to turn every small experiment into an enterprise project.

For the practical reference, see [docs/USAGE.md](docs/USAGE.md). For the reasoning that future changes should preserve, see [docs/DESIGN.md](docs/DESIGN.md).

## What it feels like

- Bamboo's `vulgaris` style provides a warm, opaque, low-noise page for source code.
- NvimTree sits at the right edge as a persistent project index. Oil is the active filesystem editor.
- Iron REPLs and the Snacks terminal open below the source, keeping results next to the experiment that produced them.
- Lualine and Bufferline provide context without becoming telemetry panels. Bufferline stays hidden with a single useful buffer.
- Telescope, Trouble, Grug Far, completion, and which-key become visually rich when summoned, then disappear.
- `Ctrl-h/j/k/l` crosses Neovim splits and tmux panes, while `Alt-h/j/k/l` resizes them.

The intended result is tactile, not restless: restrained source presentation with transient instruments available on demand.

## Core stack

### UI and presentation

- **Bamboo (`vulgaris`)** owns the warm palette, syntax character, diagnostics, and shared float-border language.
- **lualine** shows mode, Git context, file identity, progress, and location.
- **Bufferline** gives spatial awareness when several files are open; it avoids close buttons and diagnostic counters.
- **Snacks** supplies the dashboard, status column, indent/scope guides, smooth scrolling, notifications, scratch buffers, terminal, focus modes, and selected pickers.
- **which-key** is the main discovery surface. Press leader and pause.

### Navigation and search

- **Telescope** is the primary general finder for files, text, buffers, help, diagnostics, and LSP results.
- **Flash** provides visible-target movement and Treesitter-aware selection with `s` and `S`.
- **Navigator.nvim** connects ordinary split navigation to tmux.
- **Treesitter text objects** make functions, arguments, and classes usable as Vim motions and operator targets.
- **Grug Far** handles deliberate project-wide search and replacement.

### Filesystem

- **NvimTree** is the persistent visual overview at the outside edge.
- **Oil** treats a directory as an editable buffer for navigation and filesystem changes.

Both are intentional; they solve different interactions.

### Code intelligence and completion

- Neovim LSP, **nvim-lspconfig**, **Mason**, and **Fidget** provide language intelligence and quiet progress feedback.
- **nvim-cmp**, **LuaSnip**, and completion sources provide bounded contextual completion.
- **Conform** formats on save where configured and exposes an explicit formatting command.
- **LazyDev** improves Lua completion and annotations for Neovim configuration work.

### Experimentation

- **Iron** connects buffers to language REPLs.
- **Snacks scratch** provides low-ceremony persistent scratchpads.
- **Snacks terminal** provides a project-aware shell below the source.
- **Snacks project picker** revisits known projects without imposing a session-management workflow.

### Git, diagnostics, and debugging

- **Gitsigns** supplies hunk signs, navigation, staging, resetting, previews, blame, and diffs.
- **Snacks Lazygit/git helpers** provide the broader repository view, history, blame, and browser integration.
- **Trouble** is the on-demand global diagnostics, symbol, LSP, location-list, and quickfix instrument.
- **nvim-dap** and **nvim-dap-ui** provide debugger controls and UI. No language-specific DAP adapter is configured in this directory yet.

## Getting around

`<leader>` is Space. These are the first mappings worth remembering:

| Mapping | Purpose |
| --- | --- |
| `<leader>` then pause | Discover commands with which-key |
| `<leader>sp` | Choose a known project, set the tab-local directory, then find a file |
| `<leader>.` / `<leader>S` | Toggle a scratch buffer / choose an existing scratch |
| `<C-n>` / `<C-e>` | Toggle / focus NvimTree |
| `-` | Open the current directory or file's parent in Oil |
| `<leader>sf` / `<leader>sg` | Find files / search project text |
| `<leader>s.` | Reopen a recent file |
| `<C-/>` | Toggle the project-aware bottom terminal |
| `<leader>rr` | Toggle the current filetype's Iron REPL |
| `<leader>rl` / visual `<leader>rs` | Send a line / selection to the REPL |
| `s` / `S` | Flash to a visible target / Flash Treesitter target |
| `<C-h/j/k/l>` | Move across Neovim splits and tmux panes |
| `<leader>fd` | Format the current buffer or selection |
| `<leader>gg` | Open Lazygit |
| `<leader>xx` | Open the full diagnostics view in Trouble |
| `<leader>sk` | Search all effective mappings |

## Laboratory workflow

One typical evening looks like this:

1. Use `<leader>sp` to reopen an experiment, or `<leader>.` for a scratchpad with almost no ceremony.
2. Write or read code in the main source area. Use `s` for visible movement and Treesitter text objects such as `daf` or `cia` for structural edits.
3. Use `<leader>rr` to open the filetype's REPL below the source.
4. Send the current line with `<leader>rl`, a visual selection with `<leader>rs`, or a larger unit with `<leader>rp` or `<leader>rf`.
5. Use `<C-/>` when the experiment needs a shell command rather than a language REPL.
6. Close the instrument when it is no longer useful and return to the source page.

See the [usage guide](docs/USAGE.md) for the full REPL map, semantic text objects, Git workflow, code intelligence, and focus modes.

## Language support

This table describes configured behavior, not every language Neovim could theoretically support.

| Language | Intelligence | Formatting | REPL |
| --- | --- | --- | --- |
| Python | Pyright plus Ruff; Pyright owns hover | `ruff_format` | `python` with bracketed paste and `# %%` block markers |
| Lua | `lua_ls` plus LazyDev for Neovim APIs | Stylua | `lua` |
| JavaScript / TypeScript | `ts_ls` | LSP fallback when supported | `node` for JavaScript only |
| Rust | `rust_analyzer` | `rustfmt` | None configured |
| C / C++ | `clangd` | Manual LSP fallback; format-on-save is disabled | None configured |
| Java | `jdtls` | LSP fallback when supported | None configured |
| JSON | Treesitter highlighting | None configured | None configured |
| Racket / Scheme | No LSP configured here | None configured | `racket -i` |

Treesitter parsers are ensured for C, Java, JavaScript, JSON, Lua, Python, Rust, and TypeScript. Files larger than 100 KiB skip Treesitter highlighting. Plain text and notes use normal editor facilities; spelling can be toggled with `<leader>us`.

## Installation and prerequisites

Place or symlink this `nvim` directory at `~/.config/nvim`, then start Neovim. The configuration bootstraps lazy.nvim on first launch; lazy.nvim installs the declared plugins, and Mason ensures the configured language servers plus Stylua.

The current configuration expects:

- **Neovim 0.11 or newer.** It uses the global `winborder` option and current diagnostic/LSP APIs.
- **Git** and network access for the first plugin/tool installation.
- A terminal configured with a **Nerd Font**. Icons are used directly throughout the UI. The optional GUI configuration requests `InconsolataGo Nerd Font Mono`, but terminal font choice lives outside Neovim.
- **ripgrep** and preferably **fd** for Telescope search; **lazygit** for the Lazygit mappings.
- **make** and a C compiler for native Telescope FZF and LuaSnip regex builds.
- A working system clipboard provider if `unnamedplus` clipboard integration is desired.
- The relevant runtime for REPLs: `python`, `node`, `lua`, or `racket`.
- A JDK for Java work, Node.js for JavaScript/TypeScript tooling, and `rustfmt` on `PATH` for Rust formatting.

tmux is optional. The sibling [`tmux/.tmux.conf`](../tmux/.tmux.conf) forwards `Ctrl-h/j/k/l` and `Alt-h/j/k/l` so navigation and resizing cross the Neovim/tmux boundary.

Use `:Lazy` to inspect plugins, `:Mason` to inspect managed tools, and `:checkhealth` when bringing the setup to a new machine. There is no separate bootstrap framework.

## Where configuration lives

- [`init.lua`](init.lua) contains core Neovim options and the earliest global mappings.
- [`lua/config/lazy.lua`](lua/config/lazy.lua) bootstraps lazy.nvim and imports plugin modules.
- [`lua/plugins/theme.lua`](lua/plugins/theme.lua) owns Bamboo, Bufferline, lualine, icons, and Navigator.
- [`lua/plugins/file-manager.lua`](lua/plugins/file-manager.lua) owns Oil and NvimTree.
- [`lua/plugins/ergonomics.lua`](lua/plugins/ergonomics.lua) owns Iron, Flash, which-key, and Grug Far.
- [`lua/plugins/snacks.lua`](lua/plugins/snacks.lua) owns the dashboard, scratch/project workflows, terminal, notifications, focus modes, and Snacks pickers.
- [`lua/plugins/lsp.lua`](lua/plugins/lsp.lua), [`complete.lua`](lua/plugins/complete.lua), and [`format.lua`](lua/plugins/format.lua) own language tooling.
- [`lua/plugins/tresitter.lua`](lua/plugins/tresitter.lua) owns syntax parsing, incremental selection, and semantic text objects.
- [`lua/plugins/git.lua`](lua/plugins/git.lua), [`trouble.lua`](lua/plugins/trouble.lua), and [`debugger.lua`](lua/plugins/debugger.lua) own their respective instruments.
- [`lua/utils.lua`](lua/utils.lua) contains split/tmux navigation and resizing mappings.

The deeper rationale is recorded in [docs/DESIGN.md](docs/DESIGN.md). Read it before trying to consolidate apparently overlapping tools or making the normal editing view more information-dense.
