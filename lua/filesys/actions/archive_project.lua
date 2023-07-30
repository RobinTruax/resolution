--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

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

local config_filesys = require('config.advanced.filesys')
local prefs = require('config.preferences')
local core_utils = require('core.utilities')
local project_previewer = require('filesys.project_previewer')
local project_picker = require('filesys.project_picker')

------------------------------- action function --------------------------------

local action_function = function(selection, opts)
    -- check for exit
    if selection ~= nil then
        -- figure out new folder name
        local project_filename = vim.fn.fnamemodify(selection['value']['filepath'], ':h:t')
        local projects_path = prefs.project_root_path
        local archive = string.format('%s/%s/%s', projects_path, config_filesys.archive_project_folder, project_filename)
        -- figure out old folder name
        local current = core_utils.cut_path_to_project(selection['value']['filepath'])
        -- notify user
        vim.notify(string.format('Project %s Archived', selection['value']['title']), vim.log.levels.WARN)
        -- move folder
        core_utils.move_folder(current, archive)
        require('filesys.actions.archive_project')()
    end
end

------------------------------- creating picker --------------------------------

local archive_project = project_picker('Archive Project', project_previewer, action_function)

--------------------------------------------------------------------------------

return archive_project

--------------------------------------------------------------------------------
