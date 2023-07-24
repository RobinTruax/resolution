--[[------------------- resolution v0.1.0 -----------------------

github operations built into resolution

---------------------------------------------------------------]]

-- [l]azy[g]it interface (not required)

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

-- push to [o]verleaf via [g]it
