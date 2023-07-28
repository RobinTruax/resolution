--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

The Git and GitHub operations built into resolution.

Copyright (C) 2023 Roshan Truax

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) at any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

------------------------------------------------------------------------------]]

local git = {}

--------------------------------- dependencies ---------------------------------

local prefs = require('config.preferences')
local cfg_filesys = require('config.advanced.filesys')
local utilities = require('menus.utilities')
local core_utils = require('core.utilities')

--------------------------------- [l]azy[g]it ----------------------------------

git.lazygit = function()
    vim.cmd('LazyGitCurrentFile')
end

-------------------------- configure [g]ithub [u]ser ---------------------------

git.configure_github_user = function()
    -- configure github user authentication
    vim.notify('Configuring GitHub User', vim.log.levels.INFO)
    vim.cmd('TermExec cmd="gh auth login"')
end

---------------------- configure [g]it[h]ub repositories -----------------------

git.configure_github_repos = function()
    -- check if user is cloning to local or creating remote repos
    vim.ui.select({
        { name = 'Clone',  desc = 'Clone existing GitHub repositories to project folder' },
        { name = 'Create', desc = 'Create GitHub repositories from project folder' }
    }, {
        prompt = 'Choose initialization strategy:',
        format_item = function(item)
            return item.desc
        end
    }, function(choice)
        if choice == nil then
            return true
            -- if user chose to clone, clone
        elseif choice == 'Clone' then
            git.github_clone_strategy()
            -- if user chose to create, create
        elseif choice == 'Create' then
            git.github_create_strategy()
        end
    end)
end

git.github_clone_strategy = function()
    -- cloning public repo
    vim.ui.input({
        prompt = 'Enter GitHub Name of Public Repository',
        default = 'resolution-public',
        relative = 'editor',
    }, function(input)
        if input ~= nil then
            local input_old = input
            -- cloning private repo
            vim.ui.input({
                prompt = 'Enter GitHub Name of Private Repository',
                default = 'resolution-private',
                relative = 'editor',
            }, function(input)
                if input ~= nil then
                    -- actual cloning steps
                    vim.notify('Cloning Public Directory...', vim.log.levels.INFO)
                    vim.fn.system(string.format('cd %s | gh repo clone %s . --separate-git-dir=gitpublic',
                        prefs.project_root_path, input_old))
                    vim.notify('Cloning Private Directory...', vim.log.levels.INFO)
                    vim.fn.system(string.format('cd %s | gh repo clone %s . --separate-git-dir=gitprivate',
                        prefs.project_root_path, input))
                end
            end)
        end
    end)
end

git.github_create_strategy = function()
    -- ensure standard repository exists
    vim.notify('Checking for Standard Repositories in Project Folder', vim.log.levels.INFO)
    git.configure_standard_repos()
    -- create public repository
    vim.notify('Creating Public GitHub Repository', vim.log.levels.INFO)
    vim.fn.system(
        'gh repo create "resolution-public" --public --description "Public Repo Generated by Resolution" --disable-wiki --homepage "https://github.com/RobinTruax/resolution" --gitignore tex')
    -- create private repository
    vim.notify('Creating Public GitHub Repository', vim.log.levels.INFO)
    vim.fn.system(
        'gh repo create "resolution-private" --private --description "Private Repo Generated by Resolution" --disable-wiki --homepage "https://github.com/RobinTruax/resolution" --gitignore tex')
end

---------------------------- [g]it [s]tandard repos ----------------------------

git.configure_standard_repos = function()
    -- check if repositories exist in the project folder
    local check = vim.fn.system(
        string.format('cd %s | git rev-parse --is-inside-work-tree'),
        prefs.project_root_path)
    if check ~= 'true' then
        vim.notify('Repositories in Project Folder Already Exist; Cancelling', vim.log.levels.WARNING)
        return false
    end
    -- creating repositories
    vim.notify('Creating Standard Repositories in Project Folder', vim.log.levels.INFO)
    -- creating private repository
    vim.fn.system(string.format('cd %s | git init .', prefs.project_root_path))
    core_utils.move_folder(
        prefs.project_root_path .. '.git',
        prefs.project_root_path .. '.gitprivate')
    vim.notify('Created Private Repository', vim.log.levels.INFO)
    -- creating public repository
    vim.fn.system(string.format('cd %s | git init .', prefs.project_root_path))
    core_utils.move_folder(
        prefs.project_root_path .. '.git',
        prefs.project_root_path .. '.gitpublic')
    vim.notify('Created Public Repository', vim.log.levels.INFO)
