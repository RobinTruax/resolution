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
    error('Project Folder Does Not Exist')
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

utilities.get_project_info_filepaths = function()
    local files = {}
    local string_of_files = ''

    -- get list of files
    if vim.g.windows == false then
        string_of_files = vim.fn.system(string.format(
            "find %s -name '%s'",
            prefs.project_root_path,
            cfg_filesys.project_info_name
        ))
    elseif vim.g.windows == true then
        error('Not implemented on Windows yet.')
    else
        error('Unrecognized operating system.')
    end

    -- trim list of files
    for filename in string_of_files:gmatch('[^\r\n]+') do
        -- get project root
        local root = prefs.project_root_path
        -- get archive folder
        local archive = root .. '/' .. cfg_filesys.archive_project_folder
        -- remove files in the archive folder
        if filename:find(archive) == nil then
            files[#files + 1] = filename
        end
    end

    -- return
    return files
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

    -- updating global state variable
    return table_of_project_infos
    -- states.table_of_project_infos = table_of_project_infos
end

--------------------------------------------------------------------------------

return utilities

--------------------------------------------------------------------------------
