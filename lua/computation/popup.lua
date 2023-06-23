local popup = {}

local Popup = require("nui.popup")
local Layout = require("nui.layout")
local Event = require("nui.utils.autocmd").event
local Job = require('plenary.job')

----------------- windows and layout for popup ------------------
popup.input_tex = Popup({
    enter = true,
    border = {
        style = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
})
popup.sympy = Popup({
    border = {
        style = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
    focusable = true,
})
popup.output_tex = Popup({
    border = {
        style = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
    focusable = false
})
popup.all = {
    popup.input_tex,
    popup.sympy,
    popup.output_tex,
}
popup.layout = Layout(
    {
        relative = 'cursor',
        position = {
            row = 1,
            col = -2
        },
        anchor = 'NW',
        size = {
            width = 40,
            height = 11,
        },
    },
    Layout.Box({
        Layout.Box(popup.input_tex, { size = 3 }),
        Layout.Box(popup.sympy, { size = 3 }),
        Layout.Box(popup.output_tex, { size = 5 }),
    }, { dir = 'col' })
)

--------------------------- keybinds ----------------------------

-- for _, p in pairs(popup) do
--     p:on("BufLeave", function()
--         vim.schedule(function()
--             local bufnr = vim.api.nvim_get_current_buf()
--             for _, lp in pairs(popup) do
--                 if lp.bufnr == bufnr then
--                     return
--                 end
--             end
--             popup.layout:unmount()
--         end)
--     end)
-- end

----------- update the popup asynchronously downwards -----------
popup.keymaps = function()
    popup.input_tex:map('n', 'q', function()
        popup.layout:unmount()
    end)
    popup.sympy:map('n', 'q', function()
        popup.layout:unmount()
    end)
    popup.output_tex:map('n', 'q', function()
        popup.layout:unmount()
    end)
    popup.input_tex:map('n', '<Tab>', function()
        vim.api.nvim_set_current_win(popup.sympy.winid)
    end)
    popup.sympy:map('n', '<Tab>', function()
        vim.api.nvim_set_current_win(popup.output_tex.winid)
    end)
    popup.output_tex:map('n', '<Tab>', function()
        vim.api.nvim_set_current_win(popup.input_tex.winid)
    end)
end

popup.updater = function()
    popup.input_tex:on({ Event.BufWinLeave }, function()
        vim.schedule(function()
            popup.layout:unmount()
        end)
    end)

    popup.sympy:on({ Event.BufWinLeave }, function()
        vim.schedule(function()
            popup.layout:unmount()
        end)
    end)

    popup.output_tex:on({ Event.BufWinLeave }, function()
        vim.schedule(function()
            popup.layout:unmount()
        end)
    end)

    popup.input_tex:on({ Event.InsertLeave, Event.TextChanged }, function()
        vim.schedule(function()
            local latex_current_input = table.concat(vim.api.nvim_buf_get_lines(popup.input_tex.bufnr, 0, -1, false), ' ')
            Job:new({
                command = 'python3',
                args = { '-c',
                    'from latex2sympy2 import latex2sympy; print(latex2sympy(r"' .. latex_current_input .. '"))' },
                on_exit = function(j, exit_code)
                    local res = table.concat(j:result(), ' ')
                    if exit_code ~= 0 then
                        print('Error: Exit Code', exit_code)
                    else
                        vim.schedule(function()
                            vim.api.nvim_buf_set_lines(popup.sympy.bufnr, 0, -1, false, { res })
                        end)
                    end
                end,
            }):start()
            Job:new({
                command = 'python3',
                args = { '-c',
                    'from latex2sympy2 import latex2latex; print(latex2latex(r"' .. latex_current_input .. '"))' },
                on_exit = function(j, exit_code)
                    local res = table.concat(j:result(), ' ')
                    if exit_code ~= 0 then
                        print('Error: Exit Code', exit_code)
                    else
                        vim.schedule(function()
                            vim.api.nvim_buf_set_lines(popup.output_tex.bufnr, 0, -1, false, { res })
                        end)
                    end
                end,
            }):start()
        end)
    end)
end

------------------ wrapper functions for popup ------------------
popup.get_visual_selection = function()
    local a_orig = vim.fn.getreg('a')
    local mode = vim.fn.mode()
    if mode ~= 'v' and mode ~= 'V' then
        vim.cmd([[normal! gv]])
    end
    vim.cmd([[silent! normal! "aygv]])
    local text = vim.fn.getreg('a')
    vim.fn.setreg('a', a_orig)
    local collapsed_text = text:gsub('\n', ' ')
    return collapsed_text
end

popup.mount_from_visual = function()
    local visi = popup.get_visual_selection():match('^%s*(.*)')
    popup.layout:mount()
    vim.api.nvim_buf_set_lines(popup.input_tex.bufnr, 0, -1, false,
        { visi })
    vim.api.nvim_buf_set_lines(popup.sympy.bufnr, 0, -1, false, {})
    vim.api.nvim_buf_set_lines(popup.output_tex.bufnr, 0, -1, false, {})
    popup.keymaps()
    popup.updater()
end

popup.mount = function()
    popup.layout:mount()
    popup.keymaps()
    popup.updater()
end

popup.unmount = function()
    popup.layout:unmount()
end

popup.show = function()
    popup.layout:show()
end

popup.hide = function()
    popup.layout:hide()
end

-----------------------------------------------------------------
return popup
