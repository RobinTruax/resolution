--[[------------------- resolution v0.1.0 -----------------------

this config file services the filesys module

---------------------------------------------------------------]]

local filesys = {}

-----------------------------------------------------------------

filesys.project_info_name = '.projinfo.json'

filesys.project_icons = {
    { 'Writing',    '󰴓' },
    { 'Class',      '󰑴' },
    { 'Research',   '' },
    { 'Experiment', '' },
    { 'Code',       '' },
}

filesys.archive_project_folder = 'Archive'

-----------------------------------------------------------------

return filesys

-----------------------------------------------------------------
