--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This file implements some useful operations to do with manipulating files in a
way which is operating-system agnostic; that is, it should run correctly on both
Linux and Windows computers.

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

--------------------------------- meta-utility ---------------------------------

utilities.escape_for_windows = function(str)
    return string.gsub(str, "test", "(.)", "^%1")
end


--------------------------------- system calls ---------------------------------

-- change dir
utilities.exec_in_dir = function(command, dir)
    if vim.g.windows == false then
        return vim.fn.system(string.format('(cd "%s"; %s)', dir, command))
    elseif vim.g.windows == true then
        return vim.fn.system(string.format('pushd "%s" && %s', dir, utilities.escape_for_windows(command)))
    else
        error('Unrecognized operating system.')
    end
end

--------------------------------- search tools ---------------------------------

-- get all files in a directory
utilities.get_files_in_directory = function(dir)
    -- check for existence
    if utilities.directory_exists(dir) ~= true then
        return {}
    end
    -- initalize
    local files = {}
    local iterator = nil
    -- actual process
    if vim.g.windows == false then
        iterator = vim.fn.system('ls -pa "' .. dir .. '" | grep -v /')
    elseif vim.g.windows == true then
        iterator = vim.fn.system('dir "' .. dir .. '" /a-d /b')
    else
        error('Unrecognized operating system.')
    end
    -- file iterator into table
    if iterator ~= nil then
        for file in iterator:gmatch("[^\r\n]+") do
            table.insert(files, dir .. file)
        end
    end
    return files
end

-- get all subdirectories of directory
utilities.get_subdirs_in_directory = function(dir)
    -- initialize
    local files = {}
    local iterator = nil
    -- actual process
    if vim.g.windows == false then
        iterator = vim.fn.system('ls -d "' .. dir .. '"/*/')
    elseif vim.g.windows == true then
        iterator = vim.fn.system('dir "' .. dir .. '" /ad /b')
    else
        error('Unrecognized operating system.')
    end
    -- file iterator into table
    if iterator ~= nil then
        if iterator:find('ls: cannot access') == nil then
            for file in iterator:gmatch("[^\r\n]+") do
                if vim.g.windows == false then
                    table.insert(files, string.sub(file, 1, -2))
                elseif vim.g.windows == true then
                    table.insert(files, file)
                else
                    error('Unrecognized operating system.')
                end
            end
        end
    end
    return files
end

----------------------------- file path operations -----------------------------

-- get filepath of current buffer
utilities.current_filepath = function()
    return vim.fn.expand('%:p')
end

-- get path to directory of current buffer
utilities.current_directory = function()
    return vim.fn.expand('%:p:h')
end

-- check if file exists and is readable
utilities.file_exists = function(path)
    if vim.fn.filereadable(path) == 0 then
        return false
    end
    return true
end

-- check if directory exists
utilities.directory_exists = function(path)
    if vim.fn.isdirectory(path) == 0 then
        return false
    end
    return true
end

-- get config path
utilities.config_path = function()
    return vim.fn.stdpath('config')
end

-- trim the path to directory
utilities.trim_path_dir = function(path)
    return vim.fn.fnamemodify(path, ':h')
end

-- trim the path to file
utilities.trim_path_file = function(path)
    return vim.fn.fnamemodify(path, ':t')
end

-- trim the path to file
utilities.trim_path_file_name_only = function(path)
    return vim.fn.fnamemodify(path, ':t:r')
end

-- read file to string, collapsing newlines
utilities.string_from_file = function(path)
    if not utilities.file_exists(path) then return '' end
    local lines = ''
    for line in io.lines(path) do
        lines = lines .. ' ' .. line
    end
    return lines
end

-- accepts table, writes json of table to file
utilities.write_table_to_file = function(table, path)
    vim.fn.writefile({ vim.json.encode(table) }, path)
end

-- accepts file, writes computed json to table
utilities.write_json_to_table = function(path)
    if utilities.string_from_file(path) == '' then
        return {}
    end
    return vim.json.decode(utilities.string_from_file(path))
end

----------------------------- related to projects ------------------------------

