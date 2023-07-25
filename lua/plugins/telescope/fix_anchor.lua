--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This file removes a gap in the telescope picker to ensure proper placement.

Copyright (C) 2023 Roshan Truax

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) at any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

------------------------------------------------------------------------------]]

-- overwriting the anchor position function
local resolve = require('telescope.config.resolve')
resolve.resolve_anchor_pos = function(anchor, p_width, p_height, max_columns, max_lines)
    anchor = anchor:upper()
    local pos = { 0, 0 }
    if anchor == 'CENTER' then
        return pos
    end
    if anchor:find 'W' then
        pos[1] = math.ceil((p_width - max_columns) / 2) + 1
    elseif anchor:find 'E' then
        pos[1] = math.ceil((max_columns - p_width) / 2) - 1
    end
    if anchor:find 'N' then
        pos[2] = math.ceil((p_height - max_lines) / 2) + 1
    elseif anchor:find 'S' then
        pos[2] = math.ceil((max_lines - p_height) / 2)
    end
    return pos
end

--------------------------------------------------------------------------------
