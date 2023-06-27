local constants = {}

-- Greek letter expansions
constants.greek_letters = {
    [';a']  = '\\alpha',
    [';b']  = '\\beta',
    [';g']  = '\\gamma',
    [';d']  = '\\delta',
    [';e']  = '\\varepsilon',
    [';z']  = '\\zeta',
    [';h']  = '\\eta',
    [';o']  = '\\theta',
    [';i']  = '\\iota',
    [';k']  = '\\kappa',
    [';l']  = '\\lambda',
    [';m']  = '\\mu',
    [';n']  = '\\nu',
    [';x']  = '\\xi',
    [';p']  = '\\pi',
    [';r']  = '\\rho',
    [';s']  = '\\sigma',
    [';t']  = '\\tau',
    [';u']  = '\\upsilon',
    [';f']  = '\\phi',
    [';c']  = '\\psi',
    [';q']  = '\\chi',
    [';w']  = '\\omega',
    [';ve'] = '\\epsilon',
    [';vf'] = '\\varphi',
    [';vc'] = '\\varpsi',
    [';vo'] = '\\vartheta',
    [';N']  = '\\Nabla',
    [';G']  = '\\Gamma',
    [';D']  = '\\Delta',
    [';O']  = '\\Theta',
    [';L']  = '\\Lambda',
    [';X']  = '\\Xi',
    [';P']  = '\\Pi',
    [';S']  = '\\Sigma',
    [';F']  = '\\Phi',
    [';C']  = '\\Psi',
    [';W']  = '\\Omega',
}
-- pattern for standard Greek exp
constants.greek_st_pat = '[a-ik-uwxzCDFGLNOPSWX]'
-- pattern for special Greek exp
constants.greek_vs_pat = '[efco]'

return constants
