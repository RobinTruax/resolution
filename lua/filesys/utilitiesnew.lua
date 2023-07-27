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

----------------------------- get most recent file -----------------------------

utilities.most_recent_file = function(path, force)
    -- either if the data has not been compiled or if the system requests a "force"
    if states.most_recent_files[path] == nil or force == true then
        if vim.g.windows == false then
            local cmd = 'ls -t ' .. path .. '/*.tex | head -n1'
            local untrimmed = vim.fn.system(cmd)
            states.most_recent_files[path] = untrimmed:sub(1, -2)
        elseif vim.g.windows == true then
            error('Not implemented on Windows')
        else
            error('Unrecognized operating system.')
        end
    end
    return states.most_recent_files[path]
end

--------------------------- get project information ----------------------------

utilities.get_all_project_infos = function()
    local files = {}
    local string_of_files = ''
    if vim.g.windows == false then
        string_of_files = io.popen('find ' ..
        prefs.project_root_path .. ' -name ' .. "'" .. cfg_filesys.project_info_name .. "'")
    elseif vim.g.windows == true then
        error('Not implemented yet.')
    else
        error('Windows variable has unrecognized value in function which makes system call.')
    end
    for filename in string_of_files:lines() do
        local root = prefs.project_root_path:gsub('(.-)[\\/]+$', '%1')
        local archive = root .. '/' .. cfg_filesys.archive_project_folder
        if filename:find(archive) == nil then
            files[#files + 1] = filename
        end
    end
    string_of_files:close()
    return files
end

------------------------- compile project information --------------------------

utilities.compile_project_infos = function(force)
    if force == true then
        states.project_info_compiled = false
    end
    if states.project_info_compiled == false or force == true then
        local table_of_project_infos = {}
        for _, project_info in pairs(utilities.get_all_project_infos()) do
            local success, decoded_project_info = pcall(function()
                return vim.json.decode(utilities.read_file(project_info))
            end)
            if success == true then
                decoded_project_info['filepath'] = project_info
                table_of_project_infos[#table_of_project_infos + 1] = decoded_project_info
            elseif success == false then
                local category = vim.fn.fnamemodify(project_info, ':p:h:h:t')
                local project = vim.fn.fnamemodify(project_info, ':h:t')
                vim.notify('Warning: Project Information for "'.. category ..'/' .. project ..'" is Corrupted', vim.log.levels.WARN)
            end
        end
        states.table_of_project_infos = table_of_project_infos
        states.project_info_compiled = true
    end
    return states.table_of_project_infos
end

--------------------------------------------------------------------------------

return utilities

--------------------------------------------------------------------------------
