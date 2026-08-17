# Design notes

## Purpose

This configuration is a home computational workbench for curiosity. Its common inputs are a question from a book, an unfamiliar source file, a mathematical idea, or a small program worth trying. Its output may be a durable project, but it may just as legitimately be 80 useful lines written one evening and never revisited.

The central loop is:

> book → question → buffer → experiment → result → another question

The setup should lower the cost of entering that loop. Readability, discoverability, and enjoyment matter more here than enterprise workflow coverage or the appearance of completeness.

## Design metaphor

### Source is the page

The editing buffer is the visual and conceptual center. It is where the question is translated into code or prose. Bamboo `vulgaris`, the opaque warm background, restrained syntax, absolute line numbers, quiet diagnostics, and subdued persistent chrome exist to keep attention on that page.

Permanent telemetry should not compete with the text. Information that is useful only occasionally should generally be summoned rather than displayed continuously.

### NvimTree is the index

NvimTree is the quiet project map at the outside edge. It answers where the current file sits and what else is nearby without replacing the source as the main surface.

It stays on the right so source and result can remain adjacent. Its modest width, lack of line numbers, and current-file tracking make it an index rather than a second application.

### REPL and terminal are working paper

Results belong physically near the experiment that produced them. Iron REPLs and the Snacks terminal therefore open below the source region at roughly thirty percent height. When NvimTree is present, it remains the full-height outer edge rather than becoming a divider between code and output.

The REPL is for a conversation with a language runtime. The terminal is for shell commands and external programs. Their geometry is shared because both are result/work surfaces, but their jobs remain distinct.

### Transient tools are instruments

Telescope, completion, Trouble, Grug Far, which-key, hover windows, and notifications can be denser or more visually explicit because they are opened for a specific operation. Rounded, restrained boundaries distinguish these temporary instruments from persistent panes.

They should disappear when the operation is over. Normal editing should return to a calm page rather than retain the density of every tool that might be useful later.

## Interaction principles

### Curiosity over ceremony

Starting a small experiment should not require designing a project structure, creating a session, or deciding whether the work is important enough to keep. Scratch buffers, recent projects, recent files, a project-aware shell, and direct REPL access keep the cost of trying an idea low.

The absence of session bureaucracy is intentional. The project picker changes the tab-local directory and opens a file finder; buffers, files, Git, and scratch history provide enough continuity for this style of work.

### Modal complexity

The always-visible editor stays restrained. More complete views—repository state, all diagnostics, project replacement, debugging, or LSP relationships—are allowed to be rich once explicitly requested.

This is not minimalism for its own sake. It is a hierarchy: complexity appears at the moment it becomes useful.

### Discoverability over memorizing everything

Mappings use descriptions and coherent leader groups so which-key can act as the command map. Telescope can search the effective mappings. A useful interaction does not need to occupy permanent screen space merely because its key is easy to forget.

### Semantic movement and manipulation

Flash handles visible-target movement. Treesitter text objects make functions, arguments, and classes available to ordinary Vim operators. LSP and Telescope handle semantic relationships across files. These layers complement rather than replace core Vim motions.

### REPL and shell are different tools

Iron sends source structures to a language process and preserves the feedback loop between code and result. The Snacks terminal opens a shell rooted in the Git project, scratch context, current file directory, or current working directory. One is language conversation; the other is operating-system context.

### Project history without session management

The environment remembers projects, recent files, and scratch buffers, but it does not try to restore a complete IDE workspace automatically. This suits many heterogeneous little projects and avoids making an evening experiment adopt a lifecycle it does not need.

## Visual principles

