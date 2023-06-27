--[[------------------- resolution v0.1.0 -----------------------

environment snippets as configured in config.snippets.environment

---------------------------------------------------------------]]

--------------------- luasnip abbreviations ---------------------

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta

local utilities = require('snippets.tex.utilities')

----------------------- utility functions -----------------------

-- strips commands, spaces, and symbols (in that order) from the entered text
local parse_label = function(input)
    return (input:gsub('%\\[%a]+%{', ''):gsub('[%s-]+', '_'):gsub('[^%w_]', ''))
end

-- function to be passed to function snippet
local label_func = function (arg, _)
    return parse_label(arg[1][1])
end

------------------------ snippet creator ------------------------

local environment_snippet = function(params)
    -- sanitize information
    -- necessary
    local environment = params.environment
    local trigger     = params.trigger
    -- format construction
    local content     = params.content or '    <>'
    local options     = params.options or ''
    local label       = params.label or 0
    -- snippet options
    local line        = params.line or 0
    local mathmode    = params.mathmode or false
    local description = params.description or environment:gsub('^%l', string.upper)..' Environment'
    local priority    = params.priority or 100
    -- other
    local snippets    = params.snippets or {}

    -- create format
    -- label string if necessary
    local label_string = ''
    local label_added = 1
    if label ~= 0 then
        label_string = '\\label{'..trigger..':<>}'
        label_added = 0
    end

    -- format itself
    local format = string.format([[
    \begin{%s}%s%s
    %s
    \end{%s}
    ]], environment, options, label_string, content, environment)

    -- create list of nodes
    -- option nodes
    local nodes = {}
    for j in options:gmatch('<>') do
        table.insert(nodes, i(#nodes+1))
    end
    -- label node if necessary
    if label ~= 0 then
        table.insert(nodes, f(label_func, label))
    end
    -- content nodes (including visual capture)
    local visual_inserted = false
    for j in content:gmatch('<>') do
        if visual_inserted == false then
            table.insert(nodes, d(#nodes+label_added, utilities.extend_visual))
            visual_inserted = true
        else
            table.insert(nodes, i(#nodes+label_added))
        end
    end

    -- get condition for expansion
    local cond = function()
        return true
    end
    if line == 0 and mathmode == false then
        cond = utilities.in_text_line_begin
    end

    -- create snippet(s) to return
    -- print(format)
    return s({
        trig = trigger,
        name = description,
        -- hidden = false,
        -- condition = cond,
    }, fmta(format, nodes))

    -- create sub-snippet(s) to return

    -- return
end
return {
    environment_snippet({
        environment = 'definition',
        trigger = 'dof',
        options = '[<>]',
        label = 1,
    })
}
