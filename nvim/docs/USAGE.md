# Usage guide

This is the practical reference for the current Neovim workbench. It is organized around things to do rather than the plugins that implement them.

`<leader>` is Space and `<localleader>` is `;`. If a mapping is forgotten, press Space and pause for which-key, or use `<leader>sk` to search the effective keymap.

For the reasoning behind the layout and intentional tool overlaps, see [DESIGN.md](DESIGN.md).

## Start or revisit something

### Dashboard

Starting Neovim without a file opens the workbench dashboard. Its direct keys are:

- `p`: projects;
- `r`: recent files;
- `s`: scratch;
- `n`: new file;
- `f`: find file; and
- `q`: quit.

The dashboard is an entrance, not a restored IDE session. It shows a small project/recent history and leaves normal editor status chrome hidden.

### Projects, recent files, and buffers

- `<leader>sp` opens the Snacks project picker. Confirming a project changes the **tab-local** working directory and immediately opens a file picker there.
- `<leader>s.` opens Telescope's recent-file list.
- `<leader><leader>` searches listed buffers.
- `<leader>sf` finds files under the current working directory.

The project workflow intentionally does not restore a complete session. It provides enough context to resume an experiment without requiring every small project to maintain session state.

### Scratch buffers

- `<leader>.` toggles a persistent Snacks scratch buffer for the current context.
- `<leader>S` selects from existing scratch buffers.

Scratch is the shortest path from a question to editable space. Scratch files retain their associated working directory, which the project terminal also respects.

### NvimTree

- `<C-n>` toggles the project tree.
- `<C-e>` focuses it.

NvimTree stays on the right at the outside edge. It tracks the file being edited and serves as the persistent project index; it is not meant to be the primary way to manipulate the filesystem.

### Oil

Press `-` to open the current file's parent directory as an Oil buffer. Oil is useful when the filesystem operation itself is the task: navigate with `<CR>`, edit names like text, and `:write` to apply changes.

Useful Oil-local commands include:

- `-`: parent directory;
- `<CR>`: open the entry under the cursor;
- `<C-s>` / `<C-h>` / `<C-t>`: open in vertical split / horizontal split / tab;
- `gd`: toggle detailed columns;
- `g.`: toggle hidden files;
- `gs`: change sorting;
- `<C-p>`: preview;
- `g?`: show Oil help.

Deletes use the operating system trash rather than immediate permanent deletion. Oil begins with icon, size, and modification-time columns; its detail toggle adds permissions, while the compact state is icon-only.

## Move around

### Visible and structural movement

- `s` invokes Flash jump in normal, visual, and operator-pending modes. Type the target characters and choose a visible label.
- `S` invokes Flash's Treesitter-aware target selection in the same modes.

