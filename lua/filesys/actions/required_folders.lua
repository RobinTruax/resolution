--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

Check for required folders.

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

local preferences = require('config.preferences')
local cfg_filesys = require('config.advanced.filesys')
local utilities = require('core.utilities')

-------------------------- check for required folders --------------------------

return function()

    for _,v in ipairs(cfg_filesys.required_folders) do
        if utilities.directory_exists(preferences.project_root_path .. '/' .. v) == false then
            vim.notify('Required folder ' .. v .. ' missing; creating now...', vim.log.levels.WARN)
            utilities.create_directory(preferences.project_root_path .. '/' .. v)
        end
    end

end

--------------------------------------------------------------------------------
