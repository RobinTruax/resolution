--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This file contains the customization for color assignments done by resolution.

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

local colors = {}
local colorschemes = require('config.colorschemes')

-------------------- utility function for universal config ---------------------

local expand_universal = function(entry, scheme, mode)
    local expanded_entry = {}
    for k, v in pairs(entry) do
        if type(v) == 'table' then
            expanded_entry[k] = v[scheme][mode]
        else
            expanded_entry[k] = v
        end
    end
    return expanded_entry
end

------------------------------- set colorscheme --------------------------------

colors.set_colorscheme = function(scheme, mode)
    -- first set mode
    vim.o.background = mode
    vim.g.colorscheme = scheme

    -- set colorscheme
    if colorschemes.colorscheme_configs[scheme] == nil then
        vim.cmd('colorscheme ' .. scheme)
    else
        -- if there exists configuration data, configure using it
        vim.cmd('colorscheme ' .. colorschemes.colorscheme_configs[scheme][mode])

        -- 'always' settings in universal_config
        for k, v in pairs(colorschemes.universal_config) do
            vim.api.nvim_set_hl(0, k, expand_universal(v, scheme, mode))
        end

        -- 'always' settings in colorscheme_configs
        for k, v in pairs(colorschemes.colorscheme_configs[scheme].colors[mode]) do
            vim.api.nvim_set_hl(0, k, v)
        end
    end
end

--------------------------------------------------------------------------------

return colors

--------------------------------------------------------------------------------