end

----------------------------- pull [g]it in [M]ath -----------------------------

git.pull_git_in_math = function()
    -- pull public
    vim.fn.system(string.format('cd %s | git pull --git-dir=gitpublic --no-rebase', prefs.project_root_path))
    -- pull private
    vim.fn.system(string.format('cd %s | git pull --git-dir=gitprivate --no-rebase', prefs.project_root_path))
end

------------------------- commit/push [g]it in [m]ath --------------------------

git.push_git_in_math = function()
    -- add, commit, and push private
    vim.fn.system(string.format('cd %s | git add --git-dir=gitprivate -A', prefs.project_root_path))
    vim.fn.system(string.format('cd %s | git commit --git-dir=gitprivate -a', prefs.project_root_path))
    vim.fn.system(string.format('cd %s | git push --git-dir=gitprivate --no-rebase', prefs.project_root_path))
    -- commit and push public
    vim.fn.system(string.format('cd %s | git commit --git-dir=gitpublic -a', prefs.project_root_path))
    vim.fn.system(string.format('cd %s | git push --git-dir=gitpublic --no-rebase', prefs.project_root_path))
end

---------------------------------- pull [g]it ----------------------------------

git.pull_git = function()
    -- pull local git
    local directory = core_utils.current_directory()
    vim.fn.system(string.format('cd %s | git pull --no-rebase', directory))
end

------------------------------ commit/push [g]it -------------------------------

git.push_git = function()
    -- add all, commit all, push with merge all
    local directory = core_utils.current_directory()
    vim.fn.system(string.format('cd %s | git add -A', directory))
    vim.fn.system(string.format('cd %s | git commit -a', directory))
    vim.fn.system(string.format('cd %s | git push --no-rebase', directory))
end

------------------------- project from [g]ithub [R]epo -------------------------

git.git_to_project = function()
    -- SKIPPING FOR NOW
end

------------------------- [g]ithub [r]epo from project -------------------------

git.project_to_git = function()
    local project_path = core_utils.current_project_path()
    if project_path == nil then
        vim.notify('Not in Project Directory', vim.log.levels.ERROR)
        return
    end
    vim.fn.system(
        string.format(
            'cd %s | git init | git add -A | git commit -a | gh repo create %s --source . --gitignore tex --private --push',
            prefs.project_root_path,
            vim.fn.fnamemodify(core_utils.current_project_path, ':t')))
end

------------------------- toggle file [g]it [p]ublicity --------------------------

git.toggle_file_publicity = function()
    local check = vim.fn.system(string.format('git ls-files %s', core_utils.current_filepath()))
    if check == '' then
        vim.fn.system(string.format('cd %s | git add --git-dir=gitpublic %s', prefs.project_root_path, core_utils.current_filepath()))
    else
        vim.fn.system(string.format('cd %s | git rm --cached --git-dir=gitpublic %s', prefs.project_root_path, core_utils.current_filepath()))
    end
end

------------------------ toggle project [g]it [P]ublicity ------------------------

git.toggle_project_publicity = function()
    local check = vim.fn.system(string.format('git ls-files %s', core_utils.current_filepath()))
    if check == '' then
        vim.fn.system(string.format('cd %s | git add --git-dir=gitpublic %s*', prefs.project_root_path, core_utils.current_directory()))
    else
        vim.fn.system(string.format('cd %s | git rm -r --cached --git-dir=gitpublic %s', prefs.project_root_path, core_utils.current_directory()))
    end
end

--------------------------------------------------------------------------------

return git

--------------------------------------------------------------------------------
