# Neovim Configuration

Personal Neovim configuration built with Lua and [lazy.nvim](https://github.com/folke/lazy.nvim). It brings together file navigation, fuzzy search, LSP support, completion, formatting, Git tools, and an integrated terminal in a keyboard-driven setup.

For a complete list of shortcuts and practical workflows, see the **[keybindings and workflow guide](KEYBINDINGS.md)**.

## Features

- **Plugin management:** lazy.nvim bootstraps itself and loads the plugin specs in `lua/plugins/`.
- **File navigation:** Neo-tree provides left-side and floating file explorers, buffer browsing, and Git status.
- **Search:** Telescope searches files, project text, buffers, diagnostics, symbols, and help.
- **Language support:** built-in Neovim LSP configuration with Mason-managed tools.
- **Completion and snippets:** nvim-cmp, LuaSnip, and friendly-snippets.
- **Formatting and diagnostics:** none-ls provides formatters and diagnostics; supported buffers are formatted on save.
- **Terminal:** ToggleTerm provides persistent bottom, floating, and side terminals.
- **Git:** Gitsigns, Fugitive, and Neo-tree Git status.
- **UI:** Nord theme, Lualine statusline, Bufferline, Alpha dashboard, and indent guides.
- **Editing helpers:** comment toggling, automatic pairs, TODO highlighting, and automatic indentation detection.

## Requirements

- Neovim **0.11 or later** is recommended. The configuration uses current Neovim LSP APIs.
- Git, for plugin installation.
- A shell available in `PATH`.
- `ripgrep` for Telescope project text search.
- `make` for building Telescope's optional native fuzzy finder.
- A [Nerd Font](https://www.nerdfonts.com/) is recommended for the configured icons. Without one, some symbols may render as empty boxes.

Language servers, formatters, and linters are installed through Mason and mason-null-ls where configured. Some tools may have additional system requirements.

## Installation

Back up or move any existing `~/.config/nvim` directory first. Then clone this repository into Neovim's config directory:

```sh
git clone https://github.com/mrinmoy-hex/nvim-dotfiles.git ~/.config/nvim
```

If you already have this repository checked out at `~/.config/nvim`, skip the clone step.

Start Neovim:

```sh
nvim
```

On first launch, lazy.nvim bootstraps and installs the configured plugins. Once startup completes, `:Mason` opens the tool installer and `:Lazy` opens the plugin manager. To install or update plugins later, run:

```vim
:Lazy sync
```

## First steps

- Press **Space e** to open the file explorer.
- Press **Space s f** to find a file, or **Space s g** to search project text.
- Press **Ctrl+`** or **Space t** to toggle the integrated terminal.
- In a supported file, use **gd** to jump to a definition and **Space c a** for code actions.
- Press **Ctrl+s** to save. Formatting runs on save when a formatting client is available for the current buffer.

The leader key is **Space**. The **[keybindings guide](KEYBINDINGS.md)** documents all configured mappings, mode-specific behavior, plugin controls, and workflow suggestions.

## Configuration layout

```text
.
├── init.lua
├── lua/
│   ├── core/
│   │   ├── keymaps.lua
│   │   ├── options.lua
│   │   └── snippets.lua
│   └── plugins/
│       ├── lsp.lua
│       ├── telescope.lua
│       ├── neotree.lua
│       ├── terminal.lua
│       └── ...
├── lazy-lock.json
└── KEYBINDINGS.md
```

- `init.lua` loads core settings and passes plugin specs to lazy.nvim.
- `lua/core/` contains editor options, keymaps, and diagnostic configuration.
- `lua/plugins/` contains individual plugin specifications and setup.
- `lazy-lock.json` pins plugin revisions for reproducible installs.
- `KEYBINDINGS.md` is the detailed shortcut and workflow reference.

## Configured language servers

The LSP configuration enables these servers when their tools are installed:

`clangd`, `cssls`, `dockerls`, `html`, `jsonls`, `lua_ls`, `pylsp`, `ruff`, `rust_analyzer`, `sqlls`, `tailwindcss`, `terraformls`, `ts_ls`, and `yamlls`.

Mason is configured to install the servers and tools listed in the config. For Python, both Ruff and python-lsp-server (`pylsp`) are configured; adjust `lua/plugins/lsp.lua` if you prefer to use only one of them.

## Customization

- Change editor behavior and the leader key in `lua/core/`.
- Add or adjust plugin setup in `lua/plugins/`.
- Edit the pinned plugin revisions in `lazy-lock.json` by using `:Lazy` to update plugins; avoid editing revisions manually unless you know the target commit.
- Review the [keybindings guide](KEYBINDINGS.md) after changing mappings so it stays in sync with the config.

