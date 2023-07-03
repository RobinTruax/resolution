--[[------------------- resolution v0.1.0 -----------------------

this file provides the operations and shell calls for the popup menu

---------------------------------------------------------------]]

local commands = {}
local popup = require('computation.popup-layout')
local NuiText = require("nui.text")
local states = require('core.states')
local Event = require("nui.utils.autocmd").event
local Job = require('plenary.job')
local prefs = require('config.preferences')
local Layout = require("nui.layout")

--------------------------- keybinds ----------------------------

local next_index = function(k, n)
    if k < n then
        return k + 1
    elseif k == n then
        return 1
    end
end

commands.set_keybinds = function(popups)
    local n = #popups
    -- iterate over popups
    for k, v in ipairs(popups) do
        -- quit keymaps
        v:map('n', 'q', function()
            popup.layout:unmount()
        end)
        v:map('n', '<Esc>', function()
            popup.layout:unmount()
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
    end
end

-------------------------- computation --------------------------

commands.running_jobs = {}

commands.stop_all_jobs = function()
    for _, job in pairs(commands.running_jobs) do
        job:_stop()
    end
    commands.running_jobs = {}
end

commands.sympy_from_latex = function(input)
    -- create job
    local job = Job:new({
        command = 'python3',
        args = { '-c', string.format('from latex2sympy2 import latex2sympy; print(latex2sympy(r"%s"))', input) },
        on_exit = function(j, exit_code)
            local res = j:result()
            if exit_code == 0 then
                vim.schedule(function()
                    vim.api.nvim_buf_set_lines(popup.sympy.bufnr, 0, -1, false, res)
                end)
            end
        end
    })

    -- start and index job
    job:start()
    table.insert(commands.running_jobs, job)
end

commands.latex_from_latex = function(input, filename)
    -- create job
    local job = Job:new({
        command = 'python3',
        args = {
            '-c',
            string.format('from latex2sympy2 import latex2latex; print(latex2latex(r"%s"))', input)
        },
        on_exit = function(j, exit_code)
            local res = j:result()
            if exit_code ~= 0 then
                vim.schedule(function()
                    vim.api.nvim_buf_set_lines(popup.output_tex.bufnr, 0, -1, false, { 'Error in Computation' })
                    NuiText('Error in Computation', 'Error'):render(popup.output_tex.bufnr, -1, 1, 0)
                end)
            else
                vim.schedule(function()
                    if filename == nil then
                        vim.api.nvim_buf_set_lines(popup.output_tex.bufnr, 0, -1, false, res)
                    else
                        local string = table.concat(res, ' '):gsub('\\', '\\\\')
                        vim.fn.system(string.format('echo "%s" > %s', string, filename))
                        commands.latex_indent(filename)
                    end
                end)
            end
        end
    })

    -- start and index job
    job:start()
    table.insert(commands.running_jobs, job)
end

commands.latex_from_sympy = function(input, filename)
    -- list of symbols to bring into scope for simplicity
    local letters =
    'a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,t,s,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,T,S,U,V,W,X,Y,Z'
    local letter_subscripts =
    'a:10,b:10,c:10,d:10,e:10,f:10,g:10,h:10,i:10,j:10,k:10,l:10,m:10,n:10,o:10,p:10,q:10,r:10,t:10,s:10,u:10,v:10,w:10,x:10,y:10,z:10,A:10,B:10,C:10,D:10,E:10,F:10,G:10,H:10,I:10,J:10,K:10,L:10,M:10,N:10,O:10,P:10,Q:10,R:10,T:10,S:10,U:10,V:10,W:10,X:10,Y:10,Z:10'
    local greek_letters =
    'alpha,beta,gamma,delta,varepsilon,zeta,eta,theta,iota,kappa,lambda,mu,nu,xi,pi,rho,sigma,tau,upsilon,phi,psi,chi,omega,epsilon,varphi,varpsi,vartheta,Gamma,Delta,Theta,Lambda,Xi,Pi,Sigma,Phi,Psi,Omega'
    local greek_letters_subscripts =
    'alpha:10,beta:10,gamma:10,delta:10,varepsilon:10,zeta:10,eta:10,theta:10,iota:10,kappa:10,lambda:10,mu:10,nu:10,xi:10,pi:10,rho:10,sigma:10,tau:10,upsilon:10,phi:10,psi:10,chi:10,omega:10,epsilon:10,varphi:10,varpsi:10,vartheta:10,Gamma:10,Delta:10,Theta:10,Lambda:10,Xi:10,Pi:10,Sigma:10,Phi:10,Psi:10,Omega:10'
    -- create job
    local job = Job:new({
        command = 'python3',
        args = {
            '-c',
            string.format('from sympy import *; var("%s"); var("%s"); var("%s"); var("%s"); print(latex(%s))', letters,
                letter_subscripts, greek_letters, greek_letters_subscripts, input),
        },
        on_exit = function(j, exit_code)
            local res = j:result()
            if exit_code ~= 0 then
                vim.schedule(function()
                    vim.api.nvim_buf_set_lines(popup.output_tex.bufnr, 0, -1, false, { 'Error in Computation' })
                    NuiText('Error in Computation', 'Error'):render(popup.output_tex.bufnr, -1, 1, 0)
                end)
            else
                vim.schedule(function()
                    if filename == nil then
                        vim.api.nvim_buf_set_lines(popup.output_tex.bufnr, 0, -1, false, res)
                    else
                        local string = table.concat(res, ' '):gsub('\\', '\\\\')
                        vim.fn.system(string.format('echo "%s" > %s', string, filename))
                        commands.latex_indent(filename)
                    end
                end)
            end
        end
    })

    -- start and index job
    job:start()
    table.insert(commands.running_jobs, job)
end

commands.latex_indent = function(filename)
    local job = Job:new({
        command = 'latexindent',
        args = { '-l', prefs.format_style_file, '-m', filename },
        on_exit = function(j, exit_code)
            local res = j:result()
            if exit_code ~= 0 then
                vim.schedule(function()
                    vim.api.nvim_buf_set_lines(popup.output_tex.bufnr, 0, -1, false, { 'Error in Formatting' })
                    NuiText('Error in Formatting', 'Error'):render(popup.output_tex.bufnr, -1, 1, 0)
                end)
            else
                vim.schedule(function()
                    if #res < 3 then
                        vim.api.nvim_win_set_option(popup.output_tex.winid, 'wrap', true)
                    end
                    vim.api.nvim_buf_set_lines(popup.output_tex.bufnr, 0, -1, false, res)
                end)
            end
        end
    })
    job:start()
    table.insert(commands.running_jobs, job)
end

commands.computation_jobs = function()
    popup.input_tex:on({ Event.TextChangedI, Event.TextChanged }, function()
        vim.schedule(function()
            local input_tex = table.concat(vim.api.nvim_buf_get_lines(popup.input_tex.bufnr, 0, -1, false), ' ')
            commands.stop_all_jobs()
            commands.sympy_from_latex(input_tex)
            commands.latex_from_latex(input_tex, vim.fn.stdpath('config') .. '/tmp.tex')
        end)
    end)

    popup.sympy:on({ Event.TextChangedI }, function()
        vim.schedule(function()
            local input_sympy = table.concat(vim.api.nvim_buf_get_lines(popup.sympy.bufnr, 0, -1, false), ' ')
            commands.stop_all_jobs()
            commands.latex_from_sympy(input_sympy, vim.fn.stdpath('config') .. '/tmp.tex')
        end)
    end)
end

----------------------------- jobs ------------------------------

commands.closure_jobs = function(popups)
    -- iterate over popups
    for _, p in ipairs(popups) do
        -- on buffer leave, quit
        p:on("BufLeave", function()
            vim.schedule(function()
                local bufnr = vim.api.nvim_get_current_buf()
                for _, lp in pairs(popups) do
                    if lp.bufnr == bufnr then
                        return
                    end
                end
                popup.layout:unmount()
            end)
        end)
        -- on window leave, quit
        p:on({ Event.BufWinLeave }, function()
            vim.schedule(function()
                popup.layout:unmount()
                states.computation_popup = false
            end)
        end)
    end
end

commands.jobs_creator = function(input)
    -- keybinds
    commands.set_keybinds(popup.all)
    -- jobs for closure
    commands.closure_jobs(popup.all)
    -- jobs for computation
    commands.computation_jobs()
end

--------------------------- mounting ----------------------------

commands.mount = function()
    -- set up
    popup.layout:mount()
    -- create jobs
    commands.jobs_creator()
    -- turn off autocompletion
    require('cmp').setup.buffer({ enabled = false })
end

commands.get_visual_selection = function()
    local a_orig = vim.fn.getreg('a')
    local mode = vim.fn.mode()
    if mode ~= 'v' and mode ~= 'V' then
        vim.cmd([[normal! gv]])
    end
    vim.cmd([[silent! normal! "aygv]])
    local text = vim.fn.getreg('a')
    vim.fn.setreg('a', a_orig)
    local collapsed_text = text:gsub('\n', ' '):gsub('%s%s+', ' ')
    return collapsed_text
end

commands.mount_from_visual = function()
    local visi = commands.get_visual_selection()
    commands.mount()
    vim.api.nvim_buf_set_lines(popup.input_tex.bufnr, 0, -1, false, { visi })
end

return commands
