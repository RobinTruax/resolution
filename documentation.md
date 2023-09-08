# `rsltn` Documentation

## Introduction

`rsltn` (pronounced, and usually typeset, *resolution*) is an environment for writing math built on Neovim.
`rsltn` stands for **R**oshan's **S**ystem for **L**a**T**eX in **N**eovim, but the name also refers to the goal of the project, the *resolution* of the two main steps in the process of creating math: experimentation and exposition.
For while *resolution* improves the experience of quickly writing beautiful math with LaTeX and provides tools for experimenting and computing in two interactive spaces (the Napkin and the Notebook), the unique and defining functionality of *resolution* is the seamless and efficient integration *between* the two processes.
Using TeX, Lua, Vimscript, and Python, *resolution* is a complete implementation of a new way not just of writing math, but creating it.

**Note: *resolution* is currently in a private alpha stage. To apply to the private alpha, visit [here](truax.cc/compsci/resolution.html). Expect breaking changes in the editor; however, the TeX style files included in *resolution* will remain mostly consistent to avoid breaking any TeX created using the platform**.

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
*resolution* runs on all major operating systems. The process of installing *resolution* is split into two parts: the installation of the basic system, and the installation of various dependencies which are necessary for many of the core features of *resolution* to function. The private alpha server has a dedicated channel for assistance with the installation process.
#### Basic System
1. **Install Neovim**: Install Neovim 0.9 or later. You can either install the traditional terminal UI (recommended) or Neovide, a GUI for Neovim (not tested). For the former, visit [this link](https://github.com/neovim/neovim/wiki/installing-Neovim#install-from-download) and select your operating system. Install the application as you would any other, and, if you are not using Neovide, make sure that it is accessible in your `PATH` by running `nvim` in your terminal. If it's not working, add the folder to your `PATH` and, if necessary, an alias.
2. **Locate Configuration Location**: Determine your Neovim configuration path. On Linux and Mac, the configuration path is usually `~/.config/nvim`, and on Windows the configuration path is usually `~/AppData/Local/nvim`. However, to know for sure, launch Neovim by running `nvim` in the terminal. Then, press `:` to enter command mode and run the comment `lua=vim.fn.stdpath('config')`; the configuration path will be printed.
3. **Download Configuration Files:** Next, clone this git repository into Neovim's configuration folder.\* On Mac and Linux, this is fairly simple. Open a terminal window and use `cd` to navigate into the configuration folder, and then run `git clone https://github.com/RobinTruax/resolution.git .` On Windows, you may need to install `git` first. Visit `git-scm.com/download/win` to do so. You can then repeat the process described above. (\*If you are already using Neovim, you can clone into a different empty folder, say `/rsltn/`, in the general configuration folder -- usually `~/.config/` in Mac or Linux and `~/AppData/` in Windows -- and launch Neovim with `NVIM_APPNAME=rsltn nvim`). 
4. **Auto-Install Plugins and Packages:** Next, open Neovim again. A number of messages should appear showing that a number of packages are being downloaded into the configuration folder. After they've stopped, close Neovim and reopen it. You should be met with a screen of the following sort, and no errors (which will appear in the upper-right hand if they are minor errors, or will cover the screen if they are major errors). 
![rsltn starting screen](images/start.png =400x)
5. **Set Project Root Path:** Open *resolution*, and navigate to `customize rsltn` by starting to type it. A window will appear listing all of *resolution*'s configuration files. One *must* set the root project path for *resolution* to work. This is in the `lua/config/preferences.lua` file. Thus, search `preferences` and select the option which appears. Set the variable `prefs.project_root_path` to the desired root path. I chose to create a `Mathematics` folder in my `Documents` folder, and used that. 

#### Dependencies and Add-Ons
The basic system of *resolution* is now installed, but dependencies must be installed for it to work properly. I recognize this section is daunting, but it's important to remember that you're not just installing an IDE, you're installing a number of other useful tools and programming languages which link to *resolution*! If you need any help with installation, please visit the troubleshooting channel in the private alpha Discord.

1. **Python 3.9+ (Required):** Python is required for numerous plugins and operations; you can download it [here](https://www.python.org/downloads) if it's not already installed. Ensure that it's installed (and has a sufficient version) by running `python` in the terminal. Then, run `pip install pynvim` to install the remote plugin API for Python and Neovim and `pip install sympy` to install SymPy.
2. **TeX Live 2023 (Required):** TeX Live provides all the necessary packages and compilation tools for LaTeX. TeX Live 2023 in particular is necessary for the virtual auxiliary directory functionality that *resolution* uses to keep directories clean without sacrificing compilation time. You can install it on Linux [here](https://tug.org/texlive/quickinstall.html), Windows [here](https://tug.org/texlive/windows.html), and MacOS [here](https://tug.org/mactex/). Ensure that it's installed and has the correct version with the command `tex`.
3. **Jupyter (Required):** Install Jupyter with the commands `pip install ipykernel`, `pip install jupyterlab`, and `pip install jupyter_client`. Make sure that the Jupyter kernel has been added to your `PATH` by running `jupyter --version` and checking that both `ipython` and `jupyter_client` appear.
4. **Wezterm or Nerd Fonts (Required):** For the glyphs in *resolution* to appear properly, you are either going to need to install a Nerd Font [here](https://www.nerdfonts.com/) and set your terminal to use it, or simply install the wezterm terminal emulator, which uses a Nerd Font as a fallback font. Wezterm is also very easily customizable, and is what I use. You can install it [here](https://wezfurlong.org/wezterm/installation.html). You may want to set it as your default terminal emulator to simplify the launching process. Then, to use *resolution*, launch `wezterm` and then run the command to launch *resolution* (usually `nvim` unless you used the advanced configuration method described at the end of Step 3 of the previous section).
5. **SageMath (Recommended):**  If you want to use the SageMath kernel in the Notebook (which is highly useful), install SageMath [here](https://doc.sagemath.org/html/en/installation/index.html). Then, install the SageMath Jupyter kernel using `sudo jupyter kernelspec install $SAGEMATH/local/share/jupyter/kernels/sagemath`, where `$SAGEMATH` is your SageMath root directory. For more details, see [this StackExchange answer](https://stackoverflow.com/questions/39296020/how-to-install-sagemath-kernel-in-jupyter).
6. **GAP (Optional):** If you want to use the GAP kernel, which can do numerous operations with groups efficiently, install GAP [here](https://www.gap-system.org/Download/). Ensure that GAP is in your `PATH` by running `gap`. Then, download the GAP Jupyter kernel, and all of its dependent packages, using the download link [here](https://www.gap-system.org/Packages/jupyterkernel.html). Run `GAPInfo.RootPaths;` in GAP (which can be started with the command `gap`) to find the root directories of `GAP`. Then, place each of the folders you downloaded in a subfolder labeled `pkg` of a GAP root directory. Check that it is available using `LoadPackage("JupyterKernel");` (again in GAP). Then, run `pip install .` and ensure that the Jupyter kernel is still in your path. For troubleshooting, see [here](https://github.com/gap-packages/JupyterKernel).
7. **lazygit (Optional):** If you plan on using git to back up your projects in any way more sophisticated than the monorepo that is built into *resolution*, I suggest using the lazygit UI; a shortcut for it is built into *resolution*. You can install lazygit using any one of the methods [here](https://github.com/jesseduffield/lazygit#installation).

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
