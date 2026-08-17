# AGENTS.md

These instructions apply to changes under this Neovim configuration.

## Before changing Neovim

- Read [`README.md`](README.md) and [`docs/DESIGN.md`](docs/DESIGN.md). Use [`docs/USAGE.md`](docs/USAGE.md) to understand current interactions.
- Inspect the current Lua and effective runtime behavior; documentation may lag reality.
- Run `git status --short` and preserve existing user work. Do not revert unrelated cleanup or edits.
- Do not create a commit unless explicitly requested.
- Keep the change scoped to the requested behavior. Avoid opportunistic rewrites.

## Neovim philosophy

This is a personal, warm computational workbench for curiosity: books, mathematics, ML/LLM experiments, small programs, linguistics, notes, and REPL-driven exploration. Optimize the loop `book → question → buffer → experiment → result → another question`. A short-lived 50–200 line experiment is a successful use case, not an incomplete project.

The normal source view should remain calm and readable. Rich tools may become dense when summoned and should disappear when the operation is over. Fun and polish are legitimate; the target is tactile, not restless.

## Preserve intentional choices

Do not replace or remove these incidentally:

- Bamboo `vulgaris`, its opaque warm background, and the source-first visual hierarchy;
- quiet point-of-editing diagnostics: signs and undercurls, without virtual diagnostic prose;
- NvimTree as the right-side persistent project index **and** Oil as the active filesystem buffer;
- Telescope as the general finder **and** selected Snacks pickers for projects/editor history;
- Iron for language REPLs **and** Snacks terminal for the shell;
- bottom source/output geometry with NvimTree remaining at the outside edge;
- lualine for current context and conditional Bufferline for multi-buffer spatial awareness;
- absolute line numbers by default;
- restrained rounded transient windows; and
- smooth/tactile motion where it does not compete with source or cursor hierarchy.

These choices can evolve when a real use case warrants it. They are not candidates for incidental consolidation.

## Adding plugins

Before adding a plugin:

1. Check whether Neovim or an installed plugin already provides the capability.
2. State the specific interaction gap.
3. Prefer one focused plugin over overlapping alternatives.
4. Explain how it materially lowers friction or improves enjoyment/discoverability.
5. Lazy-load where natural, but do not contort the configuration solely for startup metrics.

Do not add plugins because they are fashionable or common in distributions. Plugin count is not itself a goal in either direction.

## Editing configuration

- Favor straightforward Lua, small explicit blocks, and documented public APIs.
- Prefer plugin-native configuration, then Bamboo palette/highlight reuse, before custom overrides.
- Avoid configuration frameworks, clever metaprogramming, private plugin internals, and large sets of hard-coded colors.
- Preserve existing mapping conventions and useful `desc` fields.
- Search the source and inspect effective mappings before adding a key; lazy-loaded plugins can still collide.
- Keep NvimTree/Oil, REPL/terminal, and Telescope/Snacks roles distinct in both behavior and documentation.
- Do not hand-edit `lazy-lock.json`; update it only through lazy.nvim when an update is explicitly requested.

## Validation

After configuration changes, run the smallest relevant set of:

- StyLua on modified Lua and `stylua --check` where available;
- headless Neovim startup;
- lazy.nvim dependency/directory health without updating plugins;
- focused runtime checks for the plugins, layouts, or languages changed;
- mapping checks for changed or potentially colliding keys;
- `git diff --check`; and
- a final diff review for unrelated churn and brittle styling.

Graphical changes should be inspected in a real UI when practical. Distinguish sandbox permission limitations—such as read-only Mason or Treesitter installation directories—from actual configuration failures.
