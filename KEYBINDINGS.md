# Neovim Keybindings and Workflow Guide

This guide documents the keybindings configured in this Neovim setup, along
with a few built-in Vim keys and practical workflows.

## Reading the notation

- `<leader>` is **Space**. For example, `<leader>sf` means press **Space**, then
  **s**, then **f** (not all at once).
- `<C-x>` means hold **Ctrl** and press **x**; `<S-Tab>` means **Shift+Tab**.
- **Normal** mode is for navigation and commands; press `Esc` to return to it.
  **Insert** mode is for typing; **Visual** mode is for selecting text.
- **LSP** shortcuts are buffer-local: they appear when a language server attaches
  to the current file. Completion shortcuts work in Insert mode.
- Some terminal emulators intercept **Ctrl+`**. If yours does, use **Space t**
  instead.

## Quick-start workflow

1. Open the file explorer with **Space e** or **Space w**.
2. Find a file with **Space s f**, search the project with **Space s g**, or
   switch to an open buffer with **Space Space**.
3. Split the editor with **Space v** or **Space h**; move between windows with
   **Ctrl+h/j/k/l**.
4. Toggle the integrated terminal with **Ctrl+`** or **Space t**.
5. Use **gd** to jump to a definition, **gr** for references, and
   **Space c a** for code actions when an LSP is available.
6. Save with **Ctrl+s**. A filetype-supported formatter runs before writing
   when available.

## General editing and files

| Key | Mode | Action |
|---|---|---|
| `Ctrl+s` | Normal | Format with the configured filetype formatter, if available, then save. |
| `Space f` | Normal | Format the current buffer with its configured formatter. |
| `Space s n` | Normal | Save with `noautocmd`, bypassing autocommands (including format-on-save). |
| `Ctrl+q` | Normal | Quit the current window; unsaved changes may prevent quitting. |
| `x` | Normal | Delete the character under the cursor without yanking it. |
| `Ctrl+/`, `Ctrl+_`, or `Ctrl+c` | Normal | Toggle a comment on the current line. |
| `Ctrl+/`, `Ctrl+_`, or `Ctrl+c` | Visual | Toggle comments on the selected lines. |
| `Space l w` | Normal | Toggle line wrapping. |
| `Space b` | Normal | Create an empty buffer. |
| `Space x` | Normal | Force-delete the current buffer (`Bdelete!`). Save first if needed. |
| `Tab` / `Shift+Tab` | Normal | Go to the next / previous buffer. |
| `Space Space` | Normal | Find and switch to an open buffer with Telescope. |
| `Space s m` | Normal | Save/overwrite the session as `.session.vim` in the current working directory. |
| `Space s l` | Normal | Load `.session.vim` from the current working directory. |
| `Space b g` | Normal | Toggle Catppuccin background transparency. |

`Space s n` is intentionally different from an ordinary save: it skips all
buffer write autocommands, not only formatting.

## Search and Telescope

| Key | Action |
|---|---|
| `Space s f` | Find files, including hidden files; ignores `node_modules`, `.git`, and `.venv`. |
| `Space s g` | Search text across the project, including hidden files; ignores the same directories. |
| `Space s w` | Search for the word under the cursor across the project. |
| `Space s /` | Search only in currently open files. |
| `Space /` | Fuzzy-search within the current buffer. |
| `Space s .` | Search recently opened files. |
| `Space s d` | Search diagnostics. |
| `Space s h` | Search Neovim help tags. |
| `Space s k` | Search configured keymaps. |
| `Space s s` | Open Telescope's picker of available pickers. |
| `Space s r` | Resume the last Telescope picker. |

Inside a Telescope picker:

