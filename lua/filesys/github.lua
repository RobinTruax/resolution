--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computation math.

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

--------------------------------- [l]azy[g]it ----------------------------------

git.lazygit = function()
    vim.cmd('LazyGitCurrentFile')
end

---------------------------------- [g]it[h]ub ----------------------------------

git.configure_github = function()
    -- check if standard repo exists
    if vim.fn.system(string.format('git -C %s rev-parse --is-inside-work-tree'), prefs.project_root_path) ~= 'true' then
        git.configure_standard_repos()
    end
    -- configure github user authentication
    vim.cmd('2TermExec cmd="gh auth login"')
    -- create github repo for private
    -- create github repo for public
end

---------------------------- [g]it [s]tandard repos ----------------------------

git.configure_standard_repos = function()
    -- check if repo exists
    if vim.fn.system(string.format('git -C %s rev-parse --is-inside-work-tree'), prefs.project_root_path) ~= 'true' then
        -- 
    end
end

----------------------------- pull [g]it in [M]ath -----------------------------

git.pull_git_in_math = function()
end

------------------------- commit/push [g]it in [M]ath --------------------------

git.push_git_in_math = function()
end

----------------------------- pull [B]uiltin [g]it -----------------------------

git.pull_git_builtin = function()
end

------------------------- commit/push [B]uiltin [g]it --------------------------

git.push_git_builtin = function()
end

---------------------- project from [g]it/overleaf [R]epo ----------------------

git.git_to_project = function()
end

---------------------- [g]it/overleaf [r]epo from project ----------------------

git.project_to_git = function()
end

------------------------- toggle file [g]it [p]ublicity --------------------------

git.toggle_file_publicity = function()
end

------------------------ toggle project [g]it [P]ublicity ------------------------

git.toggle_project_publicity = function()
end

--------------------------------------------------------------------------------

return git

--------------------------------------------------------------------------------

-- set up [g]it[h]ub user and math repos
-- git -C /home/roshan/Mathematics init 
-- git -C /home/roshan/Mathematics checkout -b public

-- pull [g]it repos in [M]ath folder
-- find /home/roshan/Mathematics -maxdepth 3 -name .git -type d | rev | cut -c 6- | rev | xargs -I {} git -C {} pull

-- commit/push [g]it repos in [m]ath folder
-- find /home/roshan/Mathematics -maxdepth 3 -name .git -type d | rev | cut -c 6- | rev | xargs -I {} git -C {} add --all
-- find /home/roshan/Mathematics -maxdepth 3 -name .git -type d | rev | cut -c 6- | rev | xargs -I {} git -C {} commit -m 'Updated via resolution.'
-- find /home/roshan/Mathematics -maxdepth 3 -name .git -type d | rev | cut -c 6- | rev | xargs -I {} git -C {} push

-- pull [B]uilt-in [g]it repositories

-- commit/push [b]uilt-in [g]it repositories

-- create project from [g]it or overleaf [R]epository

-- create [g]it or overleaf [r]epository from project

-- toggle file [g]it [p]ublicity
-- add to mathematics, branch = public or remove from mathematics, branch = private

-- toggle project [g]it [P]ublicity
-- get project file
-- add to mathematics, branch = public or remove from mathematics, branch = private

-- pull from [O]verleaf via [g]it

-- push to [o]verleaf via [
