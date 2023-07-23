# `rsltn` Documentation

## Introduction

`rsltn` (pronounced, and usually typeset, *resolution*) is an environment for writing math built on Neovim.
`rsltn` stands for **R**oshan's **S**ystem for **L**a**T**eX in **N**eovim, but the name also refers to the goal of the project, the *resolution* of the two main steps in the process of creating math: experimentation and exposition.
For while *resolution* improves the experience of quickly writing beautiful math with LaTeX and provides tools for experimenting and computing in two interactive spaces (the Napkin and the Notebook), the unique and defining functionality of *resolution* is the seamless and efficient integration *between* the two processes.
Using TeX, Lua, Vimscript, and Python, *resolution* is a complete implementation of a new way to write pure math.

## Table of Contents
 - [**Introduction**](#introduction)
 - [**Why Resolution?**](#why-resolution%3F)
 - [**`rsltn` for Users**](#rsltn-for-users)
    - [**Installation**](#installation)
    - [**Navigation and Shortcuts**](#navigation-and-shortcuts)
    - [**Using Neovim**](#using-neovim)
    - [**Provided Snippets**](#provided-snippets)
    - [**The Standard TeX Style File**](#the-standard-tex-style-file)
    - [**The `rslv` Command**](#the-rslv-command)
    - [**The Napkin**](#the-napkin)
    - [**The Notebook**](#the-notebook)
 - [**`rsltn` for Developers**](#rsltn-for-developers)
    - [**`rsltn-core-and-ui`**](#rsltn-core-and-ui)
    - [**`rsltn-style`**](#rsltn-style)
    - [**`rsltn-snippets`**](#rsltn-snippets)
    - [**`rsltn-file-management`**](#rsltn-file-management)
    - [**`rsltn-computation`**](#rsltn-computation)
    - [**`rsltn-figures`**](#rsltn-figures)
 - [**Appendix: Neovim in Detail**](#appendix%3A-neovim-in-detail)

## Why *resolution*?

Following are some demonstrations of `rsltn`'s core functionality:

##### Writing LaTeX Using Snippets
##### Navigating and Manipulating a Complex Document
##### Computation

##### Symbolic Matrix Manipulation
![A GIF of rlstn doing symbolic matrix manipulation (determinants, multiplication, etc.) without ever leaving the TeX document.](https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/640px-A_black_image.jpg)

##### Expanding and Manipulating Taylor Series
![A GIF of rsltn manipulating Taylor series using computational tools from SymPy in the 'napkin'.](https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/640px-A_black_image.jpg)

##### Working with Graphs
![A GIF of rsltn solving a problem of finding a counterexample in graph theory by using SageMath as an experimental tool in the 'napkin'.](https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/640px-A_black_image.jpg)

Following are a few other demonstrations of how `rsltn` can make the process of writing TeX easier:

##### Snippets
![A GIF of rsltn being used to create a number of definitions and statements (with expositionary arrows) quickly using its snippets feature.](https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/640px-A_black_image.jpg)

##### Figure Creation
![A GIF of rsltn being used in conjunction with tikzcd-editor to create and include commutative diagrams quickly.](https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/640px-A_black_image.jpg)

## `rsltn` for Users
### Installation
### Navigation and Shortcuts
### Using Neovim
### Provided Snippets
### The Standard TeX Style File
### The `rslv` Command
### The Napkin

## `rsltn` for Developers
In this section, we'll discuss the structure of `rsltn` and what each file (or set of files) does:
### `rsltn-core-and-ui`
The core `rsltn` functionality is provided by the `init.lua` file in Neovim's config folder (obtainable by running the Lua command `vim.fn.stdpath('data')`, and which all paths are relative to unless otherwise specified), which sets up the Lua environment for sourcing and sources `rsltn-config.lua` and the folder `rsltn-core`:

#### `rsltn-config.lua`
This file contains the most important high-level options for user configuration.
 - Aesthetic Options (returned for later access)
     - Default colorscheme (`nord`)
     - Default setting for dark/light mode (`dark`)
 - Snippet Behavior (returned for later access)
     - Default snippet behavior (`on`)
     - Default *automath* snippet behavior (`on`)
 - Keybinds (returned for later access)
     - General
         - Default for arrow keys (`enabled`)
         - Default for `Alt-h/j/k/l` movement (`enabled`)
     - `Ctrl-Alt-?` Keybinds
         - Quit all windows (`Ctrl-Alt-Q`)
         - Open file explorer (`Ctrl-Alt-E`)
         - Toggle `nvim-tree` (`Ctrl-Alt-T`)
         - Toggle file fuzzy finder (`Ctrl-Alt-Y`)
         - Open menu for preferences (`Ctrl-Alt-P`)
         - Open menu for system files (`Ctrl-Alt-S`)
         - Open menu for file management (`Ctrl-Alt-F`)
         - Open menu for figure creation (`Ctrl-Alt-G`)
         - Open `rsltn` documentation (`Ctrl-Alt-H`)
         - Toggle jump menu in $\LaTeX$ files (`Ctrl-Alt-J`)
         - Toggle compilation on save for $\LaTeX$ (`Ctrl-Alt-L`)
         - Trigger SyncTeX to corresponding point in PDF (`Ctrl-Alt-Z`)
         - Toggle computational pop-up menu (`Ctrl-Alt-C`)
         - View file in project (`Ctrl-Alt-V`)
         - Open the Napkin directly (`Ctrl-Alt-N`)
         - Open project menu (`Ctrl-Alt-M`)
     - Other
         - Leader key (`<Space>`)
         - Save file (`Ctrl-S`)
         - Search for line (`Ctrl-L`)
         - Fix spelling error (`Ctrl-Z`)
 - Neovim Options (trigged by this file)
     - Basic
         - Cursor line (`on`)
         - Numbering (`on`)
         - Relative numbering (`on`)
         - Line wrapping (`on`)
         - Spell checker (`off`)
         - Mouse (`on`)
         - Leader key (`<Space>`)
         - Scroll off (`5`)
         - Command box height (`0`)
         - Unify system/Vim clipboard (`on`)
     - Undo, backups, and swap
         - Undo directory (`/utilties/undo/`)
         - Backup directory (`/utilities/backup/`)
         - Swap directory (`/utilities/swap/`)
         - Swapfiles (`off`)
         - Undo files (`on`)
         - Undo levels (`1000`)
         - Undo reload (`10000`)
     - Handling tabs
         - Expand tabs into spaces (`on`)
         - Length of tab (`4`)
         - Length of spaces sent by tab keypress (`4`)
         - Level of indentation (`4`)
         - Auto indentation (`on`)
     - Other
         - Syntax highlighting (`on`)
         - Terminal GUI colors (`on`)
         - Folding method (`marker`)
         - Maximum size of menu (`5`)
         - Show -- INSERT MODE -- message in command box (`off`)
         - Highlight search results (`true`)
         - Incremental searching (`true`)
         - Show tabline (`whenever there are multiple buffers`)

#### `rsltn-core/plugins.lua`
This file installs and configures all necessary plugins. Specifically, it first installs `lazy.nvim`, a plgins manager for `nvim`, in `rsltn-core/lazy`, and sets its working directory (where it installs plugins) to `rsltn-core/plugins`. Then, installs and configures the following packages using the brilliant lazy-loading framework provided by `lazy.nvim`.
 - **LSP:** `nvim-lspconfig` for LSP configuration with Neovim, and `mason.nvim` and `mason-lspconfig.nvim` for installing specific LSPs.
 - **Autocompletion:** `nvim-cmp` and dependencies `cmp-buffer`, `cmp-path`, `cmp_luasnip`, and `cmp-nvim-lsp` for autocompletion that hooks into LuaSnip and is configured for use with LaTeX.
 - **UI:** `nui.nvim`, a low-level API for creating UI elements. `telescope.nvim`, a module which provides a 'fuzzy finder' that is used for finding files, projects, options, etc., and its dependencies `plenary.nvim` (async tasks) and `telescope-fzf-native.nvim` (a faster engine). `startup.nvim` for a startup screen. `lualine.nvim` and `bufferline.nvim` for status and tablines. `hydra.nvim` for menus that assist with navigating. `nvim-tree` for a built-in file explorer.
 - **Ergonomics:** `leap.nvim` and `flit.nvim` for better movement within a given screen. `indent-blankline.nvim` for showing indent guides. `pretty-fold.nvim` for prettier folds (useful for the `rsltn` codebase).
 - **LaTeX-Related:** `vimtex` for basic TeX functionality such as compiling, hooks from which the jump-list can be built, and so on. `LuaSnip` for snippets.
 - **Colorschemes:** `gruvbox`, `nord` (and `polar` for a light version), `everforest`, `tokyonight`, `kanagawa`, `catppuccin`, `nightfox`, `vscode`, `onedark`, and `afterglow`.
 - **Other:** `vim-fugitive` for GitHub integration. `markdown-preview.nvim` for live markdown previewing (useful for searching documentation).

#### `rsltn-core/keybinds.lua`
Defining keybinds where necessary (except those which relate to static menus)
 - Movement keys
     - Enable/disable arrow keys if the config so requests.
     - Enable/disable `Alt-h/j/k/l` if the config so requests.
 - `Ctrl-Alt` Keybinds
     - Quit all
     - Toggle Nvim Tree
     - Fuzzy find files
     - Open File Explorer
     - Documentation
     - Toggle Jump Menu in TeX
     - Turn on LaTeX Compilation
     - Turn on LaTeX Autocompilation
     - SyncTeX with the PDF
     - Open the computational pop-up
     - Open project menu
     - Open the Napkin
     - Open file in project
 - Assorted keybinds
     - Setting `Ctrl-Left` and `Ctrl-Right` to move between buffers.
     - Setting the "save file" keybind in normal and insert mode.
     - Setting the "fuzzy find line" keybind in normal and insert mode.
     - Setting the "fix spelling error" keybind in normal and insert mode.
     - Setting `'` to behave like `"_` so that true-delete is easier.
     - Setting the Enter key to clear all highlights (so that one doesn't need to type `:noh`).

#### `rsltn-core/aesthetics.lua`
Setting up the UI and look of `rsltn`.
 - Set up the startup highlight groups
 - Set up the startup screen
 - Set up the status line
     - Enable icons
     - Set up triangle separators
     - Hide it on startup
     - Set up sections
 - Set up the buffer line
     - Sets the buffer line to not always show
 - Set up the colors update function which is used by the static preferences menu and also configures the colors on startup

#### `rsltn-core/menus.lua`
This file creates a series of complex static menus for interacting with the system.
 - A menu for opening any of the system files from any of `rsltn-core`, `rsltn-style`, `rsltn-snippets`, `rlstn-file-management`, `rsltn-computation`, `rsltn-figures`. (`Ctrl-Alt-S`)
 - A menu for changing preferences on the fly: color schemes, spell checker, wrapping, numbering, mouse, arrow keys, snippets, indentation, virtual editing, etc. (`Ctrl-Alt-P`)
 - A menu for file management operations: creating/deleting projects, creating/deleting files, pushing/pulling projects to/from Github and Overleaf, etc. This hooks into `rsltn-file-mangagement`. (`Ctrl-Alt-F`)
 - A menu for figure creation: create/edit tables, create/edit/insert TikZ figures in a number of tools (Quiver, Tikzcd-Editor, TikZit, etc.) or create/edit/insert Inkscape figures. This hooks into `rsltn-figures`. (`Ctrl-Alt-G`)

#### `rsltn-core/misc.lua`
This file does a series of small changes and fixes.
 - Letting the arrow keys and `h` and `l` horizontal wrap.
 - Fixing the behavior of `k`, `j`, and the up/down arrows with wrapped lines.
 - Setting up persistent undo, backups, swapfiles, and spelling directory in the directory `utilities`.
 - Unify clipboard registers for ease of use for beginners.
 - A few assorted behavior fixes for undesirable Vim strangeness.

### `rsltn-style`
### `rsltn-snippets`
### `rsltn-file-management`
### `rsltn-computation`
### `rsltn-figures`

## Appendix: Neovim in Detail
