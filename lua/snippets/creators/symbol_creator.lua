--[[------------------- resolution v0.1.0 -----------------------

symbol snippet creator

---------------------------------------------------------------]]

------------------------- dependencies --------------------------

local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node
local fmta = require('luasnip.extras.fmt').fmta
local utilities = require('snippets.tex.utilities')

------------------------ snippet creator ------------------------

-- wrapper function for simplicity
local wrapper = function(program)
    return function(_, snip)
        return program(snip.captures)
    end
end

-- symbol creator
local symbol_creator = function(symbol)
    -- sanitize inputs
    local trigger = symbol.trigger
    local program = symbol.program
    local description = symbol.description or trigger
    local prefix = symbol.prefix
    local suffix = symbol.suffix
    local mathmode = symbol.mathmode
    if mathmode == nil then
        mathmode =  true
    end
    local priority = symbol.priority or 100
    local prefix_string = prefix or ''
    local suffix_string = suffix or ''

    -- create format and nodes
    local format = '<>'
    local nodes = {}
    local c = 0
    if prefix ~= nil then
        c = 1
        format = '<>' .. format
        table.insert(nodes, utilities.cap(1))
    end
    if type(program) == 'string' then
        table.insert(nodes, t(program))
    elseif type(program) == 'function' then
        table.insert(nodes, f(wrapper(program)))
    elseif type(program) == 'number' then
        table.insert(nodes, utilities.cap(program + c))
    end
    if prefix ~= nil then
        c = 1
        format = '<>' .. format
        table.insert(nodes, utilities.cap(-1))
    end


    -- actual return
    return s({
        trig = prefix_string .. trigger .. suffix_string,
        regTrig = true,
        wordTrig = false,
        name = description,
        condition = utilities.get_condition(mathmode),
        priority = priority,
    }, fmta(format, nodes))
end

-----------------------------------------------------------------

return symbol_creator

-----------------------------------------------------------------
