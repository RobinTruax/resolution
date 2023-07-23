--[[------------------- resolution v0.1.0 -----------------------

command snippet creator

---------------------------------------------------------------]]

------------------------- dependencies --------------------------

local ls = require('luasnip')
local s = ls.snippet
local i = ls.insert_node
local d = ls.dynamic_node
local fmta = require('luasnip.extras.fmt').fmta
local utilities = require('snippets.tex.utilities')

------------------------ snippet creator ------------------------

local command_snippet = function(command, mathmode)
    -- sanitize information
    local expanded = command.expanded
    local trigger = command.trigger
    local description = command.description or expanded
    local priority = command.priority or 100
    local defaults = command.defaults or {}
    local prefix = command.prefix
    local suffix = command.suffix
    local visual = command.visual or 1

    -- prefix and suffix string
    local prefix_string = prefix or ''
    local suffix_string = suffix or ''

    -- create format and nodes
    local format = expanded
    local nodes = {}

    local adjust = 1
    -- prefix string (if necessary)
    if prefix ~= nil then
        adjust = 0
        format = '<>' .. format
        table.insert(nodes, utilities.cap(1))
    end

    -- add insert (and visual) nodes
    for _ in expanded:gmatch('<>') do
        local current_label = defaults[#nodes + adjust] or ''
        if #nodes + adjust == visual then
            table.insert(nodes, d(#nodes + adjust, utilities.extend_visual_labeled(current_label)))
        else
            table.insert(nodes, i(#nodes + adjust, current_label))
        end
    end

    -- suffix string (if necessary)
    if suffix ~= nil then
        format = format .. '<>'
        table.insert(nodes, utilities.cap(2))
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

return command_snippet

-----------------------------------------------------------------
