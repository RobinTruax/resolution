--[[------------------- resolution v0.1.0 -----------------------

menu for creating new project

---------------------------------------------------------------]]

------------------------- dependencies --------------------------

local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local previewers = require('telescope.previewers')

local prefs = require('config.preferences')
local config_filesys = require('config.advanced.filesys')
local states = require('core.states')
local utilities = require('filesys.menus.utilities')
local choose_template = require('filesys.menus.choose_template')

----------------------- get project name ------------------------

local template_directory = vim.fn.stdpath('config') .. '/tex/templates/'
local create_project = {}

create_project.name = function(name, opts)
    vim.ui.input({
        prompt = name or 'Project Name: ',
        default = '',
        relative = 'editor',
    }, function(input)
        if input ~= nil then
            if input:match("[^%w%s]") ~= nil then
                create_project.name('Invalid Name, Try Again: ')
            else
                create_project.type(input, opts)
            end
        end
    end)
end

----------------------- get project type ------------------------

create_project.type = function(name, opts)
    vim.ui.select(config_filesys.project_icons, {
        prompt = 'Type of Project "' .. name .. '"',
        format_item = function(item)
            return ' ' .. item[2] .. '  ' .. item[1]
        end,
    }, function(choice)
        if choice ~= nil then
            create_project.location(name, proj_type, opts)
        end
    end)
end

--------------------- get project location ----------------------

create_project.location = function(name, proj_type, opts)
    vim.ui.select(utilities.get_subdirs_in_directory(prefs.project_root_path), {
        prompt = 'Folder for Project "' .. name .. '"',
        format_item = function(item)
            return ' ' .. utilities.trim_path_file(item)
        end,
    }, function(choice)
        if choice ~= nil then
            local dir_name = choice .. '/' .. name:gsub('[%s-]+', '_'):gsub('[^%w_]', ''):lower()
            local file_name = dir_name .. '/' .. config_filesys.project_info_name
            -- make directory
            utilities.make_dir(dir_name)
            -- make json file
            utilities.write_table_to_file({ title = name, type = proj_type }, file_name)
            -- cd into directory
            vim.cmd('cd ' .. dir_name)
            -- create file template
            choose_template({ prompt_title = 'Create Starter File' })
            -- let the system know to recompile projects
            states.project_info_compiled = false
        end
    end)
end

-----------------------------------------------------------------

return create_project.name

-----------------------------------------------------------------
