--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This implements a series of menus which together allow the user to create a new
project.

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

local prefs = require('config.preferences')
local config_filesys = require('config.advanced.filesys')
local core_utils = require('core.utilities')
local choose_template = require('filesys.actions.choose_template')

------------------------------- get project name -------------------------------

local template_directory = core_utils.config_path() .. '/tex/templates/'
local create_project = {}

create_project.name = function(name, opts)
    vim.ui.input({
        -- options
        prompt = name or 'Project Name: ',
        default = '',
        relative = 'editor',
    }, function(input)
        -- action on input
        if input ~= nil then
            -- reset if bad name
            if input:match("[^%w%s]") ~= nil then
                create_project.name('Invalid Name, Try Again: ')
            -- create otherwise
            else
                create_project.type(input, opts)
            end
        end
    end)
end

----------------------- get project type ------------------------

create_project.type = function(name, opts)
    vim.ui.select(config_filesys.project_icons, {
        -- options
        prompt = 'Type of Project "' .. name .. '"',
        format_item = function(item)
            return ' ' .. item[2] .. '  ' .. item[1]
        end,
    }, function(choice)
        -- if choice is valid, move on to getting location
        if choice ~= nil then
            create_project.location(name, choice[2], opts)
        end
    end)
end

--------------------- get project location ----------------------

create_project.location = function(name, proj_type, opts)
    vim.ui.select(core_utils.get_subdirs_in_directory(prefs.project_root_path), {
        -- options
        prompt = 'Folder for Project "' .. name .. '"',
        format_item = function(item)
            return ' ' .. core_utils.trim_path_file(item)
        end,
    }, function(choice)
        -- if choice is valid, create the project and move into it
        if choice ~= nil then
            -- compute directory name
            local dir_name = choice .. '/' .. name:gsub('[%s-]+', '_'):gsub('[^%w_]', ''):lower()
            -- compute filename
            local file_name = dir_name .. '/' .. config_filesys.project_info_name
            -- make directory
            core_utils.create_directory(dir_name)
            -- make json file
            core_utils.write_table_to_file({ title = name, type = proj_type }, file_name)
            -- cd into directory
            vim.cmd('cd ' .. dir_name)
            -- create file template
            choose_template({ prompt_title = 'Create Starter File' })
        end
    end)
end

-----------------------------------------------------------------

return create_project.name

-----------------------------------------------------------------
