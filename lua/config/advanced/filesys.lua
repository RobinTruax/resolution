--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This file contains the configuration for the filesys module.

Copyright (C) 2023 Roshan Truax

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) at any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

------------------------------------------------------------------------------]]

local filesys = {}

--------------------------------------------------------------------------------

filesys.project_info_name = '.projinfo.json'

filesys.project_icons = {
    { 'Writing',    '󰴓' },
    { 'Class',      '󰑴' },
    { 'Research',   '' },
    { 'Experiment', '' },
    { 'Code',       '' },
}

filesys.archive_project_folder = 'Archive'
filesys.bibliography_folder = 'Bibliography'
filesys.packages_folder = 'Packages'

--------------------------------------------------------------------------------

return filesys

--------------------------------------------------------------------------------
