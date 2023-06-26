local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local fmta = require("luasnip.extras.fmt").fmta

local m_by_n_object = function(name, opts)
    return function(args, snip)
        -- getting m and n
        local m = tonumber(snip.captures[opts.m])
        local n = tonumber(snip.captures[opts.m])

        -- getting prefix and suffix
        local prefix = ''
        if type(opts.prefix) == 'number' then
            prefix = snip.captures[opts.prefix]
        elseif type(opts.prefix) == 'function' then
            prefix = opts.prefix(m, n)
        end

        local suffix = ''
        if type(opts.suffix) == 'number' then
            suffix = snip.captures[opts.prefix]
        elseif type(opts.suffix) == 'function' then
            suffix = opts.suffix(m, n)
        end

        -- creating list of nodes
        -- beginning
        local node_list = { t({ '\\begin{' .. prefix .. name .. '}' .. suffix, '    ' }) }
        -- main
        for k = 1, m, 1 do
            for j = 1, n, 1 do
                table.insert(node_list, i(n * (k - 1) + j))
                if j < n then
                    table.insert(node_list, t(' & '))
                elseif k < m then
                    table.insert(node_list, t({ ' \\\\', '    ' }))
                end
            end
        end
        -- ending
        table.insert(node_list, t({ '', '\\end{' .. prefix .. name .. '}' }))

        -- return a snippet node for dynamic node
        return sn(nil, node_list)
    end
end

return {
    s(
        {
            trig = '([bpv]?)mat(%d+)x(%d+)',
            name = 'matrix',
            regTrig = true,
        },
        {
            d(1, m_by_n_object('matrix', { prefix = 1, m = 2, n = 3 }))
        }
    ),

    s(
        {
            trig = 'tab(%d+)x(%d+)',
            name = 'tabular',
            regTrig = true,
        },
        {
            d(1, m_by_n_object('tabular',
                {
                    m = 1,
                    n = 2,
                    suffix = function(m, n)
                        return '{ ' .. string.rep('c', n, ' ') .. ' }'
                    end
                })
            )
        }
    )
}
