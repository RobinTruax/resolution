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

    [''] = {
        desc = 'resolution',
        cmd = false,
    },
    ['<leader>'] = {
        desc = 'all keybinds',
        cmd = '<cmd> WhichKey <cr>',
    },

    ---------------------------------- top-level -----------------------------------

    ['b'] = {
        desc = 'search [b]uffers',
        cmd = '<cmd> Telescope buffers <cr>'
    },
    ['c'] = {
        desc = '[c]omputation (the napkin)',
        mode = { 'n', 'v' },
        cmd = {
            function()
                require('computation.napkin-actions').mount()
            end,
            function()
                require('computation.napkin-actions').mount_from_visual()
            end,
        },
    },
    ['C'] = {
        desc = '[C]omputation (the notebook)',
        mode = 'n',
        cmd = function()
            require('computation.notebook').initialize()
        end
    },
    ['d'] = {
        desc = '[d]elete buffer',
        cmd = function()
            require('core.ui').buf_del_wrapper()
        end,
    },
    ['D'] = {
        desc = '[D]elete all buffers',
        cmd = function()
            vim.cmd('bufdo :Bdelete')
            require('mini.starter').open()
        end
    },
    ['e'] = {
        desc = '[e]xplore document',
        cmd = function()
            require('nvim-navbuddy').open()
        end
    },
    ['E'] = {
        desc = '[E]xplore files',
        cmd = '<cmd> NvimTreeFindFileToggle <cr>'
    },
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
    ['h'] = {
        desc = '[h]elp and doc.',
        cmd = '<cmd> e ' .. vim.fn.stdpath('config') .. '/documentation.md <cr>'
    },
    ['j'] = {
        desc = '[j]ump in document',
        cmd = '<cmd> Telescope lsp_document_symbols <cr>'
    },
    ['J'] = {
        desc = '[J]ump in project',
        cmd = '<cmd> Telescope lsp_workspace_symbols <cr>'
    },
    ['L'] = {
        desc = '[L]atex compilation',
        cmd = '<cmd> VimtexCompile <cr>'
    },
    ['p'] = {
        desc = '[p]eek at reference',
        cmd = '<cmd> Lspsaga peek_definition <cr>',
    },
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
    ['Q'] = {
        desc = '[q]uit/save all',
        cmd = '<cmd> silent wqa <cr>'
    },
    ['S'] = {
        desc = '[S]tart screen',
        cmd = function()
            require('mini.starter').open()
        end
    },
    ['t'] = {
        desc = '[t]erminal',
        cmd = '<cmd> ToggleTerm <cr>'
    },
    ['v'] = {
        desc = '[v]iew files in project',
        cmd = function()
            require('filesys.actions.choose_project_and_file')()
        end
    },
    ['V'] = {
        desc = '[V]iew projects',
        cmd = function()
            require('filesys.actions.choose_project')({ pick_files_after = true })
        end
    },

    --------------------------------- options (o) ----------------------------------

    ['o'] = {
        desc = '[o]ptions',
        cmd = false,
    },
    ['oc'] = {
        desc = '[c]olorscheme',
        cmd = ''
    },
    ['od'] = {
        desc = 'toggle [d]ark mode',
        cmd = ''
    },
    ['ow'] = {
        desc = 'toggle [w]rap',
        cmd = function()
            vim.o.wrap = not vim.o.wrap
        end
    },
    ['on'] = {
        desc = 'toggle [n]umbering',
        cmd = function()
            vim.o.number = not vim.o.number
        end
    },
    ['or'] = {
        desc = 'toggle [r]elative numbering',
        cmd = function()
            vim.o.relativenumber = not vim.o.relativenumber
        end
    },
    ['ov'] = {
        desc = 'toggle [v]irtual editing',
        cmd = function()
            vim.o.virtualedit = not vim.o.virtualedit
        end
    },
    ['os'] = {
        desc = 'toggle auto[s]nippets',
        cmd = ''
    },
    ['om'] = {
        desc = 'toggle autoco[m]plete',
        cmd = ''
    },
    ['oi'] = {
        desc = 'toggle auto[i]ndent',
        cmd = function()
            vim.o.autoindent = not vim.o.autoindent
        end
    },
    ['of'] = {
        desc = 'toggle [f]ocus mode',
        cmd = function()
            if vim.o.laststatus ~= 0 then
                vim.o.laststatus = 0
            elseif vim.o.laststatus ~= 2 then
                vim.o.laststatus = 2
            end

            if vim.o.showtabline ~= 0 then
                vim.o.showtabline = 0
            elseif vim.o.showtabline ~= 2 then
                vim.o.showtabline = 2
            end

            if vim.o.cmdheight ~= 0 then
                vim.o.cmdheight = 0
            elseif vim.o.cmdheight ~= 1 then
                vim.o.cmdheight = 1
            end
        end
    },
    ['ou'] = {
        desc = 'toggle c[u]rsorline',
        cmd = function()
            vim.o.cursorline = not vim.o.cursorline
        end
    },
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
    ['oz'] = {
        desc = 'toggle spell-checker',
        cmd = function()
            vim.o.spell = not vim.o.spell
        end
    },

    ---------------------------------- search (s) ----------------------------------

    ['s'] = {
        desc = '[s]earch',
        cmd = false,
    },
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
    ['sf'] = {
        desc = '[s]earch [f]iles',
        cmd = '<cmd> Telescope find_files cwd=~ <cr>'
    },
    ['sh'] = {
        desc = '[s]earch [h]idden',
        cmd = '<cmd> Telescope find_files cwd=~ hidden=true <cr>'
    },
    ['sc'] = {
        desc = '[s]earch [c]ommands',
        cmd = '<cmd> Telescope command_history <cr>'
    },
    ['ss'] = {
        desc = '[s]earch [s]earches',
        cmd = '<cmd> Telescope search_history <cr>'
    },
    ['sm'] = {
        desc = '[m]ulti [s]earch/rep',
        cmd = '<cmd> MurenOpen <cr>'
    },
    ['sg'] = {
        desc = '[g]rep in file',
        cmd = function()
            require('telescope.builtin').live_grep({ search_dirs = { vim.fn.expand('%:p') } })
        end,
    },
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
    ['sy'] = {
        desc = '[s]earch [y]anks',
        cmd = '<cmd> Telescope neoclip plus prompt_title=Yanks<cr>'
    },
    ['su'] = {
        desc = '[s]earch [u]ndo tree',
        cmd = '<cmd> Telescope undo <cr>'
    },
    ['sr'] = {
        desc = '[s]earch rsltn files',
        cmd = '<cmd> Telescope find_files cwd=' .. core_utils.config_path() .. ' <cr>'
    },
    ['sk'] = {
        desc = '[s]earch keybinds',
        cmd = '<cmd> Telescope keybinds <cr>'
    },

    ----------------------------- file management (f) ------------------------------

    ['f'] = {
        desc = '[f]ile management',
        cmd = false,
    },
    ['fc'] = {
        desc = '[c]reate project',
        cmd = function()
            require('filesys.actions.create_project')()
        end,
    },
    ['fa'] = {
        desc = '[a]rchive project',
        cmd = function()
            require('filesys.actions.archive_project')()
        end,
    },
    ['fe'] = {
        desc = '[e]dit project info',
        cmd = function()
            require('filesys.actions.edit_project_info')()
        end,
    },
    ['fn'] = {
        desc = '[n]ew file from template',
        cmd = function()
            require('filesys.actions.choose_template')()
        end,
    },

    ------------------------------ git and github (g) ------------------------------

    ['g'] = {
        desc = '[g]it and github',
        cmd = false,
    },
    ['gl'] = {
        desc = '[l]azy[g]it',
        cmd = function() git.lazygit() end,
    },
    ['gu'] = {
        desc = 'configure [g]ithub [u]ser',
        cmd = function() git.configure_github_user() end,
    },
    ['gh'] = {
        desc = 'configure [g]it[h]ub',
        cmd = function() git.configure_github_repos() end,
    },
    ['gs'] = {
        desc = '[g]it [s]tandard repos',
        cmd = function() git.configure_standard_repos() end,
    },
    ['gP'] = {
        desc = '[P]ull math [g]its',
        cmd = function() git.pull_git_in_math() end,
    },
    ['gp'] = {
        desc = 'commit/[p]ush math [g]its',
        cmd = function() git.push_git_in_math() end,
    },
    -- ['gP'] = {
    --     desc = 'pull [g]it',
    --     cmd = function() git.pull_git() end,
    -- },
    -- ['gp'] = {
    --     desc = 'commit/push [G]it',
    --     cmd = function() git.push_git() end,
    -- },
    ['gR'] = {
        desc = 'project from [g]ithub [R]epo',
        cmd = function() git.github_to_project() end,
    },
    ['gr'] = {
        desc = '[g]ithub [r]epo from project',
        cmd = function() git.project_to_github() end,
    },
    ['gt'] = {
        desc = '[t]oggle file publicity',
        cmd = function() git.toggle_file_publicity() end,
    },
    ['gT'] = {
        desc = '[T]oggle project publicity',
        cmd = function() git.toggle_project_publicity() end,
    },

    ------------------------------ tex operations (t) ------------------------------

    ['l'] = {
        desc = '[t]ex operations',
        cmd = false,
    },
    ['lc'] = {
        desc = '[l]atex [c]ite',
        cmd = function()
        end,
    },
    ['lC'] = {
        desc = '[l]atex [C]olor editor',
        cmd = '<cmd> CccPick <cr>',
    },
    -- ['lm'] = {
    --     desc = '[l]atex [m]atrices',
    --     cmd = false,
    -- },
    -- ['lt'] = {
    --     desc = '[l]atex [t]tables',
    --     cmd = false,
    -- },
    ['le'] = {
        desc = '[l]atex [e]rrors',
        cmd = '<cmd> VimtexErrors <cr>',
    },
    ['ls'] = {
        desc = '[l]atex sync[t]ex',
        cmd = '<cmd> VimtexView <cr>',
    },
    ['lw'] = {
        desc = '[l]atex [w]ord count',
        cmd = '<cmd> VimtexCountWords <cr>',
    },
    ['lx'] = {
        desc = '[l]atex clean au[x]',
        cmd = '<cmd> VimtexClean <cr>',
    },
    ['lR'] = {
        desc = '[l]atex [R]ename',
        cmd = function()
            vim.lsp.buf.rename()
        end
    },

    ---------------------- tex extensions (x) -----------------------

    -- ['x'] = {
    --     desc = 'tex e[x]tensions',
    --     cmd = false,
    -- },
    -- ['xo'] = {
    --     desc = 'e[x]tension: [o]verleaf',
    --     cmd = false
    -- },
    -- ['xc'] = {
    --     desc = 'e[x]tension: [c]ommutative diagrams',
    --     cmd = false
    -- },
    -- ['xq'] = {
    --     desc = 'e[x]tension: [q]uantum circuits',
    --     cmd = false
    -- },
    -- ['xk'] = {
    --     desc = 'e[x]tension: [k]nots',
    --     cmd = false
    -- },
    -- ['xg'] = {
    --     desc = 'e[x]tension: [g]raphs',
    --     cmd = false
    -- },
    -- ['xt'] = {
    --     desc = 'e[x]tension: [t]ikz editor',
    --     cmd = false
    -- },
    -- ['xi'] = {
    --     desc = 'e[x]tension: [i]nkscape',
    --     cmd = false
    -- },

}

--------------------------------------------------------------------------------
