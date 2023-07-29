--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This file implements a menu for choosing a project to edit the project info for.

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
local core_utils = require('core.utilities')
local project_info_previewer = require('filesys.project_info_previewer')
local project_picker = require('filesys.project_picker')

------------------------------- action function --------------------------------

local action_function = function(selection, opts)
    -- check for exit
    if selection ~= nil then
        -- get path of file to edit
        local to_edit = core_utils.trim_path_dir(selection['value']['filepath']) ..
            '/' .. config_filesys.project_info_name
        -- notify user
        vim.notify(string.format('Project %s Information Opened', selection['value']['title']), vim.log.levels.INFO)
        -- start editing
        vim.cmd('edit ' .. to_edit)
    end
end

-------------------------------- create picker ---------------------------------

local edit_project = project_picker('Edit Project Information', project_info_previewer, action_function)

--------------------------------------------------------------------------------

return edit_project

--------------------------------------------------------------------------------
