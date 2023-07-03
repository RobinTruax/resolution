--[[------------------- resolution v0.1.0 -----------------------

this config file services the computation module

---------------------------------------------------------------]]

local computation = {}

-----------------------------------------------------------------

-- parameters for the pop-up window
computation.window_parameters = {
    -- 'editor' and 'window' are also reasonable choices
    relative = 'cursor',
    -- changes the size of the entire pop-up
    size = {
        width = 50,
        height = 12,
    },
    -- if the number of lines is greater than this, the popup will automatically wrap
    maximum_wrap = 3,
}
-- whether input to the third file should undergo formatting using latexindent
computation.preformat = true
-- name of temporary file used for latexindent
computation.preformat_filename = 'tempcomp.tex'

-- a list of strings of comma-separated symbols to bring into scope in sympy
computation.symbols_for_sympy = {
    -- letters
    'a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,t,s,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,T,S,U,V,W,X,Y,Z',
    -- letters with single-digit subscripts
    'a:10,b:10,c:10,d:10,e:10,f:10,g:10,h:10,i:10,j:10,k:10,l:10,m:10,n:10,o:10,p:10,q:10,r:10,t:10,s:10,u:10,v:10,w:10,x:10,y:10,z:10,A:10,B:10,C:10,D:10,E:10,F:10,G:10,H:10,I:10,J:10,K:10,L:10,M:10,N:10,O:10,P:10,Q:10,R:10,T:10,S:10,U:10,V:10,W:10,X:10,Y:10,Z:10',
    -- greek letters
    'alpha,beta,gamma,delta,varepsilon,zeta,eta,theta,iota,kappa,lambda,mu,nu,xi,pi,rho,sigma,tau,upsilon,phi,psi,chi,omega,epsilon,varphi,varpsi,vartheta,Gamma,Delta,Theta,Lambda,Xi,Pi,Sigma,Phi,Psi,Omega',
    -- greek letters with single-digit subscripts
    'alpha:10,beta:10,gamma:10,delta:10,varepsilon:10,zeta:10,eta:10,theta:10,iota:10,kappa:10,lambda:10,mu:10,nu:10,xi:10,pi:10,rho:10,sigma:10,tau:10,upsilon:10,phi:10,psi:10,chi:10,omega:10,epsilon:10,varphi:10,varpsi:10,vartheta:10,Gamma:10,Delta:10,Theta:10,Lambda:10,Xi:10,Pi:10,Sigma:10,Phi:10,Psi:10,Omega:10'
}

-----------------------------------------------------------------

return computation

-----------------------------------------------------------------