- Type to filter results.
- **Ctrl+j / Ctrl+k** move down / up in the results.
- **Ctrl+l** opens the selected result.
- **Ctrl+/** in Insert mode or `?` in Normal mode shows picker-specific help.

## File explorer (Neo-tree)

| Key | Action |
|---|---|
| `Space e` | Toggle the file explorer on the left. |
| `Space w` | Toggle the floating file explorer. |
| `\` | Reveal the current file in Neo-tree. |
| `Space n g s` | Open Neo-tree's floating Git status view. |

When the filesystem tree is focused:

| Key | Action |
|---|---|
| `Enter` or `l` | Open a file / expand a directory. |
| `s` / `S` | Open in a vertical / horizontal split. |
| `t` | Open in a new tab. |
| `P` | Toggle a floating preview. |
| `a` / `A` | Add a file / directory. |
| `d` / `r` | Delete / rename the selected item. |
| `y`, `x`, `p` | Copy to Neo-tree clipboard, cut to clipboard, paste. |
| `c` / `m` | Copy / move to a destination entered in the prompt. |
| `C` / `z` | Close this directory / collapse all directories. |
| `R` | Refresh the tree. |
| `H` | Toggle hidden files. |
| `/` / `D` | Fuzzy-find files / directories. |
| `<` / `>` | Switch to the previous / next Neo-tree source. |
| `?` | Show Neo-tree's available mappings. |
| `q` / `Esc` | Close the tree / cancel a prompt or preview. |

In the **Git status** view, `ga` stages a file, `gu` unstages it, `A` stages all,
`gr` reverts a file, `gc` commits, `gp` pushes, and `gg` commits and pushes.
Use `gr` carefully: reverting discards changes to that file.

## Windows, splits, and tabs

| Key | Action |
|---|---|
| `Space v` | Open a vertical split. |
| `Space h` | Open a horizontal split. |
| `Space s e` | Equalize split sizes. |
| `Space x s` | Close the current split window. |
| `Ctrl+h/j/k/l` | Move to the window left / down / up / right. These also work with the configured tmux navigator. |
| `Up` / `Down` | Decrease / increase the current window height. |
| `Left` / `Right` | Decrease / increase the current window width. |
| `Space t o` | Open a new tab page. |
| `Space t x` | Close the current tab page. |
| `Space t n` / `Space t p` | Go to the next / previous tab page. |

Tabs and buffers are different: tabs are editor layouts; buffers are open files.
Use **Tab / Shift+Tab** or **Space Space** to move between buffers.

## Integrated terminal (ToggleTerm)

| Key | Action |
|---|---|
| `Ctrl+\`` | Toggle the persistent bottom terminal (VS Code-style). |
| `Space t` | Same bottom-terminal toggle using the leader key. |
| `Space t f` | Toggle a floating terminal. |
| `Space t v` | Toggle a side terminal. |

The terminal opens ready for typing. Press the toggle shortcut again to hide it;
reopening preserves the terminal session. Terminal commands run in your shell,
not in Neovim. If the Ctrl+` shortcut is intercepted by your terminal emulator,
use **Space t**.

## Diagnostics and LSP

These mappings are available when a language server attaches to the current
buffer.

| Key | Action |
|---|---|
| `gd` | Go to definition (Telescope results). |
| `gD` | Go to declaration. |
| `gr` | Find references (Telescope results). |
| `gI` | Go to implementation (Telescope results). |
| `Space D` | Find the type definition. |
| `Space d s` | Search symbols in the current document. |
| `Space w s` | Search symbols across the workspace. |
| `Space r n` | Rename the symbol under the cursor. |
| `Space c a` | Show code actions (Normal or Visual mode). |
| `Space t h` | Toggle inlay hints, when supported by the attached server. |

| Key | Action |
|---|---|
| `[d` / `]d` | Jump to the previous / next diagnostic and show its message. |
| `Space d` | Show the diagnostic under the cursor in a float. |
| `Space q` | Send diagnostics to the current window's location list. |
| `Space d o` | Toggle diagnostics globally. |

Format-on-save uses clangd for C/C++, rust-analyzer with `rustfmt` for Rust,
Prettier for web/markup files, StyLua for Lua, Ruff for Python, shfmt for shell
scripts, and `terraform fmt` for Terraform. Install the Rust formatter with
`rustup component add rustfmt` if it is missing.

vim-sleuth detects indentation in existing files; new Lua, C/C++, and
Prettier-supported files use two spaces, while Rust, Python, and shell use
four. A project's EditorConfig and formatter configuration take precedence
where supported.

There is no separate manual format keybinding in this config. **Ctrl+s** runs
the save hooks, while **Space s n** bypasses them.

## Completion and snippets (Insert mode)

| Key | Action |
|---|---|
| `Ctrl+n` / `Ctrl+p` | Select the next / previous completion item. |
| `Ctrl+y` | Confirm the selected completion item. |
| `Ctrl+Space` | Manually open completion suggestions. |
| `Ctrl+b` / `Ctrl+f` | Scroll completion documentation backward / forward. |
| `Tab` / `Shift+Tab` | Move through completion items, or jump forward / backward through a snippet field. If neither applies, perform the normal Tab action. |
| `Ctrl+l` / `Ctrl+h` | Jump forward / backward through snippet fields when a snippet can be expanded or traversed. |

Completion sources include the LSP, snippets, words in the current buffer, and
file paths.

## Split resizing with arrow keys

The arrow-key resize mappings adjust the active split in small increments:

- **Up / Down** shrink / grow its height.
- **Left / Right** shrink / grow its width.

## Useful built-in Vim keys

These are standard Vim motions/actions, not custom mappings from this config:

| Key | Action |
|---|---|
| `i` / `a` | Insert before / after the cursor. |
| `v` / `V` | Start characterwise / linewise selection. |
| `y` / `p` | Yank (copy) / put (paste) selected text. |
| `u` / `Ctrl+r` | Undo / redo. |
| `/text`, then `n` / `N` | Search forward, then next / previous match. |
| `.` | Repeat the last change. |
| `Esc` | Return to Normal mode or dismiss an active mode. |

## Useful commands and discovery

- which-key is installed, but this config does not define a dedicated trigger
  for its hint window. Use **Space s k** to search mappings.
- `:Telescope keymaps` opens the keymap picker.
- `:Lazy` opens the plugin manager; run `:Lazy sync` after adding plugins.
- `:Mason` opens the language-server/tool installer.
- `:checkhealth` runs Neovim health checks.
- In Neo-tree, press `?`; in Telescope, press `?` in Normal mode or `Ctrl+/` in
  Insert mode to see context-specific help.

Keymaps can vary by buffer and mode. When in doubt, inspect the active mappings
with **Space s k** or check the relevant help inside the plugin UI.
