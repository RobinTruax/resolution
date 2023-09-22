--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computation math.

This file contains utilities for the file system module in particular.

Copyright (C) 2023 Roshan Truax

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) at any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

------------------------------------------------------------------------------]]

local utilities = {}

--------------------------------- dependencies ---------------------------------

local prefs = require('config.preferences')
local cfg_filesys = require('config.advanced.filesys')
local states = require('core.states')
local core_utils = require('core.utilities')

----------------------- ensure project directory exists ------------------------

utilities.project_dir_check = function()
    if core_utils.directory_exists(prefs.project_root_path) then
        return true
    end
    vim.notify('Project folder does not exist. Creating now...', vim.log.levels.WARN)
    core_utils.create_directory(prefs.project_root_path)
    return false
end

----------------------------- get most recent file -----------------------------

utilities.most_recent_file = function(path, force)
    -- either if the data has not been compiled or if the system requests a "force"
    if states.most_recent_files[path] == nil or force == true then
        if vim.g.windows == false then
            local cmd = 'ls -t ' .. path .. '/*.tex | head -n1'
            local untrimmed = vim.fn.system(cmd)
            states.most_recent_files[path] = untrimmed:sub(1, -2)
        elseif vim.g.windows == true then
            error('Not implemented on Windows yet.')
        else
            error('Unrecognized operating system.')
        end
    end
    return states.most_recent_files[path]
end

--------------------------- get project information ----------------------------

utilities.get_projects = function(path, depth)
    -- clean path
    if path == nil then
        vim.notify('Error')
        return {}
    end

    depth = depth or 0
    if depth > 5 then
        return {}
    end

    -- find subdirectories
    local subdirs = core_utils.get_subdirs_in_directory(path)
    local projects = {}

    -- archive folder
    local archive = prefs.project_root_path .. '/' .. cfg_filesys.archive_project_folder

    -- iterate
    for _,v in ipairs(subdirs) do
        -- check if directory is project
        local fn = v .. '/' .. cfg_filesys.project_info_name
        if core_utils.file_exists(fn) then
            -- add if true
            projects[#projects + 1] = fn
        -- check if directory is not archive
        elseif v:find(archive) == nil then
            -- recurse if false
            -- vim.notify("Rec")
            projects = core_utils.table_concat(
                projects,
                utilities.get_projects(v, depth + 1)
            )
        end
    end

    -- return
    return projects
end

utilities.get_project_info_filepaths = function()
    local files = {}
    local string_of_files = ''

    -- check for project folder
    utilities.project_dir_check()

    -- check for required folders
    require('filesys.actions.required_folders')()

    -- get list of files
    return utilities.get_projects(prefs.project_root_path)
end

------------------------- compile project information --------------------------

utilities.compile_project_infos = function()
    -- initialization
    local table_of_project_infos = {}

    -- compilation process
    for _, project_info in pairs(utilities.get_project_info_filepaths()) do
        -- attempt to access project discovery information
        local success, decoded_project_info = pcall(function()
            return vim.json.decode(core_utils.string_from_file(project_info))
        end)
        -- if attempt succeeded
        if success == true then
            -- create decoded project info and append to table
            decoded_project_info['filepath'] = project_info
            table_of_project_infos[#table_of_project_infos + 1] = decoded_project_info
        -- if attempt failed
        elseif success == false then
            -- get subtitute title
            local category = vim.fn.fnamemodify(project_info, ':p:h:h:t')
            local project = vim.fn.fnamemodify(project_info, ':h:t')
            local title = string.format('%s/%s', category, project)
            -- create decoded project info and append to table
            decoded_project_info = { title = title, filepath = project_info }
            table_of_project_infos[#table_of_project_infos + 1] = decoded_project_info
            -- notify user of error
            vim.notify(
                string.format('Project Information for "%s" is Corrupted', title), 
                vim.log.levels.WARN
            )
        end
    end

    return table_of_project_infos
end

--------------------------------------------------------------------------------

return utilities

--------------------------------------------------------------------------------
