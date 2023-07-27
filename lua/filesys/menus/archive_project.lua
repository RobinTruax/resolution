--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computation math.

This file creates a menu for choosing a project to archive.

Copyright (C) 2023 Roshan Truax

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) at any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

------------------------------------------------------------------------------]]

--------------------------------- dependencies ---------------------------------

-- resolution dependencies
local config_filesys = require('config.advanced.filesys')
local prefs = require('config.preferences')
local states = require('core.states')
local utilities = require('filesys.menus.utilities')
local previewer = require('filesys.menus.project_previewer')

-- telescope dependencies
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

---------------------------------- main menu -----------------------------------

local archive_project = function(opts)
    opts = opts or {}
    pickers.new(opts, {
        prompt_title = "Archive Project",
        -- configuring menu itself
        finder = finders.new_table {
            results = utilities.compile_project_infos(),
            entry_maker = function(entry)
                local icon = ' '
                for _, v in ipairs(config_filesys.project_icons) do
                    if v[1] == entry['type'] then
                        icon = v[2]
                    end
                end
                return {
                    value = entry,
                    display = icon .. '   ' .. entry['title'],
                    ordinal = entry['title'],
                }
            end
        },
        sorter = conf.generic_sorter(opts),
        previewer = previewer.new(opts),
        -- configuring action on item selection
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                local archive = prefs.project_root_path:gsub('(.-)[\\/]+$', '%1') .. '/' .. config_filesys.archive_project_folder .. '/' .. vim.fn.fnamemodify(selection['value']['filepath'], ':h:t')
                local current = utilities.trim_path_dir(selection['value']['filepath'])
                vim.notify(string.format('Project %s Archived', selection['value']['title']), vim.log.levels.WARN)
                utilities.mv_folder(current, archive)
                states.project_info_compiled = false
                require('filesys.menus.archive_project')()
            end)
            return true
        end,
    -- closing and calling menu
    }):find()
end

--------------------------------------------------------------------------------

return archive_project

--------------------------------------------------------------------------------
