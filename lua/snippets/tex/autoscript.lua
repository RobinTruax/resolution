--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computation math.

This implements a system for automatically including auto-subscripts.

Copyright (C) 2023 Roshan Truax

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) at any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

------------------------------------------------------------------------------]]

--------------------------------- Dependencies ---------------------------------

local config = require('config.snippets')
local symbol_creator = require('snippets.creators.symbol_creator')
local auto = {}

---------------------------- Actual snippet creator ----------------------------

-- autoscript functionality (disabled by default)
if config.autoscript == true then
    -- Letter Digit
    table.insert(auto, symbol_creator({
        trigger = '([%a])([0-9])',
        program = function(captures)
            return captures[1] .. '_' .. captures[2]
        end,
        description = 'Letter Digit',
        auto = true,
        priority = 100,
    }))

    -- Multi-Digit Subscripts
    table.insert(auto, symbol_creator({
        trigger = '%_([0-9])([0-9]+)',
        program = function(captures)
            return '_{' .. captures[1] .. captures[2] .. '}'
        end,
        description = 'Multi-Digit Subscript',
        auto = true,
    }))

    -- Double Depth Subscripts
    table.insert(auto, symbol_creator({
        trigger = '%_([%a])([0-9]+)',
        program = function(captures)
            return '_{' .. captures[1] .. '_{' .. captures[2] .. '}}'
        end,
        description = 'Depth 2 Subscripts',
        auto = true,
        priority = 101,
    }))

    -- Asterisk Superscript
    table.insert(auto, symbol_creator({
        trigger = '([%a])%*',
        program = function(captures)
            return captures[1] .. '^*'
        end,
        description = 'Asterisk Superscripts',
        auto = true,
    }))

    -- Multi-Asterisk Superscript
    table.insert(auto, symbol_creator({
        trigger = '%^%*%*',
        program = '^{**}',
        description = 'Double-Asterisk Superscripts',
        auto = true,
        priority = 110,
    }))
end

--------------------------------------------------------------------------------

return {}, auto

--------------------------------------------------------------------------------
