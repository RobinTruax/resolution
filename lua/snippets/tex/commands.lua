--[[------------------- resolution v0.1.0 -----------------------

environment snippets as configured in config.snippets.environment

---------------------------------------------------------------]]

--------------------- luasnip abbreviations ---------------------

local ls = require('luasnip')
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require('luasnip.extras.fmt').fmta

---------------------- other dependencies -----------------------

local utilities = require('snippets.tex.utilities')

------------------------ snippet creator ------------------------

-- get expansion condition for environment snippets
local get_condition = function(mathmode)
    if mathmode == false then
        return utilities.in_text
    else
        return utilities.in_math
    end
end

-- command snippet
local command_snippet = function(params, mathmode)
    -- sanitize information
    local expanded = params.expanded
    local trigger = params.trigger
    local description = params.description or expanded
    local priority = params.priority or 100
    local defaults = params.defaults or {}
    local prefix = params.prefix
    local suffix = params.suffix
    local visual = params.visual or 1

    -- prefix and suffix string
    local prefix_string = prefix or ''
    local suffix_string = suffix or ''

    -- create nodes
    local format = expanded
    local nodes = {}
    local c = 1
    -- prefix string (if necessary)
    if prefix ~= nil then
        c = 0
        format = '<>' .. format
        table.insert(nodes, utilities.cap(1))
    end
    -- add insert (and visual) nodes
    for _ in expanded:gmatch('<>') do
        local current_label = defaults[#nodes + c] or ''
        if #nodes + c == visual then
            table.insert(nodes, d(#nodes + c, utilities.extend_visual_labeled(current_label)))
        else
            table.insert(nodes, i(#nodes + c, current_label))
        end
    end
    -- suffix string (if necessary)
    if suffix ~= nil then
        format = format .. '<>'
        table.insert(nodes, utilities.cap(2))
    end

    -- actual return
    return s(
        {
            trig = prefix_string .. trigger .. suffix_string,
            regTrig = true,
            wordTrig = false,
            name = description,
            condition = get_condition(mathmode),
            priority = priority,
        }, fmta(format, nodes))
end

----------------------- snippet addition ------------------------

local manual_snippets = {}
local auto_snippets = {}

-- add math commands
for _, v in ipairs(require('config.snippets').math_commands) do
    if v.auto == true then
        table.insert(auto_snippets, command_snippet(v, true))
    else
        table.insert(manual_snippets, command_snippet(v, true))
    end
end

-- add non-math snippets
for _, v in ipairs(require('config.snippets').commands) do
    if v.auto == true then
        table.insert(auto_snippets, command_snippet(v, false))
    else
        table.insert(manual_snippets, command_snippet(v, false))
    end
end

-----------------------------------------------------------------

return manual_snippets, auto_snippets