-- return path after project root folder
utilities.project_tail = function(path)
    -- get root
    local root = prefs.project_root_path
    -- checks that file is in project folder
    if path:match(root) == nil then
        return nil
    end
    -- subtract off start
    local length = #root
    if string.sub(path, length + 1, -1) == '' then
        return '/'
    else
        return string.sub(path, length + 1, -1)
    end
end

-- cuts path of current file to project
utilities.cut_path_to_project = function(path)
    -- checks that file is in project folder
    local root = prefs.project_root_path
    if path:match(root) == nil then
        return nil
    end
    -- checks if there is a project info file
    if utilities.file_exists(path .. '/' .. cfg_filesys.project_info_name) then
        return path .. '/'
    else
        local head = utilities.trim_path_dir(path)
        return utilities.cut_path_to_project(head)
    end
end

-- gets path of current project
utilities.current_project_path = function()
    return utilities.cut_path_to_project(utilities.current_filepath())
end

utilities.robust_current_project_path = function()
    return utilities.cut_path_to_project(vim.fn.getcwd())
end

-- returns project name
utilities.get_project_name = function(path)
    -- get path, ensure that path is a project path
    local cut_path = utilities.cut_path_to_project(path)
    if cut_path == nil then
        return 'Not In Project'
    end

    -- get project info
    local proj_info = utilities.write_json_to_table(cut_path .. cfg_filesys.project_info_name)

    -- return project info
    if proj_info == nil then
        return 'Project Info Not Found'
    else
        if proj_info.title == nil then
            return 'Project Name Not Found'
        end
        return proj_info.title
    end
end

------------------------- file manipulation operations -------------------------

-- create symlink
utilities.symlink = function(oldloc, newloc)
    if vim.g.windows == false then
        vim.fn.system(string.format('ln -s "%s" "%s"', oldloc, newloc))
    elseif vim.g.windows == true then
        newloc = newloc .. '/' .. utilities.trim_path_file(oldloc)
        vim.fn.system(string.format('mklink \\d "%s" "%s"', oldloc, newloc))
    else
        error('Unrecognized operating system.')
    end
end

-- create directory
utilities.create_directory = function(location)
    if vim.g.windows == false then
        vim.fn.system(string.format('mkdir "%s"', location))
    elseif vim.g.windows == true then
        vim.fn.system(string.format('md "%s"', location))
    else
        error('Unrecognized operating system.')
    end
end

-- move folder
utilities.move_folder = function(oldloc, newloc)
    if vim.g.windows == false then
        vim.fn.system(string.format('mv "%s" "%s"', oldloc, newloc))
    elseif vim.g.windows == true then
        vim.fn.system(string.format('move "%s" "%s"', oldloc, newloc))
    else
        error('Unrecognized operating system.')
    end
end

-- copy file
utilities.copy_file = function(from, to)
    if vim.g.windows == false then
        vim.fn.system(string.format('cp "%s" "%s"', from, to))
    elseif vim.g.windows == true then
        vim.fn.system(string.format('copy "%s" "%s"', from, to))
    else
        error('Unrecognized operating system.')
    end
end

-- write string to file (overwrites)
utilities.write_string_to_file = function(str, file)
    if vim.g.windows == false then
        vim.fn.system(string.format('echo "%s" > "%s"', str, file))
    elseif vim.g.windows == true then
        vim.fn.system(string.format('echo %s > "%s"', utilities.escape_for_windows(str), file))
    else
        error('Unrecognized operating system.')
    end
end

-- append string to file (does not overwrite)
utilities.append_string_to_file = function(str, file)
    if vim.g.windows == false then
        vim.fn.system(string.format('echo "%s" >> "%s"', str, file))
    elseif vim.g.windows == true then
        vim.fn.system(string.format('echo %s >> "%s"', utilities.escape_for_windows(str), file))
    else
        error('Unrecognized operating system.')
    end
end

------------------------------------ other -------------------------------------

utilities.has_value = function(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

utilities.table_concat = function(t1, t2)
    for i=1,#t2 do
        t1[#t1+1] = t2[i]
    end
    return t1
end

--------------------------------------------------------------------------------

return utilities

--------------------------------------------------------------------------------
