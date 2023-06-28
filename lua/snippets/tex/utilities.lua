--[[------------------- resolution v0.1.0 -----------------------

utility functions for tex snippets

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

-----------------------------------------------------------------

local utilities = {}

----------------------- context-detection -----------------------

utilities.line_begin = function(line_to_cursor, matched_trigger)
    return line_to_cursor:sub(1, -(#matched_trigger + 1)):match("^%s*$")
end

utilities.in_math = function()
    return (vim.fn['vimtex#syntax#in_mathzone']() == 1)
end

utilities.in_text = function()
    return (vim.fn['vimtex#syntax#in_mathzone']() == 0)
end

utilities.in_math_line_begin = function(line_to_cursor, matched_trigger)
    if utilities.line_begin(line_to_cursor, matched_trigger) then
        return utilities.in_math()
    else
        return false
    end
end

utilities.in_text_line_begin = function(line_to_cursor, matched_trigger)
    if utilities.line_begin(line_to_cursor, matched_trigger) then
        return utilities.in_text()
    else
        return false
    end
end

utilities.in_environment = function(name)
    return function()
        local is_inside = vim.fn['vimtex#env#is_inside'](name)
        return (is_inside[1] > 0 and is_inside[2] > 0)
    end
end

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

----------------------------- other -----------------------------

utilities.extend_visual = function(_, parent)
    return sn(nil, { t(parent.snippet.env.SELECT_RAW), i(1) })
end

utilities.extend_visual_labeled = function(label)
    return function(_, parent)
        if (#parent.snippet.env.SELECT_RAW > 0) then
            return sn(nil, {t(parent.snippet.env.SELECT_RAW), i(1)})
        else
            return sn(nil, i(1, label))
        end
    end
end

utilities.visual = function(_, parent)
    if (#parent.snippet.env.SELECT_RAW > 0) then
        return sn(nil, t(parent.snippet.env.SELECT_RAW))
    else
        return sn(nil, i(1))
    end
end

utilities.cap = function(j)
    if j >= 0 then
        return f(function(_, snip) return snip.captures[j] end)
    else
        return f(function(_, snip) return snip.captures[#snip.captures + 1 + j] end)
    end
end

---------------------------- return -----------------------------

return utilities