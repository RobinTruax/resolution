--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This files defined keybinds for resolution's main operations; use use the leader
key set in config.preferences.

Copyright (C) 2023 Roshan Truax

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) at any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

------------------------------------------------------------------------------]]

local prefs = require('config.preferences')
local core_utils = require('core.utilities')
local git = require('filesys.github')

return {

    -- sets up command viewing
    [''] = {
        desc = 'resolution',
        cmd = false,
    },

    -- enables users to see all keybinds
    ['<leader>'] = {
        desc = 'all keybinds',
        cmd = '<cmd> WhichKey <cr>',
    },

    ---------------------------------- top-level -----------------------------------

    -- search buffers
    ['b'] = {
        desc = 'search [b]uffers',
        cmd = '<cmd> Telescope buffers <cr>'
    },

    -- computation (for the napkin)
    ['c'] = {
        desc = '[c]omputation (the napkin)',
        mode = { 'n', 'v' },
        cmd = {
            function()
                require('computation.napkin.actions').mount()
            end,
            function()
                require('computation.napkin.actions').mount_from_visual()
            end,
        },
    },

    -- computation (for the notebook)
    ['C'] = {
        desc = '[C]omputation (the notebook)',
        mode = 'n',
        cmd = function()
            require('computation.notebook.files').main()
        end
    },

    -- delete buffer
    ['d'] = {
        desc = '[d]elete buffer',
        cmd = function()
            require('core.ui').buf_del_wrapper()
        end,
    },

    -- delete all buffers
    ['D'] = {
        desc = '[D]elete all buffers',
        cmd = function()
            vim.cmd('bufdo :Bdelete')
            require('mini.starter').open()
        end
    },

    -- explore document
    ['e'] = {
        desc = '[e]xplore document',
        cmd = function()
            require('nvim-navbuddy').open()
        end
    },

    -- explore files
    ['E'] = {
        desc = '[E]xplore files',
        cmd = '<cmd> NvimTreeFindFileToggle <cr>'
    },

    -- format tex or code
    ['F'] = {
        desc = '[F]ormat TeX or code',
        cmd = function()
            if vim.bo.filetype == 'tex' then
                vim.cmd('write')
                vim.notify('Formatting with latexindent.', vim.log.levels.INFO)
                local filename = vim.fn.expand('%:p')
                local format_style_file = prefs.format_style_file
                vim.fn.system('latexindent -l ' .. format_style_file .. ' -m ' .. filename ..
                    ' > ' .. filename .. '-prettied')
                vim.fn.system('mv ' .. filename .. '-prettied ' .. filename)
                vim.cmd('edit')
            else
                vim.lsp.buf.format()
            end
        end
    },

    -- help and documentation
    ['h'] = {
        desc = '[h]elp and doc.',
        cmd = '<cmd> e ' .. vim.fn.stdpath('config') .. '/documentation.md <cr>'
    },

    -- jump in document
    ['j'] = {
        desc = '[j]ump in document',
        cmd = '<cmd> Telescope lsp_document_symbols <cr>'
    },

    -- jump in workspace
    ['J'] = {
        desc = '[J]ump in project',
        cmd = '<cmd> Telescope lsp_workspace_symbols <cr>'
    },

    -- compile latex
    ['L'] = {
        desc = '[L]atex compilation',
        cmd = '<cmd> VimtexCompile <cr>'
    },

    -- peek at reference
    ['p'] = {
        desc = '[p]eek at reference',
        cmd = '<cmd> Lspsaga peek_definition <cr>',
    },

    -- quit and save
    ['q'] = {
        desc = '[q]uit/save',
        cmd = function()
            if vim.bo.buftype == '' then
                vim.cmd('wq')
            else
                vim.cmd('q')
            end
        end
    },

    -- quit and save all
    ['Q'] = {
        desc = '[q]uit/save all',
        cmd = '<cmd> silent wqa <cr>'
    },

    -- reset screen
    ['R'] = {
        desc = '[R]eset screen',
        cmd = function()
            require('mini.starter').open()
        end
    },

    -- synctex
    ['S'] = {
        desc = '[S]ynctex',
        cmd = '<cmd> VimtexView <cr>',
    },

    -- terminal
    ['t'] = {
        desc = '[t]erminal',
        cmd = '<cmd> ToggleTerm <cr>'
    },

    -- view files in project
    ['v'] = {
        desc = '[v]iew files in project',
        cmd = function()
            require('filesys.actions.choose_project_and_file')()
        end
    },

    -- view projects
    ['V'] = {
        desc = '[V]iew projects',
        cmd = function()
            require('filesys.actions.choose_project')({ pick_files_after = true })
        end
    },

    --------------------------------- options (o) ----------------------------------

    -- options
    ['o'] = {
        desc = '[o]ptions',
        cmd = false,
    },

    -- colorscheme options
    ['oc'] = {
        desc = 'rotate [c]olorscheme',
        cmd = function()
            local colorschemes = require('config.aesthetics').configured_colorschemes
            for k,v in ipairs(colorschemes) do
                if vim.g.colorscheme == v then
                    local new_colorscheme = colorschemes[k%(#colorschemes) + 1]
                    require('core.colors').set_colorscheme(new_colorscheme, vim.o.background)
                    break
                end
            end
        end,
    },

    -- dark mode
    ['od'] = {
        desc = 'toggle [d]ark mode',
        cmd = function()
            if vim.o.background == 'dark' then
                require('core.colors').set_colorscheme(vim.g.colorscheme, 'light')
            else
               require('core.colors').set_colorscheme(vim.g.colorscheme, 'dark')
           end
        end,
    },

    -- toggle wrap
    ['ow'] = {
        desc = 'toggle [w]rap',
        cmd = function()
            vim.o.wrap = not vim.o.wrap
        end
    },

    -- toggle numbering
    ['on'] = {
        desc = 'toggle [n]umbering',
        cmd = function()
            vim.o.number = not vim.o.number
        end
    },

    -- toggle relative numbering
    ['or'] = {
        desc = 'toggle [r]elative numbering',
        cmd = function()
            vim.o.relativenumber = not vim.o.relativenumber
        end
    },

    -- toggle virtual editing
    ['ov'] = {
        desc = 'toggle [v]irtual editing',
        cmd = function()
            vim.o.virtualedit = not vim.o.virtualedit
        end
    },

    -- toggle autoindent
    ['oi'] = {
        desc = 'toggle auto[i]ndent',
        cmd = function()
            vim.o.autoindent = not vim.o.autoindent
        end
    },

    -- toggle focus mode
    -- ['of'] = {
    --     desc = 'toggle [f]ocus mode',
    --     cmd = function()
    --         if vim.o.laststatus ~= 0 then
    --             vim.o.laststatus = 0
    --         elseif vim.o.laststatus ~= 2 then
    --             vim.o.laststatus = 2
    --         end
    --
    --         if vim.o.showtabline ~= 0 then
    --             vim.o.showtabline = 0
    --         elseif vim.o.showtabline ~= 2 then
    --             vim.o.showtabline = 2
    --         end
    --
    --         if vim.o.cmdheight ~= 0 then
    --             vim.o.cmdheight = 0
    --         elseif vim.o.cmdheight ~= 1 then
    --             vim.o.cmdheight = 1
    --         end
    --     end
    -- },

    -- toggle cursorline
    ['ou'] = {
        desc = 'toggle c[u]rsorline',
        cmd = function()
            vim.o.cursorline = not vim.o.cursorline
        end
    },

    -- toggle conceal
    ['ol'] = {
        desc = 'toggle concea[l]',
        cmd = function()
            if vim.o.conceallevel ~= 0 then
                vim.o.conceallevel = 0
            elseif vim.o.conceallevel ~= 1 then
                vim.o.conceallevel = 1
            end
        end
    },

    -- toggle spell-checker
    ['oz'] = {
        desc = 'toggle spell-checker',
        cmd = function()
            vim.o.spell = not vim.o.spell
        end
    },

    ---------------------------------- search (s) ----------------------------------

    -- search
    ['s'] = {
        desc = '[s]earch',
        cmd = false,
    },

    -- search system file explorer
    ['se'] = {
        desc = 'System file [e]xplorer',
        cmd = function()
            if vim.g.windows == false then
                vim.cmd('call system("xdg-open " . expand("%:p:h"))')
            else
                vim.cmd('call system("start " . expand("%:p:h"))')
            end
        end
    },

    -- search files
    ['sf'] = {
        desc = '[s]earch [f]iles',
        cmd = '<cmd> Telescope find_files cwd=~ <cr>'
    },

    -- search hidden files
    ['sh'] = {
        desc = '[s]earch [h]idden',
        cmd = '<cmd> Telescope find_files cwd=~ hidden=true <cr>'
    },

    -- search commands
    ['sc'] = {
        desc = '[s]earch [c]ommands',
        cmd = '<cmd> Telescope command_history <cr>'
    },

    -- search searches
    ['ss'] = {
        desc = '[s]earch [s]earches',
        cmd = '<cmd> Telescope search_history <cr>'
    },

    -- grep in file
    ['sg'] = {
        desc = '[g]rep in file',
        cmd = function()
            require('telescope.builtin').live_grep({ search_dirs = { vim.fn.expand('%:p') } })
        end,
    },

    -- grep in project
    ['sG'] = {
        desc = '[G]rep in project',
        cmd = function()
            if core_utils.current_project_path() ~= nil then
                require('telescope.builtin').live_grep({
                    prompt_title = 'Grep in Project',
                    hide_path = false,
                    search_dirs = { core_utils.current_project_path() },
                })
            else
                require('telescope.builtin').live_grep({
                    prompt_title = 'Grep in Project',
                    hide_path = false,
                })
            end
        end,
    },

    -- grep visual selection in project
    ['sv'] = {
        mode = { 'n', 'v' },
        desc = 'grep [v]isual selection in project',
        cmd = function()
            if core_utils.current_project_path() ~= nil then
                require('telescope.builtin').grep_string({
                    prompt_title = 'Grep Visual in Project',
                    search_dirs = { core_utils.current_project_path() },
                })
            else
                require('telescope.builtin').grep_string({
                    prompt_title = 'Grep Visual in Project',
                })
            end
        end,
    },

    -- search yanks
    ['sy'] = {
        desc = '[s]earch [y]anks',
        cmd = '<cmd> Telescope neoclip plus prompt_title=Yanks<cr>'
    },

    -- search undo tree
    ['su'] = {
        desc = '[s]earch [u]ndo tree',
        cmd = '<cmd> Telescope undo <cr>'
    },

    -- search rsltn files
    ['sr'] = {
        desc = '[s]earch rsltn files',
        cmd = '<cmd> Telescope find_files cwd=' .. core_utils.config_path() .. ' <cr>'
    },

    -- search keybinds
    ['sk'] = {
        desc = '[s]earch keybinds',
        cmd = '<cmd> Telescope keymaps <cr>'
    },

    ----------------------------- file management (f) ------------------------------

    -- file management
    ['f'] = {
        desc = '[f]ile management',
        cmd = false,
    },

    -- check for required files
    -- ['fr'] = {
    --     desc = '[r]equired folders',
    --     cmd = function()
    --         require('filesys.actions.required_folders')()
    --     end,
    -- },

    -- create project
    -- ['fc'] = {
    --     desc = '[c]reate project',
    --     cmd = function()
    --         require('filesys.actions.create_project')()
    --     end,
    -- },

    -- archive project
    ['fa'] = {
        desc = '[a]rchive project',
        cmd = function()
            require('filesys.actions.archive_project')()
        end,
    },

    -- edit project info
    ['fe'] = {
        desc = '[e]dit project info',
        cmd = function()
            require('filesys.actions.edit_project_info')()
        end,
    },

    -- new file from template
    ['fn'] = {
        desc = '[n]ew file from template',
        cmd = function()
            require('filesys.actions.choose_template')()
        end,
    },

    ------------------------------ git and github (g) ------------------------------

    -- github
    ['g'] = {
        desc = '[g]it and github',
        cmd = false,
    },

    -- lazygit gui
    ['gg'] = {
        desc = 'lazy[g]it [g]ui',
        cmd = function() git.lazygit() end,
    },

    -- github user
    ['gu'] = {
        desc = '[g]ithub [u]ser',
        cmd = function() git.configure_github_user() end,
    },

    -- git configuration
    ['gc'] = {
        desc = '[g]it [c]onfiguration',
        cmd = function() git.configure_github_repos() end,
    },

    -- pull git repos
    ['gP'] = {
        desc = '[P]ull [g]it repos',
        cmd = function() git.pull_git_in_math() end,
    },

    -- commit/push git repos
    ['gp'] = {
        desc = 'commit/[p]ush [g]it repos',
        cmd = function() git.push_git_in_math() end,
    },

    ['gt'] = {
        desc = '[t]oggle file publicity',
        cmd = function() git.toggle_file_publicity() end,
    },
    ['gT'] = {
        desc = '[T]oggle project publicity',
        cmd = function() git.toggle_project_publicity() end,
    },

    ----------------------------- latex operations (l) -----------------------------

    -- latex operations
    ['l'] = {
        desc = 'la[t]ex operations',
        cmd = false,
    },

    -- latex citations
    ['lc'] = {
        desc = '[l]atex [c]ite',
        cmd = '<cmd> Telescope bibtex <cr>'
    },

    -- latex color picker
    ['lC'] = {
        desc = '[l]atex [C]olor picker',
        cmd = '<cmd> CccPick <cr>',
    },

    -- latex errors
    ['le'] = {
        desc = '[l]atex [e]rrors',
        cmd = '<cmd> VimtexErrors <cr>',
    },

    -- latex synctex
    ['ls'] = {
        desc = '[l]atex sync[t]ex',
        cmd = '<cmd> VimtexView <cr>',
    },

    -- latex word count
    ['lw'] = {
        desc = '[l]atex [w]ord count',
        cmd = '<cmd> VimtexCountWords <cr>',
    },

    -- latex clean auxiliary files
    ['lx'] = {
        desc = '[l]atex clean au[x]',
        cmd = '<cmd> VimtexClean <cr>',
    },

    -- latex rename variable
    -- ['lR'] = {
    --     desc = '[l]atex [R]ename',
    --     cmd = function()
    --         vim.lsp.buf.rename()
    --     end
    -- },

    ---------------------- tex extensions (x) -----------------------

    -- extensions (coming later)
    -- ['x'] = {
    --     desc = 'tex e[x]tensions',
    --     cmd = false,
    -- },
    -- overleaf
    -- ['xo'] = {
    --     desc = 'e[x]tension: [o]verleaf',
    --     cmd = false
    -- },
    -- commutative diagrams
    -- ['xc'] = {
    --     desc = 'e[x]tension: [c]ommutative diagrams',
    --     cmd = false
    -- },
    -- quantum circuits
    -- ['xq'] = {
    --     desc = 'e[x]tension: [q]uantum circuits',
    --     cmd = false
    -- },
    -- knots
    -- ['xk'] = {
    --     desc = 'e[x]tension: [k]nots',
    --     cmd = false
    -- },
    -- graphs
    -- ['xg'] = {
    --     desc = 'e[x]tension: [g]raphs',
    --     cmd = false
    -- },
    -- tikz editor
    -- ['xt'] = {
    --     desc = 'e[x]tension: [t]ikz editor',
    --     cmd = false
    -- },
    -- inkscape
    -- ['xi'] = {
    --     desc = 'e[x]tension: [i]nkscape',
    --     cmd = false
    -- },

}

--------------------------------------------------------------------------------
