--[[------------------- resolution v0.1.0 -----------------------

environment snippet creator

---------------------------------------------------------------]]

------------------------- dependencies --------------------------

local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require('luasnip.extras.fmt').fmta
local utilities = require('snippets.tex.utilities')
local config = require('config.snippets')

local auto = {}
local manual = {}

----------------- special environment snippets ------------------

if type(config.display_math.trigger) == 'string' then
    local display_math_snippet = s({
        name = 'Display Math Snippet',
        trig = config.display_math.trigger,
        condition = utilities.in_text_line_begin,
        priority = 101,
    }, fmta([[
\[
    <>
\]
        ]], { i(1) }))
    local display_math_snippet_line_break = s({
        name = 'Display Math Snippet (Breaks Line)',
        trig = config.display_math.trigger,
        condition = utilities.in_text,
        priority = 100,
    }, fmta([[
<>
\[
    <>
\]

        ]], { t(''), i(1) }))
    if config.display_math.auto == true then
        table.insert(auto, display_math_snippet)
        table.insert(auto, display_math_snippet_line_break)
    elseif config.display_math.auto == false then
        table.insert(manual, display_math_snippet)
        table.insert(manual, display_math_snippet_line_break)
    end
end

if type(config.generic_environment.trigger) == 'string' then
    local generic_environment_snippet = s(
        {
            name = 'Generic Environment Snippet',
            trig = config.generic_environment.trigger,
            condition = utilities.in_text,
            priority = 100,
        }, fmta([[
\begin{<>}<>
    <>
\end{<>}
            ]], {
            i(1),
            i(2),
            d(3, utilities.visual),
            f(
                function(arg, _) return arg[1][1] end,
                1
            )
        })
    )
    if config.generic_environment.auto == true then
        table.insert(auto, generic_environment_snippet)
    elseif config.generic_environment.auto == false then
        table.insert(manual, generic_environment_snippet)
    end
end

-----------------------------------------------------------------

return manual, auto

-----------------------------------------------------------------
