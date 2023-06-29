--[[------------------- resolution v0.1.0 -----------------------

autoscript snippet configuration

---------------------------------------------------------------]]

local config = require('config.snippets')
local symbol_creator = require('snippets.creators.symbol_creator')
local auto = {}

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

return {}, auto
