--[[------------------- resolution v0.1.0 -----------------------

this file provides the operations and shell calls for the popup menu

---------------------------------------------------------------]]

local actions = {}

------------------------- dependencies --------------------------

-- configuration
local states = require('core.states')
local preferences = require('config.preferences')
local notebook = require('computation.notebook')
local config_computation = require('config.advanced.computation')

-- related files
local napkin_layout = require('computation.napkin-layout')

-- nui.nvim
local NuiText = require('nui.text')
local Event = require('nui.utils.autocmd').event

-- plenary.nvim
local Job = require('plenary.job')

--------------------------- keybinds ----------------------------

-- utility function for getting the next index
local next_index = function(k, n)
    if k < n then
        return k + 1
    elseif k == n then
        return 1
    end
end

actions.set_keybinds = function(popups)
    local n = #popups
    -- iterate over popups
    for k, v in ipairs(popups) do
        -- quit keymaps
        v:map('n', 'q', function()
            napkin_layout.layout:unmount()
        end)
        v:map('n', '<Esc>', function()
            napkin_layout.layout:unmount()
        end)
        -- iteration keymaps
        v:map('n', '<Tab>', function()
            vim.api.nvim_set_current_win(popups[next_index(k, n)].winid)
            require('cmp').setup.buffer({ enabled = false })
        end)
        v:map('i', '<Tab>', function()
            vim.api.nvim_set_current_win(popups[next_index(k, n)].winid)
            require('cmp').setup.buffer({ enabled = false })
        end)
        -- yank and quit
        v:map('n', '<localleader>y', function()
            vim.api.nvim_set_current_win(napkin_layout.output_tex.winid)
            vim.cmd('norm VGy')
            napkin_layout.layout:unmount()
        end)
        -- send and named-send
        v:map('n', '<localleader>s', function()
            local sympy = table.concat(vim.api.nvim_buf_get_lines(napkin_layout.sympy.bufnr, 0, -1, false), ' ')
            notebook.send_to_notebook(sympy)
        end)
        v:map('n', '<localleader>S', function()
            local sympy = table.concat(vim.api.nvim_buf_get_lines(napkin_layout.sympy.bufnr, 0, -1, false), ' ')
            notebook.send_to_notebook_named(sympy)
        end)
    end
end

-------------------------- computation --------------------------

-- list of running jobs (for cleaning purposes; helps with performance)
actions.running_jobs = {}

-- cleans all jobs in actions.running_jobs
actions.stop_all_jobs = function()
    for _, job in pairs(actions.running_jobs) do
        job:_stop()
    end
    actions.running_jobs = {}
end

-- populates the second window from the first
actions.sympy_from_latex = function(input)
    -- create job
    local job = Job:new({
        -- shell command
        command = 'python3',
        args = {
            '-c',
            string.format('from latex2sympy2 import latex2sympy; print(latex2sympy(r"%s"))', input)
        },
        -- callback function
        on_exit = function(j, exit_code)
            -- get result
            local res = j:result()
            -- if no error thrown, populate the second window
            if exit_code == 0 then
                vim.schedule(function()
                    vim.api.nvim_buf_set_lines(napkin_layout.sympy.bufnr, 0, -1, false, res)
                end)
            end
        end
    })

    -- start and index job
    job:start()
    table.insert(actions.running_jobs, job)
end

-- populates the third window from the first
actions.latex_from_latex = function(input, filename)
    -- create job
    local job = Job:new({
        -- shell command
        command = 'python3',
        args = {
            '-c',
            string.format('from latex2sympy2 import latex2latex; print(latex2latex(r"%s"))', input)
        },
        -- callback function
        on_exit = function(j, exit_code)
            -- get result
            local res = j:result()
            -- if an error was thrown at this stage, notify user
            if exit_code ~= 0 then
                vim.schedule(function()
                    vim.api.nvim_buf_set_lines(napkin_layout.output_tex.bufnr, 0, -1, false, { 'Error in Computation' })
                    NuiText('Error in Computation', 'Error'):render(napkin_layout.output_tex.bufnr, -1, 1, 0)
                end)
                -- otherwise, send output to the buffer or to a formatter
            else
                vim.schedule(function()
                    if filename == nil or config_computation.preformat == false then
                        vim.api.nvim_buf_set_lines(napkin_layout.output_tex.bufnr, 0, -1, false, res)
                    else
                        local string = table.concat(res, ' '):gsub('\\', '\\\\')
                        vim.fn.system(string.format('echo "%s" > %s', string, filename))
                        actions.latex_indent(filename)
                    end
                end)
            end
        end
    })

    -- start and index job
    job:start()
    table.insert(actions.running_jobs, job)
end

-- populates the third window from the second
actions.latex_from_sympy = function(input, filename)
    -- create a series of commands for sympy
    local scope_commands = ''
    for _, v in ipairs(config_computation.symbols_for_sympy) do
        scope_commands = scope_commands .. string.format('var("%s"); ', v)
    end

    -- create job
    local job = Job:new({
        -- shell command
        command = 'python3',
        args = {
            '-c',
            string.format('from sympy import *; %sprint(latex(%s))', scope_commands, input),
        },
        -- callback function
        on_exit = function(j, exit_code)
            -- get result
            local res = j:result()
            -- if an error was thrown at this stage, notify user
            if exit_code ~= 0 then
                vim.schedule(function()
                    vim.api.nvim_buf_set_lines(napkin_layout.output_tex.bufnr, 0, -1, false, { 'Error in Computation' })
                    NuiText('Error in Computation', 'Error'):render(napkin_layout.output_tex.bufnr, -1, 1, 0)
                end)
                -- otherwise, send output to the buffer or to a formatter
            else
                vim.schedule(function()
                    if filename == nil or config_computation.preformat == false then
                        vim.api.nvim_buf_set_lines(napkin_layout.output_tex.bufnr, 0, -1, false, res)
                    else
                        local string = table.concat(res, ' '):gsub('\\', '\\\\')
                        vim.fn.system(string.format('echo "%s" > %s', string, filename))
                        actions.latex_indent(filename)
                    end
                end)
            end
        end
    })

    -- start and index job
    job:start()
    table.insert(actions.running_jobs, job)
