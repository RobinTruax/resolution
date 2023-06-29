--[[------------------- resolution v0.1.0 -----------------------

modifier snippet creator

---------------------------------------------------------------]]

------------------------- dependencies --------------------------

local config = require('config.snippets')

------------------------- used creators -------------------------

local command_creator = require('snippets.creators.command_creator')
local symbol_creator = require('snippets.creators.symbol_creator')

------------------------ snippet creator ------------------------

-- modifier creator
local modifier_creator = function(modifier)
    -- sanitize inputs
    local trigger = modifier.trigger
    local modifier_command = modifier.modifier
    local description = modifier.description
    if modifier.description == nil then
        description = 'Modifier: ' .. modifier_command:gsub('^%l', string.upper)
    end
    local priority = modifier.priority or 100
    local english_only = modifier.english_only or false

    -- manual part of the modifier
    local manual = {
        command_creator({
            expanded = '\\' .. modifier_command .. '{<>}',
            trigger = trigger,
            description = description,
            priority = priority,
        }, true)
    }

    -- auto part of the modifier
    -- english-only
    local auto = {
        symbol_creator({
            trigger = trigger .. '([%a])',
            program = function(captures)
                return '\\' .. modifier_command .. '{' .. captures[1] .. '}'
            end,
            description = description,
            priority = priority + 10,
            mathmode = true,
        })
    }
    -- greek
    if english_only == false then
        -- greek (standard)
        table.insert(auto, symbol_creator({
            trigger = trigger .. config.greek_standard_pattern,
            program = function(captures)
                return '\\' .. modifier_command .. '{' .. config.greek_letters[captures[1]] .. '}'
            end,
            description = description,
            priority = priority + 10,
            mathmode = true,
        }))

        -- greek (special)
        table.insert(auto, symbol_creator({
            trigger = trigger .. config.greek_special_pattern,
            program = function(captures)
                return '\\' .. modifier_command .. '{' .. config.greek_letters[captures[1]] .. '}'
            end,
            description = description,
            priority = priority + 10,
            mathmode = true,
        }))
    end

    -- return
    return {
        manual = manual,
        auto = auto
    }
end

-----------------------------------------------------------------

return modifier_creator
