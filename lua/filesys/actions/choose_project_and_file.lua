--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This implements a wrapper for whether or not one should choose both project
and file or just project.

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

local core_utils = require('core.utilities')
local choose_files = require('filesys.actions.choose_files')
local choose_project = require('filesys.actions.choose_project')

------------------------------------- main -------------------------------------

local choose_project_and_file = function()
    if core_utils.current_project_path() == nil then
        choose_project({pick_files_after = true})
    else
        choose_files()
    end
end

--------------------------------------------------------------------------------

return choose_project_and_file

--------------------------------------------------------------------------------
