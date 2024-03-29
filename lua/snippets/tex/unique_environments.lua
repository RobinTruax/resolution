--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This file creates some unique environments that are not handled by the generic
creator.

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

------------------------- special environment snippets -------------------------

-- snippet for display math
if type(config.display_math.trigger) == 'string' then
    -- regular (start of line)
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
    -- line-breaking (anywhere else)
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

-- snippet for generic environment not included in the standard environment snippet catalog
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

--------------------------------------------------------------------------------

return manual, auto

--------------------------------------------------------------------------------
