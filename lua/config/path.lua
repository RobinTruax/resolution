--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This file contains a list of folders which need to be specifically added to 
Neovim's path, particularly when you are calling Neovim directly via Neovide or
in some other way bypassing the terminal and thus your .bashrc.

Copyright (C) 2023 Roshan Truax

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) at any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

------------------------------------------------------------------------------]]

return {
    '/home/roshan/.local/bin',
    '/home/roshan/Applications/',
    '/usr/local/texlive/2023/bin/x86_64-linux',
}