Flash is for reaching visible structure without counting motions. Treesitter text objects, described under [Manipulate code](#manipulate-code), are for operating on a known structural unit.

### Splits and tmux

`<C-h>`, `<C-j>`, `<C-k>`, and `<C-l>` move left, down, up, and right. Navigator.nvim crosses from a Neovim split into an adjacent tmux pane when there is no Neovim window in that direction. The mappings also work from terminal mode.

`<M-h>`, `<M-j>`, `<M-k>`, and `<M-l>` resize by one cell. The sibling tmux configuration forwards the same keys at the multiplexer boundary.

### Finders and recall

- `<leader>sf`: files.
- `<leader>sg`: live grep in the current project.
- `<leader>sw`: grep for the word under the cursor.
- `<leader>/`: fuzzy search within the current buffer.
- `<leader>s/`: live grep across open files.
- `<leader>s.`: recent files.
- `<leader><leader>`: open buffers.
- `<leader>sr`: resume the last Telescope picker.
- `<leader>sj`: inspect the jumplist with Snacks.
- `<leader>su`: inspect undo history with Snacks.
- `<leader>s"`: inspect registers with Snacks.
- `[[` / `]]`: previous / next reference through Snacks words.

Telescope remains the primary general search surface. The Snacks pickers above are used where they provide a focused view of editor history or state.

## Experiment

### REPL

Iron opens its REPL below the source. If NvimTree is visible, the tree remains full height on the right while source and REPL share the editing region.

| Mapping | Action |
| --- | --- |
| `<leader>rr` | Toggle the current filetype's REPL |
| `<leader>rR` | Restart the REPL |
| `<leader>rl` | Send the current line |
| visual `<leader>rs` | Send the selection |
| `<leader>rp` | Send the current paragraph |
| `<leader>rf` | Send the file |
| `<leader>rc` | Clear the REPL |

Configured REPLs are:

| Filetype | Command | Notes |
| --- | --- | --- |
| `python` | `python` | Uses bracketed paste; `# %%` and `#%%` are block dividers |
| `javascript` | `node` | JavaScript only; no TypeScript REPL is configured |
| `lua` | `lua` | Uses the system Lua executable |
| `racket` | `racket -i` | Interactive Racket |
| `scheme` | `racket -i` | Scheme files use Racket's interactive mode |

These executables are system dependencies. Mason manages language servers and selected formatters, not these REPL runtimes.

### Shell

From normal mode, `<C-/>` toggles a Snacks terminal below the current source window. Its working directory is chosen in this order:

1. the current Git root;
2. the saved working directory of a Snacks scratch buffer;
3. the current file's directory; or
4. Neovim's current working directory.

This makes the shell project-aware without imposing a project format. Use ordinary terminal mode for commands; `<C-\><C-n>` returns to normal mode, and `<C-h/j/k/l>` can move from the terminal to neighboring panes.

Use Iron when code should be sent to a language process. Use the terminal for shell commands, builds, scripts, and external programs.

## Manipulate code

### Treesitter text objects

Functions, arguments/parameters, and classes are exposed as `a` (outer) and `i` (inner) text objects. They work with normal Vim operators and visual selection.

| Example | Meaning |
| --- | --- |
| `daf` | Delete around the function, using a linewise outer selection |
| `vif` | Select inside the function |
| `cia` | Change inside the argument/parameter |
| `daa` | Delete around the argument/parameter |
| `dic` | Delete inside the class |
| `dac` | Delete around the class, using a linewise outer selection |

Selection uses lookahead, so an object just after the cursor can still be found. Incremental Treesitter selection is also available:

- `gnn`: begin selection;
- `grn`: expand to the next node;
- `grc`: expand to the containing scope;
- `grm`: shrink to the previous node.

### Surround

nvim-surround supplies its normal operator workflow:

- `ys{motion}{delimiter}` adds a surround, such as `ysiw"` around a word;
- `yss{delimiter}` surrounds the current line;
- `ds{delimiter}` deletes a surround; and
- `cs{old}{new}` changes a surround.

The usual visual-mode `S` from nvim-surround is not available in this configuration: effective visual `S` is Flash Treesitter. Use the operator workflow above unless that mapping choice is deliberately revisited later.

## Search and change things

Use Telescope when the job is locating information:

- `<leader>sg` for project text;
- `<leader>sw` for the current word;
- `<leader>/` for the current buffer;
- `<leader>s/` for open files;
- `<leader>sd` for diagnostics;
- `<leader>sh` for help; and
- `<leader>ss` to search Telescope's available built-ins.

Use `<leader>sR` for Grug Far when the job is a project-wide replacement. From visual mode, the same mapping starts from the selection. Grug Far is intentionally a denser, explicit instrument: review its results and replacements before applying them.

For editor history rather than project text, use `<leader>su` for undo, `<leader>s"` for registers, and `<leader>sj` for jumps.

## Code intelligence

The following buffer-local mappings appear when an LSP attaches:

- `gd`: definitions through Telescope;
- `gr`: references through Telescope;
- `gI`: implementations through Telescope;
- `gD`: declaration;
- `<leader>D`: type definitions through Telescope;
- `<leader>ds`: document symbols;
- `<leader>ws`: workspace symbols;
- `<leader>rn`: rename;
- `<leader>ca`: code action in normal or visual mode.

Neovim's normal `K` hover remains available when supported by the attached server. Servers that support document highlights also highlight references after the cursor rests and clear them again on movement.

### Completion

nvim-cmp combines LSP, snippets, filesystem paths, signature information, and words from open buffers. The popup is capped at ten visible entries and its documentation window is bounded.

- `<C-n>` / `<C-p>` or `<Tab>` / `<S-Tab>`: move through candidates;
- `<C-y>`: confirm the selected candidate;
- `<C-Space>`: request completion manually;
- `<C-b>` / `<C-f>`: scroll completion documentation;
- `<C-l>` / `<C-h>`: move forward / backward through snippet fields when applicable.

### Formatting

`<leader>fd` formats the current buffer, or the selected range when invoked from visual mode. Formatting also runs before save:

- Lua uses Stylua;
- Python uses Ruff format;
- Rust uses `rustfmt`;
- other attached languages may use LSP formatting as a fallback.

C and C++ deliberately skip format-on-save because no single style is assumed. Explicit `<leader>fd` can still request LSP fallback formatting.

### Diagnostics and Trouble

Source diagnostics are intentionally quiet: signs and undercurls, with no virtual text or virtual lines.

- `<leader>sd`: diagnostics picker.
- `<leader>q`: put diagnostics in the location list.
- `<leader>xx`: all diagnostics in Trouble.
- `<leader>xX`: current-buffer diagnostics in Trouble.
- `<leader>xL` / `<leader>xQ`: location list / quickfix list in Trouble.
- `<leader>cs`: document symbols in Trouble.
- `<leader>cl`: LSP definitions/references view on the right.
- `<leader>ud`: toggle diagnostic display.
- `<leader>uh`: toggle inlay hints.

Trouble is the intended place for a persistent global error picture; diagnostic counts are deliberately absent from lualine and Bufferline.

### Debugging

nvim-dap and nvim-dap-ui provide the control layer and interface, but this configuration does not currently define a language-specific debug adapter. Once an adapter is supplied for a project or language, the configured controls are:

- `<F5>`: start or continue;
- `<F10>` / `<F11>` / `<F3>`: step over / into / out;
- `<leader>b`: toggle a breakpoint;
- `<leader>B`: set a conditional breakpoint; and
- `<F7>`: toggle the DAP UI.

The UI opens automatically when a debug session initializes and closes when it terminates or exits.

## Git

Gitsigns marks changed hunks in the source gutter. The usual local flow is:

1. `]c` or `[c` to move between changes;
2. `<leader>hp` to preview the current hunk;
3. `<leader>hs` to stage it or `<leader>hr` to reset it;
4. `<leader>hu` to undo a staged hunk when needed.

Additional useful actions:

- `<leader>hS`: stage the buffer;
- `<leader>hR`: reset the buffer;
- `<leader>hb`: Gitsigns blame for the current line;
- `<leader>hd`: diff against the index;
- `<leader>hD`: diff against the last commit;
- `<leader>tb`: toggle persistent current-line blame;
- `<leader>tD`: toggle deleted-line display.

For broader repository work:

- `<leader>gg`: Lazygit;
- `<leader>gf`: Lazygit history for the current file;
- `<leader>gl`: repository log from the current working directory;
- `<leader>gb`: Snacks line blame;
- `<leader>gB`: open the current repository/file context in a browser.

## Focus modes

- `<leader>z` toggles Snacks Zen mode for a quieter, centered reading or writing surface.
- `<leader>Z` toggles zoom for the current window while preserving the surrounding layout for later restoration.
- `<leader>uD` toggles dimming of inactive context.
- `<leader>ug` toggles indent/scope guides.

Zen is useful when the project map and output panes are temporarily irrelevant. Zoom is useful when a normally secondary pane—REPL, terminal, Trouble, or a source split—needs the full screen for a moment.

## Discovery

If a mapping is forgotten, press leader and pause. which-key groups commands by purpose: code, Git, hunks, REPL, search/recall, toggles, and Trouble.

Other discovery tools:

- `<leader>sk`: search effective mappings and their descriptions;
- `<leader>ss`: search Telescope built-ins;
- `<leader>sh`: search Neovim help;
- `g?` in Oil: Oil-local help;
- `?` in Telescope normal mode or `<C-/>` in Telescope insert mode: Telescope picker mappings;
- `:Mason`: installed language tools;
- `:Lazy`: plugin state;
- `:ConformInfo`: formatter selection and availability.

## Compact mapping reference

### Entry and navigation

| Mapping | Action |
| --- | --- |
| `<leader>sp` | Projects, then files |
| `<leader>.` / `<leader>S` | Toggle / select scratch |
| `<C-n>` / `<C-e>` | Toggle / focus NvimTree |
| `-` | Oil parent directory |
| `s` / `S` | Flash / Flash Treesitter |
| `<C-h/j/k/l>` | Navigate splits and tmux |
| `<M-h/j/k/l>` | Resize windows and tmux panes |

### Search and instruments

| Mapping | Action |
| --- | --- |
| `<leader>sf` / `<leader>sg` | Find files / live grep |
| `<leader>/` / `<leader>s/` | Search current buffer / open files |
| `<leader>s.` / `<leader><leader>` | Recent files / buffers |
| `<leader>sk` | Search mappings |
| `<leader>sR` | Project search and replace |
| `<leader>xx` | Trouble diagnostics |
| `<leader>gg` | Lazygit |

### Laboratory and focus

| Mapping | Action |
| --- | --- |
| `<leader>rr` / `<leader>rR` | Toggle / restart REPL |
| `<leader>rl` / visual `<leader>rs` | Send line / selection |
| `<leader>rp` / `<leader>rf` | Send paragraph / file |
| `<leader>rc` | Clear REPL |
| `<C-/>` | Project-aware shell |
| `<leader>z` / `<leader>Z` | Zen / zoom |
| `<leader>fd` | Format buffer or selection |
