--[[------------------- resolution v0.1.0 -----------------------

utility functions for rsltn's standardized ui interface

-------------------------------------------------------------]]--

local ui = {}
local aesthetics = require('config.aesthetics')

---------- get borders based on aesthetic preferences -----------

ui.get_borders = function()
    if aesthetics.ui_sharp == true then
        return {'┌', '┐', '┘', '└', '─', '│'}
    else
        return {'╭', '╮', '╯', '╰', '─', '│'}
    end
end

-----------------------------------------------------------------

return ui
