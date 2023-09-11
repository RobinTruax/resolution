--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computation math.

This config file services the computation module.

Copyright (C) 2023 Roshan Truax

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) at any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

------------------------------------------------------------------------------]]

local computation = {}

---------------------------------- THE NAPKIN ----------------------------------

-- The parameters for the window
computation.window_parameters = {
    -- This defines the pop-up location; 'editor' and 'window' are also allowed
    relative = 'cursor',
    -- This changes the size of the entire pop-up
    size = {
        width = 50,
        height = 12,
    },
    -- The popup wraps when the number of lines is greater than maximum_wrap
    maximum_wrap = 3,
}

-- Should output undergo formatting using latexindent
computation.preformat = true

-- The name of the temporary file used for latexindent
computation.preformat_filename = '.temporary-computation-formatting.tex'

-- A list of comma-separated symbols to bring into scope in sympy
computation.symbols_for_sympy = {
    -- Letters
    'a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,t,s,u,v,w,x,y,z',
    'A,B,C,D,F,G,H,J,K,L,M,N,O,P,Q,R,T,S,U,V,W,X,Y,Z',
    -- Letters with single-digit subscripts
    'a:10,b:10,c:10,d:10,e:10,f:10,g:10,h:10,i:10,j:10,k:10,l:10,m:10',
    'n:10,o:10,p:10,q:10,r:10,t:10,s:10,u:10,v:10,w:10,x:10,y:10,z:10',
    'A:10,B:10,C:10,D:10,E:10,F:10,G:10,H:10,J:10,K:10,L:10,M:10',
    'N:10,O:10,P:10,Q:10,R:10,T:10,S:10,U:10,V:10,W:10,X:10,Y:10,Z:10',
    -- Greek letters
    'alpha,beta,gamma,delta,varepsilon,zeta,eta,theta,iota,kappa,lambda',
    'mu,nu,xi,pi,rho,sigma,tau,upsilon,phi,psi,chi,omega,epsilon',
    'varphi,varpsi,vartheta,Gamma,Delta,Theta,Lambda,Xi,Pi,Sigma,Phi,Psi,Omega',
    -- greek letters with single-digit subscripts
    'alpha:10,beta:10,gamma:10,delta:10,varepsilon:10,zeta:10,eta:10,theta:10',
    'iota:10,kappa:10,lambda:10,mu:10,nu:10,xi:10,pi:10,rho:10,sigma:10,tau:10',
    'upsilon:10,phi:10,psi:10,chi:10,omega:10,epsilon:10,varphi:10,varpsi:10,vartheta:10',
    'Gamma:10,Delta:10,Theta:10,Lambda:10,Xi:10,Pi:10,Sigma:10,Phi:10,Psi:10,Omega:10'
}

--------------------------------- THE NOTEBOOK ---------------------------------

-- Kernel list
computation.kernel_list = {
    {
        name = 'SymPy',
        cmd = 'python3',
        desc = 'Napkin/Notebook support',
        folder = 'sympy',
        extension = 'py'
    },
    {
        name = 'SageMath',
        cmd = 'sagemath',
        desc = 'Notebook only',
        folder = 'sage',
        extension = 'py'
    },
}

-- Keybinds
computation.keybinds = {
    -- run cell
    [ 'r' ] = {
        function()
            require('computation.notebook.actions').keybind_operations.run()
        end,
        '[r]un cell'
    },
    -- run cell & move
    [ 'R' ] = {
        function()
            require('computation.notebook.actions').keybind_operations.run_move()
        end,
        '[R]un cell and move'
    },
    -- next cell
    [ 'j' ] = {
        function()
            require('computation.notebook.actions').keybind_operations.next_cell()
        end,
        'move down'
    },
    -- previous cell
    [ 'k' ] = {
        function()
            require('computation.notebook.actions').keybind_operations.prev_cell()
        end,
        'move up'
    },
    -- visual select cell
    [ 'v' ] = {
        function()
            require('computation.notebook.actions').keybind_operations.select_cell()
        end, '[v]isual cell'
    },
    -- comment cell
    [ 'c' ] = {
        function()
            require('computation.notebook.actions').keybind_operations.comment_cell()
        end, '[c]omment cell'
    },
    -- add cell above
    [ 'a' ] = {
        function()
            require('computation.notebook.actions').keybind_operations.add_cell_above()
        end, 'cell [a]bove'
    },
    -- add cell below
    [ 'b' ] = {
        function()
            require('computation.notebook.actions').keybind_operations.add_cell_below()
        end, 'cell [b]elow'
    },
    -- yank cell
    [ 'y' ] = {
        function()
            require('computation.notebook.actions').keybind_operations.copy_cell()
        end, '[y]ank cell'
    },
    -- copy output
    [ 'o' ] = {
        function()
            require('computation.notebook.actions').keybind_operations.copy_output()
        end,
        'copy [o]utput'
    },
    -- create or open new page
    [ 'C' ] = {
        function()
            require('computation.notebook.actions').keybind_operations.create_or_open()
        end, '[C]reate or open new page'
    },
}

--------------------------------------------------------------------------------

return computation

--------------------------------------------------------------------------------
