--[[------------------- resolution v0.1.0 -----------------------

configuration for color assignments

-------------------------------------------------------------]]--

local colors = {}
local aesthetics = require('config.aesthetics')
local colorschemes = require('config.colorschemes')

------------- utility function for universal config -------------

local expand_universal = function(entry, scheme, mode)
    local expanded_entry = {}
    for k, v in pairs(entry) do
        if k == 'fg' or k == 'bg' then
            expanded_entry[k] = colorschemes.universal_palette[scheme][mode][v]
        else
            expanded_entry[k] = v
        end
    end
    return expanded_entry
end

------------------------ set colorscheme ------------------------

colors.set_colorscheme = function(scheme, mode)
    -- first set mode
    vim.o.background = mode

    -- set colorscheme
    if colorschemes.colorscheme_configs[scheme] == nil then
        vim.cmd('colorscheme ' .. scheme)
    else
        -- if there exists configuration data, configure using it
        vim.cmd('colorscheme ' .. colorschemes.colorscheme_configs[scheme][mode])

        -- 'always' settings in universal_config
        for k, v in pairs(colorschemes.universal_config.always) do
            vim.api.nvim_set_hl(0, k, expand_universal(v, scheme, mode))
        end

        -- 'optional' settings in universal_config
        for k, v in pairs(colorschemes.universal_config.optional) do
            if aesthetics[k] == true then
                for l, w in pairs(v) do
                    vim.api.nvim_set_hl(0, l, expand_universal(w, scheme, mode))
                end
            end
        end

        -- 'always' settings in colorscheme_configs
        for k, v in pairs(colorschemes.colorscheme_configs[scheme].always[mode]) do
            vim.api.nvim_set_hl(0, k, v)
        end

        -- 'optional' settings in colorscheme_configs
        for k, v in pairs(colorschemes.colorscheme_configs[scheme].optional) do
            if aesthetics[k] == true then
                for l, w in pairs(v[mode]) do
                    vim.api.nvim_set_hl(0, l, w)
                end
            end
        end
    end
end

-----------------------------------------------------------------

return colors

-----------------------------------------------------------------
