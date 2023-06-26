--------------------- luasnip abbreviations ---------------------

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta

local ts_utils = require('snippets.treesitter-utils')

----------------------- utility functions -----------------------

local function parse_label(input)
    return (string.gsub(string.gsub(string.lower(input), '[%s-]+', '_'), '[^%w_]', ''))
end

local function extend_visual(_, parent)
    return sn(nil, { t(parent.snippet.env.SELECT_RAW), i(1) })
end

local function line_begin(line_to_cursor, matched_trigger)
    return line_to_cursor:sub(1, -(#matched_trigger + 1)):match("^%s*$")
end

local function label(arg, _)
    return parse_label(arg[1][1])
end

------------------ environment snippet creator ------------------

local function create_environment_snippet_theorem(name, trigger, environment, abbreviation)
    return s({
            trig = trigger,
            name = name,
            hidden = true,
            -- condition = function()
            --     ts_utils.in_text(true)
            -- end,
        },
        fmta(string.format([[
    \begin{%s}[<>]\label{%s:<>}
        <>
    \end{%s}
    ]], environment, abbreviation, environment), {
            i(1), f(label, 1), d(2, extend_visual)
        })
    )
end

local function create_environment_snippet_basic(name, trigger, environment)
    return s({
            trig = trigger,
            name = name,
            hidden = false,
            condition = line_begin,
        },
        fmta(string.format([[
    \begin{%s}
        <>
    \end{%s}
    ]], environment, environment), {
            d(1, extend_visual)
        })
    )
end

local function create_environment_snippet_enumerate(name, trigger, environment, label)
    label = label or ''
    if label ~= '' then
        label = '[label=('..label..')]'
    end
    return s({
            trig = trigger,
            name = name,
            hidden = false,
            condition = line_begin,
        },
        fmta(string.format([[
    \begin{%s}%s
        \\item <>
    \end{%s}
    ]], environment, label, environment), {
            i(1)
        })
    )
end

local function create_environment_snippet_custom(name, trigger, environment, extras)
    local options = extras.options or ''
    local content = extras.content or ''
    local suffix = extras.suffix or ''

    local string = string.format([[
    \begin{%s}%s
        %s
    \end{%s}%s
    ]], environment, options, content, environment, suffix)

    local _, count_nodes = string.gsub(string, "<>", "")
    local nodes = {}
    for j = 1, count_nodes, 1 do
        nodes[j] = i(j)
    end

    return s({
            trig = trigger,
            name = name,
            hidden = false,
            condition = line_begin,
        },
        fmta(string, nodes)
    )
end
----------------- actual snippet specification ------------------

local cest = create_environment_snippet_theorem
local cesb = create_environment_snippet_basic
local cese = create_environment_snippet_enumerate
local cesc = create_environment_snippet_custom

return {
    -- Creating environment snippets of the form
    -- \begin{environment}[Name][env:name]
    --     Content
    -- \end{environment}
    -- Usage: cest(name, trigger, environment, label abbreviation)
    cest('Definition',    'def',    'definition',    'def'),
    cest('Theorem',       'thm',    'theorem',       'thm'),
    cest('Proposition',   'prop',   'proposition',   'prop'),
    cest('Lemma',         'lem',    'lemma',         'lem'),
    cest('Corollary',     'cor',    'corollary',     'cor'),
    cest('Conjecture',    'conj',   'conjecture',    'con'),
    cest('Example',       'exam',   'example',       'ex'),
    cest('Problem',       'prob',   'problem',       'pr'),
    cest('Solution',      'sol',    'solution',      'sol'),

    -- Creating environment snippets of the form
    -- \begin{environment}
    --    Content
    -- \end{environment}
    -- Usage: cesb(name, trigger, environment)
    cesb('Proof', 'prf', 'proof'),
    cesb('Center', 'ctr', 'center'),
    cesb('Align', 'ali', 'align*'),

    -- Creating environment snippets of the form
    -- \begin{environment}[label=(label)]
    --     \item 
    -- \end{environment}
    -- Usage: cese(name, trigger, environment, [OPTIONAL] label)
    cese('Unordered List', 'itm', 'itemize'),
    cese('Enumerated List', 'enm', 'enumerate'),
    cese('Alphabetical List', 'aenm', 'enumerate', '\\alph*'),
    cese('Roman-Numbered List', 'renm', 'enumerate', '\\roman*'),

    -- Custom environment snippets
    -- Creating environment snippets of the form
    -- \begin{environment}[options]
    --     content
    -- \end{environment}suffix
    -- Usage: cesc(name, trigger, environment, [OPTIONAL] {OPTIONAL options, OPTIONAL content, OPTIONAL suffix})
    cesc('Code Listing', 'lst', 'lstlisting',
        {options = '[language = <>]', content = '<>'}
    ),
}, {
    cesb('Equation', 'mk', 'equation*'),
    cesb('Equation', 'km', 'equation*'),
}