end

-- formatter for latex
actions.latex_indent = function(filename)
    -- create job
    local job = Job:new({
        -- shell command
        command = 'latexindent',
        args = {
            '-l',
            preferences.format_style_file,
            '-m',
            filename
        },
        -- callback function
        on_exit = function(j, exit_code)
            -- get result
            local res = j:result()
            -- if an error was thrown at this stage, notify user
            if exit_code ~= 0 then
                vim.schedule(function()
                    vim.api.nvim_buf_set_lines(napkin_layout.output_tex.bufnr, 0, -1, false, { 'Error in Formatting' })
                    NuiText('Error in Formatting', 'Error'):render(napkin_layout.output_tex.bufnr, -1, 1, 0)
                end)
                -- otherwise, send output to the buffer or to a formatter
            else
                vim.schedule(function()
                    -- set wrapping smartly
                    if #res <= config_computation.window_parameters.maximum_wrap then
                        vim.api.nvim_win_set_option(napkin_layout.output_tex.winid, 'wrap', true)
                    end
                    vim.api.nvim_buf_set_lines(napkin_layout.output_tex.bufnr, 0, -1, false, res)
                end)
            end
        end
    })

    -- start and index job
    job:start()
    table.insert(actions.running_jobs, job)
end

-- create all computation jobs
actions.computation_jobs = function()
    -- update the 2nd and 3rd windows on edits in the 1st window
    napkin_layout.input_tex:on({ Event.TextChangedI, Event.TextChanged }, function()
        vim.schedule(function()
            -- scan and simplify input latex
            local input_tex = table.concat(vim.api.nvim_buf_get_lines(napkin_layout.input_tex.bufnr, 0, -1, false), ' ')
            -- stop all jobs
            actions.stop_all_jobs()
            -- call new update jobs
            actions.sympy_from_latex(input_tex)
            actions.latex_from_latex(input_tex, vim.fn.stdpath('config') .. '/tmp.tex')
        end)
    end)

    -- update the 3rd window on edits in the 2nd window
    napkin_layout.sympy:on({ Event.TextChangedI }, function()
        vim.schedule(function()
            -- scan and simplify input latex
            local input_sympy = table.concat(vim.api.nvim_buf_get_lines(napkin_layout.sympy.bufnr, 0, -1, false), ' ')
            -- stop all jobs
            actions.stop_all_jobs()
            -- call a new update job
            actions.latex_from_sympy(input_sympy, vim.fn.stdpath('config') .. '/tmp.tex')
        end)
    end)
end

----------------------------- jobs ------------------------------

-- function for closing the pop-up windows
actions.closure_jobs = function(popups)
    -- iterate over popups
    for _, p in ipairs(popups) do
        -- on buffer leave, quit
        p:on('BufLeave', function()
            vim.schedule(function()
                local bufnr = vim.api.nvim_get_current_buf()
                for _, lp in pairs(popups) do
                    if lp.bufnr == bufnr then
                        return
                    end
                end
                napkin_layout.layout:unmount()
            end)
        end)
        -- on window leave, quit
        p:on({ Event.BufWinLeave }, function()
            vim.schedule(function()
                napkin_layout.layout:unmount()
                states.computation_popup = false
            end)
        end)
    end
end

-- function for creating all jobs
actions.jobs_creator = function(input)
    -- keybinds
    actions.set_keybinds(napkin_layout.all)
    -- jobs for closure
    actions.closure_jobs(napkin_layout.all)
    -- jobs for computation
    actions.computation_jobs()
end

--------------------------- mounting ----------------------------

-- mounting the pop-up window
actions.mount = function()
    -- set up
    napkin_layout.layout:mount()
    -- create jobs
    actions.jobs_creator()
    -- turn off autocompletion
    require('cmp').setup.buffer({ enabled = false })
end

-- get any visual selection
actions.get_visual_selection = function()
    -- store register a
    local a_orig = vim.fn.getreg('a')
    -- reselection if necessary
    local mode = vim.fn.mode()
    if mode ~= 'v' and mode ~= 'V' then
        vim.cmd([[normal! gv]])
    end
    vim.cmd([[silent! normal! "aygv]])
    -- grab register a
    local text = vim.fn.getreg('a')
    -- reset register a
    vim.fn.setreg('a', a_orig)
    -- collapse text
    local collapsed_text = text:gsub('\n', ' '):gsub('%s%s+', ' ')
    -- return
    return collapsed_text
end

-- mounting the pop-up with a default visual selection
actions.mount_from_visual = function()
    local visi = actions.get_visual_selection()
    actions.mount()
    vim.api.nvim_buf_set_lines(napkin_layout.input_tex.bufnr, 0, -1, false, { visi })
end

-----------------------------------------------------------------

return actions

-----------------------------------------------------------------