- Bamboo `vulgaris` is intentional. Its warm charcoal/olive canvas, cream foreground, and restrained colored syntax are the reference design.
- The background is opaque. Transparency is not part of the normal visual language.
- Source should dominate. Cursor location is visible but not row-highlight loud; scope and indentation remain secondary.
- Persistent chrome should be quiet. Lualine answers context and location; Bufferline appears only when multiple buffers make spatial awareness useful.
- Transient UI may be rich. Rounded, low-emphasis borders identify floats without making their frames louder than their contents.
- Diagnostics remain quiet at the point of editing: signs and undercurls, without constant virtual prose or virtual lines. Trouble and pickers provide the global picture on demand.
- Absolute line numbers are intentional. They suit reading, discussion, and book/manuscript-like work. Relative numbers remain a toggle rather than a default.
- Motion and animation may remain when they make the environment tactile. They should be reduced when they compete with the cursor or text. The target is tactile, not restless.
- Icons are useful when they improve scanning. They should not become a second vocabulary that overwhelms names and descriptions.

## Intentional overlaps

### Oil and NvimTree

NvimTree is passive orientation: a persistent project overview at the outer edge. Oil is active manipulation: a directory becomes an editable buffer in which navigation and filesystem operations feel like normal editing.

Removing either because both display files would discard one of those interactions. They should remain visually distinct rather than being configured to imitate each other.

### Telescope and Snacks picker

Telescope is the primary general search instrument. It owns file and text search, buffers, help, diagnostics, mapping search, and LSP result views, with preview where context matters.

Snacks picker is used selectively where it integrates naturally with Snacks state: projects, undo history, registers, jumplist, and dashboard entry points. This is deliberate specialization, not an unfinished migration from one picker to another.

### Snacks terminal and Iron

The Snacks terminal provides a shell and external commands. Iron provides a filetype-aware REPL and commands for sending lines, selections, paragraphs, and files. Both live below source because both are working paper, but neither substitutes for the other.

### lualine and Bufferline

Lualine owns current context: mode, repository branch/diff, file identity, rough progress, and cursor location. Bufferline owns open-buffer spatial awareness. It hides when only one meaningful buffer exists and does not duplicate diagnostic counts or close controls.

### Snacks notifications and Fidget

Snacks notifications carry user-facing messages and short-lived feedback that should be noticeable. Fidget reports LSP progress, which is background information and should remain quieter. Their different prominence reflects different urgency.

## Complexity policy

Complexity has to earn its place. Before adding a plugin or another layer of configuration, ask:

> What does this make materially easier or more enjoyable?

Prefer, in order:

1. A capability already provided by Neovim.
2. A documented option in an installed plugin.
3. A small explicit Lua configuration block.
4. A focused new plugin for a concrete interaction gap.

Plugin count is not a moral score. A focused tool may be worthwhile, and visual polish or playful interaction can be legitimate value in a hobby environment. The counterweight is implementation discipline: public APIs, plugin-native options, Bamboo palette/highlight reuse, and straightforward Lua.

Avoid building a configuration framework, using private plugin internals, generating large abstraction layers, or accumulating dozens of hard-coded highlight colors. The experience may be playful; the implementation should usually be boring.

## Non-goals

This setup is not currently trying to become:

- a Neovim distribution;
- a clone of VS Code;
- a maximal enterprise IDE;
- an AI-first editor;
- a project-management environment; or
- a benchmark exercise in the lowest possible startup time.

These are not ideological prohibitions. A future feature can be added when a real use case warrants it. The point is to avoid drifting toward those shapes incidentally, especially through fashionable defaults or cleanup based only on apparent plugin overlap.

## Evolution

A good future change should usually do at least one of the following:

- lower friction from idea to experiment;
- improve editing, reading, or navigation;
- make experimentation more enjoyable;
- improve discoverability;
- make important state clearer; or
- remove broken or stale complexity.

Evaluate that gain against what it might damage:

- the calm source-first hierarchy;
- the simple implementation style;
- existing muscle memory;
- fast entry into scratch or REPL work; and
- support for intentionally heterogeneous little projects.

Test the normal source view, not only a showcase state. A change that looks impressive with every panel open but makes an ordinary evening buffer tiring has moved in the wrong direction.
