--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This file implements a file picker for projects.

Copyright (C) 2023 Roshan Truax

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) at any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

------------------------------------------------------------------------------]]

local config_filesys = require('config.advanced.filesys')
local core_utils = require('core.utilities')

--------------------------------------------------------------------------------

local choose_files = function(opts)
    opts = opts or {}
    opts.cwd = core_utils.current_project_path()
    opts.file_ignore_patterns = { '%.pdf', config_filesys.project_info_name }
    require('telescope.builtin').find_files(opts)
end

--------------------------------------------------------------------------------

return choose_files

--------------------------------------------------------------------------------
