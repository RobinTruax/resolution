--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This file has various utility functions for snippet construction.

Copyright (C) 2023 Roshan Truax

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) at any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

------------------------------------------------------------------------------]]

---------------------------- luasnip abbreviations -----------------------------

local ls = require("luasnip")
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local utilities = {}

------------------------------ context-detection -------------------------------

-- condition for line beginning
utilities.line_begin = function(line_to_cursor, matched_trigger)
    return line_to_cursor:sub(1, -(#matched_trigger + 1)):match("^%s*$")
end

-- condition for in math mode
utilities.in_math = function()
    return (vim.fn['vimtex#syntax#in_mathzone']() == 1)
end

-- condition for in non-math mode
utilities.in_text = function()
    return (vim.fn['vimtex#syntax#in_mathzone']() == 0)
end

-- condition for in math mode and line begin
utilities.in_math_line_begin = function(line_to_cursor, matched_trigger)
    if utilities.line_begin(line_to_cursor, matched_trigger) then
        return utilities.in_math()
    else
        return false
    end
end

-- condition for in non-math mode and line begin
utilities.in_text_line_begin = function(line_to_cursor, matched_trigger)
    if utilities.line_begin(line_to_cursor, matched_trigger) then
        return utilities.in_text()
    else
        return false
    end
end

-- condition for in environment
utilities.in_environment = function(name)
    return function()
        local is_inside = vim.fn['vimtex#env#is_inside'](name)
        return (is_inside[1] > 0 and is_inside[2] > 0)
    end
end

-- condition for in environment and line begin
utilities.in_environment_line_begin = function(name)
    return function(line_to_cursor, matched_trigger)
        if utilities.line_begin(line_to_cursor, matched_trigger) then
            local is_inside = vim.fn['vimtex#env#is_inside'](name)
            return (is_inside[1] > 0 and is_inside[2] > 0)
        else
            return false
        end
    end
end

------------------------------- visual snippets --------------------------------

-- tool for getting visual input
utilities.visual = function(_, parent)
    if (#parent.snippet.env.SELECT_RAW > 0) then
        return sn(nil, t(parent.snippet.env.SELECT_RAW))
    else
        return sn(nil, i(1))
    end
end

-- alternate tool for getting visual input
utilities.extend_visual = function(_, parent)
    return sn(nil, { t(parent.snippet.env.SELECT_RAW), i(1) })
end

-- tool for getting visual input for labeled entries
utilities.extend_visual_labeled = function(label)
    return function(_, parent)
        if (#parent.snippet.env.SELECT_RAW > 0) then
            return sn(nil, {t(parent.snippet.env.SELECT_RAW), i(1)})
        else
            return sn(nil, i(1, label))
        end
    end
end

-------------------------------- get condition ---------------------------------

-- simple function for getting condition
utilities.get_condition = function(mathmode)
    if mathmode == false then
        return utilities.in_text
    else
        return utilities.in_math
    end
end

-- detailed function for getting condition
utilities.get_condition_line_behav = function(line, mathmode)
    if line == 0 and mathmode == false then
        return utilities.in_text_line_begin
    elseif line == 0 and mathmode == true then
        return utilities.in_math_line_begin
    elseif line == 1 and mathmode == false then
        return utilities.in_text
    elseif line == 1 and mathmode == true then
        return utilities.in_math
    elseif line == 2 and mathmode == false then
        return { utilities.in_text, utilities.in_text_line_begin }
    elseif line == 2 and mathmode == true then
        return { utilities.in_math, utilities.in_math_line_begin }
    else
        return function() return true end
    end
end

------------------------------------ other -------------------------------------

-- get captured entry (for regex snippets)
utilities.cap = function(j)
    if j >= 0 then
        return f(function(_, snip) return snip.captures[j] end)
    else
        return f(function(_, snip) return snip.captures[#snip.captures + 1 + j] end)
    end
end

--------------------------------------------------------------------------------

return utilities

--------------------------------------------------------------------------------
