local config           = {}

--------------------------- settings ----------------------------
config.automath        = false
config.autoscript      = false
config.prefix_patterns = {
    space_only = '',
    generic    = '',
    no_dots    = '',
    no_dashes  = '',
}
config.greek_letters   = {
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
config.greek_st_pat    = '[a-ik-uwxzCDFGLNOPSWX]'
config.greek_vs_pat    = '[efco]'

--------------------------- non-math ----------------------------

-- an environment snippet is defined as a table in the following array
--      environment  (string)  : LaTeX name of environment               (required)
--      trigger      (string)  : trigger for snippet                     (required)
--      description  (string)  : description of snippet                  (optional)
--      options      (string)  : follows \begin{environment}             (optional)
--      content      (table)   : default body content                    (optional)
--      auto         (boolean) : automatically expand w/o <Tab> press    (optional)
--      mathmode     (boolean) : snippet is defined in math mode         (optional)
--      line         (integer) : 0 (line begin), 1 (anywhere), 2 (break) (optional)
--      label        (integer) : include label generated from nth i-node (optional)
--      priority     (integer) : snippet priority                        (optional)
--      snippets     (table)   : snippets defined for this env only      (optional)
--          trigger  (string)  : trigger for expansion                   (required)
--          expanded (string)  : expanded version of snippet             (required)
--          auto     (boolean) : automatically expand w/o <Tab> press    (optional)
-- nodes are auto-generated: 
--      the first content node (if there are any) captures any stored visual input
--      the rest are insert nodes

config.environments    = {
    ------------------------- theorem-style -------------------------
    {
        environment = 'definition',
        trigger     = 'def',
        options     = '[<>]',
        label       = 1,
    },
    {
        environment = 'theorem',
        trigger     = 'thm',
        options     = '[<>]',
        label       = 1,
    },
    {
        environment = 'proposition',
        trigger     = 'prop',
        options     = '[<>]',
        label       = 1,
    },
    {
        environment = 'lemma',
        trigger     = 'lem',
        options     = '[<>]',
        label       = 1,
    },
    {
        environment = 'corollary',
        trigger     = 'cor',
        options     = '[<>]',
        label       = 1,
    },
    {
        environment = 'conjecture',
        trigger     = 'conj',
        options     = '[<>]',
        label       = 1,
    },
    {
        environment = 'example',
        trigger     = 'exam',
        options     = '[<>]',
        label       = 1,
    },
    {
        environment = 'problem',
        trigger     = 'prob',
        options     = '[<>]',
        label       = 1,
    },
    {
        environment = 'solution',
        trigger     = 'sol',
        options     = '[<>]',
        label       = 1,
    },

    -------------------------- basic-style --------------------------
    {
        environment = 'proof',
        trigger     = 'prf',
    },
    {
        environment = 'center',
        trigger     = 'ctr',
    },
    {
        environment = 'equation*',
        description = 'Equation',
        trigger     = 'mk',
        auto        = true,
        line        = 2,
    },
    {
        environment = 'equation*',
        description = 'Equation',
        trigger     = 'mk',
        auto        = true,
        line        = 2,
    },
    {
        environment = 'equation',
        description = 'Numbered Equation',
        trigger     = 'refeq',
        options     = '\\label{eq:<>}',
        line        = 2,
    },
    {
        environment = 'align*',
        trigger     = 'ali',
    },

    ------------------------ enumerate-style ------------------------
    {
        environment = 'itemize',
        trigger     = 'itm',
        description = 'Unordered List',
        options     = '',
        content     = { '    \\item <>' },
        snippets    = {
            trigger  = '    ii ',
            expanded = '\\item ',
            auto     = true,
        },
    },
    {
        environment = 'enumerate',
        trigger     = 'enm',
        description = 'Numbered List',
        options     = '',
        content     = { '    \\item ' },
        snippets    = {
            trigger  = '    ii ',
            expanded = '\\item ',
            auto     = true,
        },
    },
    {
        environment = 'enumerate',
        trigger     = 'aenm',
        description = 'Alphabetical List',
        options     = '[label=(\\alph*)]',
        content     = { '    \\item <>' },
        snippets    = {
            trigger  = '    ii ',
            expanded = '\\item ',
            auto     = true,
        },
    },
    {
        environment = 'enumerate',
        trigger     = 'renm',
        description = 'Roman-Numbered List',
        options     = '[label=(\\roman*)]',
        content     = { '    \\item <>' },
        snippets    = {
            trigger  = '    ii ',
            expanded = '\\item ',
            auto     = true,
        },
    },

    ----------------------------- other -----------------------------
    {
        environment = 'lstlisting',
        trigger     = 'lst',
        description = 'Code Listing',
        options     = '[language = <>, caption = <>]',
        label       = 2,
    },
    {
        environment = 'figure',
        trigger     = 'fig',
        description = 'Centered Figure',
        options     = '[H<>]',
        content     = {
            '    \\caption{<>}',
            '    \\centering',
            '    \\includegraphics[width=<>\\textwidth]{<>}'
        },
        label       = 2,
    },
    {
        environment = 'wrapfigure',
        trigger     = 'wfig',
        description = 'Wrapped Figure',
        options     = '{<>}{<>\\textwidth}',
        content     = {
            '    \\caption{<>}',
            '    \\centering',
            '    \\includegraphics[width=<>\\textwidth]{<>}'
        },
        label       = 3,
        priority    = 101,
    },
    {
        environment = 'table',
        trigger     = 'tabl',
        description = 'Table Environment',
        options     = '[H<>]',
        content     = {
            '    \\caption{<>}',
            '    \\centering',
            '    tab<>x<>'
        },
        label       = 2,
    },
}

-- a command snippet is defined as a table in the following array
--     expanded    (string)  : LaTeX expression                     (required)
--     trigger     (string)  : trigger for snippet                  (required)
--     description (string)  : description of snippet               (optional => autogenerated)
--     mathmode    (boolean) : snippet is defined in math mode      (optional => false)
--     auto        (boolean) : automatically expand w/o <Tab> press (optional => false)
--     priority    (integer) : snippet priority                     (optional => 100)
--     defaults    (table)   : default entries for each insert node (optional => nil)
--     visual      (integer) : place to set visual input            (optional => 1)
-- nodes are auto-generated: the first node captures any stored visual input, and the rest are insert nodes
config.commands        = {
    ------------------------- entering math -------------------------
    {
        expanded    = '$<>$',
        trigger     = 'jk',
        description = 'Inline Math',
        auto        = true,
    },
    {
        expanded    = '$<>$',
        trigger     = 'kj',
        description = 'Inline Math',
        auto        = true,
    },
    {
        expanded    = '$|<>$',
        trigger     = '|',
        description = 'Cardinality from Text Mode',
        auto        = true,
    },
    {
        expanded    = '$\\frac{<>}{<>}<>$',
        trigger     = '//',
        description = 'Fraction from Text Mode',
        auto        = true,
    },

    ----------------------------- fonts -----------------------------
    {
        expanded    = '\\textbf{<>}',
        trigger     = 'bf',
        description = 'Bold (Font)',
    },
    {
        expanded    = '\\emph{<>}',
        trigger     = 'it',
        description = 'Italicize (Font)',
    },
    {
        expanded    = '\\texttt{<>}',
        trigger     = 'tt',
        description = 'Teletype (Font)',
    },
    {
        expanded    = '\\textsc{<>}',
        trigger     = 'sc',
        description = 'Small Caps (Font)',
    },
    {
        expanded    = '\\textsf{<>}',
        trigger     = 'sf',
        description = 'Sans Serif (Font)',
    },
    {
        expanded    = '\\textrm{<>}',
        trigger     = 'rm',
        description = 'Roman (Font)',
    },

    --------------------- labels and references ---------------------
    {
        expanded    = '\\label{<>}',
        trigger     = 'lab',
        description = 'Label',
    },
    {
        expanded    = '\\ref{<>}',
        trigger     = 'ref',
        description = 'Reference',
    },

    --------------------------- sections ----------------------------
    {
        expanded    = '\\section{<>}',
        trigger     = 'sec',
        description = 'Section',
    },
    {
        expanded    = '\\subsection{<>}',
        trigger     = 'ssec',
        description = 'Subsection',
        priority    = 101,
    },
    {
        expanded    = '\\subsubsection{<>}',
        trigger     = 'sssec',
        description = 'Subsection',
        priority    = 102,
    },

    --------------------- expositionary arrows ----------------------
    {
        expanded    = '\\exparrow{<>}{<>}{<>}{<>}',
        trigger     = 'exparrow',
        description = 'Expositionary Arrow',
        defaults    = { 'label', 'text', 'color', 'direction' },
        visual      = 2,
    },
    {
        expanded    = '\\exparrowadv{<>}{<>}{<>}{<>}{<>}',
        trigger     = 'exparrowadv',
        description = 'Expositionary Arrow (Advanced)',
        defaults    = { 'label', 'text', 'color', 'direction', 'height' },
        visual      = 2,
    },
    {
        expanded    = '\\exparrowdual{<>}{<>}{<>}{<>}{<>}',
        trigger     = 'exparrowdual',
        description = 'Expositionary Arrow (Dual)',
        defaults    = { 'label 1', 'label 2', 'text', 'color', 'direction' },
        visual      = 3,
    },
    {
        expanded    = '\\expspacing',
        trigger     = 'expspacing',
        description = 'Expositionary Arrow Spacing',
    },
    {
        expanded    = '\\expspacingadv{<>}',
        trigger     = 'expspacingadv',
        description = 'Expositionary Arrow Spacing (Advanced)',
        defaults    = { 'height' },
    },
}

----------------------------- math ------------------------------

-- a command snippet is defined as a table in the following array
--     expanded    (string)  : LaTeX expression                     (required)
--     trigger     (string)  : trigger for snippet                  (required)
--     description (string)  : description of snippet               (optional => autogenerated)
--     mathmode    (boolean) : snippet is defined in math mode      (optional => true)
--     auto        (boolean) : automatically expand w/o <Tab> press (optional => false)
--     prefix      (string)  : required prefix for expansion        (optional => nil)
--     suffix      (string)  : required suffix for expansion        (optional => nil)
--     priority    (integer) : snippet priority                     (optional => 100)
--     defaults    (table)   : default entries for each insert node (optional => nil)
--     visual      (integer) : place to set visual input            (optional => 1)
-- nodes are auto-generated: the first node captures any stored visual input, and the rest are insert nodes
config.math_commands   = {
    ----------------------------- fonts -----------------------------
    {
        expanded    = '\\textbf{<>}',
        trigger     = 'bf',
        description = 'Bold (Font)',
    },
    {
        expanded    = '\\emph{<>}',
        trigger     = 'it',
        description = 'Italicize (Font)',
    },
    {
        expanded    = '\\texttt{<>}',
        trigger     = 'tt',
        description = 'Teletype (Font)',
    },
    {
        expanded    = '\\textsc{<>}',
        trigger     = 'sc',
        description = 'Small Caps (Font)',
    },
    {
        expanded    = '\\textsf{<>}',
        trigger     = 'sf',
        description = 'Sans Serif (Font)',
    },
    {
        expanded    = '\\textrm{<>}',
        trigger     = 'rm',
        description = 'Roman (Font)',
    },
    {
        expanded = '\\sqrt{<>}',
        trigger  = 'sq',
    },
    {
        expanded = '\\sqrt[<>]{<>}',
        trigger  = 'nsq',
    },

    ----------------------- simple modifiers ------------------------
    {
        expanded    = '^{-1}',
        trigger     = 'nv',
        description = 'Inverse',
    },
    {
        expanded    = '^{\\dagger}',
        trigger     = 'dg',
        description = 'Dagger',
    },
    {
        expanded    = '^{\\co}',
        trigger     = 'co',
        description = 'Complement',
    },
    {
        expanded    = '^{\\perp}',
        trigger     = 'pr',
        description = 'Orthogonal Complement',
    },
    {
        expanded    = '^{\\top}',
        trigger     = 'tp',
        description = 'Transpose',
    },
    {
        expanded    = '^{\\op}',
        trigger     = 'op',
        description = 'Dual',
    },

    ----------------------------- sums ------------------------------
    {
        expanded    = '\\sum',
        trigger     = 'sum',
        description = 'Sum',
    },
    {
        expanded    = '\\sum_{<>}',
        trigger     = 'suml',
        description = 'Sum (Lower Limit)',
        auto        = true,
        prefix      = config.prefix_patterns.generic
    },
    {
        expanded    = '\\sum_{<>}^{<>}',
        trigger     = 'sumb',
        description = 'Sum (Both Limits)',
        auto        = true,
        prefix      = config.prefix_patterns.generic
    },
    {
        expanded    = '\\sum_{<> = <>}^{\\infty}',
        trigger     = 'sumi',
        description = 'Sum (To Infinity)',
        auto        = true,
        prefix      = config.prefix_patterns.generic
    },
    {
        expanded    = '\\sum_{\\substack{<>}}^{<>}',
        trigger     = 'sums',
        description = 'Sum (Substack Lower Limit)',
        auto        = true,
        prefix      = config.prefix_patterns.generic
    },

    --------------------------- products ----------------------------
    {
        expanded    = '\\prod',
        trigger     = 'prod',
        description = 'Product',
    },
    {
        expanded    = '\\prod_{<>}',
        trigger     = 'prodl',
        description = 'Product (Lower Limit)',
        auto        = true,
        prefix      = config.prefix_patterns.generic
    },
    {
        expanded    = '\\prod_{<>}^{<>}',
        trigger     = 'prodb',
        description = 'Product (Both Limits)',
        auto        = true,
        prefix      = config.prefix_patterns.generic
    },
    {
        expanded    = '\\prod_{<> = <>}^{\\infty}',
        trigger     = 'prodi',
        description = 'Product (To Infinity)',
        auto        = true,
        prefix      = config.prefix_patterns.generic
    },
    {
        expanded    = '\\prod_{\\substack{<>}}^{<>}',
        trigger     = 'prods',
        description = 'Product (Substack Lower Limit)',
        auto        = true,
        prefix      = config.prefix_patterns.generic
    },

    ---------------------------- unions -----------------------------
    {
        expanded    = '\\bigcup',
        trigger     = 'cup',
        description = 'Union',
    },
    {
        expanded    = '\\bigcup_{<>}',
        trigger     = 'cupl',
        description = 'Union (Lower Limit)',
        auto        = true,
        prefix      = config.prefix_patterns.generic
    },
    {
        expanded    = '\\bigcup_{<>}^{<>}',
        trigger     = 'cupb',
        description = 'Union (Both Limits)',
        auto        = true,
        prefix      = config.prefix_patterns.generic
    },
    {
        expanded    = '\\bigcup_{<> = <>}^{\\infty}',
        trigger     = 'cupi',
        description = 'Union (To Infinity)',
        auto        = true,
        prefix      = config.prefix_patterns.generic
    },
    {
        expanded    = '\\bigcup_{\\substack{<>}}^{<>}',
        trigger     = 'cups',
        description = 'Union (Substack Lower Limit)',
        auto        = true,
        prefix      = config.prefix_patterns.generic
    },

    ------------------------- intersections -------------------------
    {
        expanded    = '\\bigcap',
        trigger     = 'cap',
        description = 'Intersection',
    },
    {
        expanded    = '\\bigcap_{<>}',
        trigger     = 'capl',
        description = 'Intersection (Lower Limit)',
        auto        = true,
        prefix      = config.prefix_patterns.generic
    },
    {
        expanded    = '\\bigcap_{<>}^{<>}',
        trigger     = 'capb',
        description = 'Intersection (Both Limits)',
        auto        = true,
        prefix      = config.prefix_patterns.generic
    },
    {
        expanded    = '\\bigcap_{<> = <>}^{\\infty}',
        trigger     = 'capi',
        description = 'Intersection (To Infinity)',
        auto        = true,
        prefix      = config.prefix_patterns.generic
    },
    {
        expanded    = '\\bigcap_{\\substack{<>}}^{<>}',
        trigger     = 'caps',
        description = 'Intersection (Substack Lower Limit)',
        auto        = true,
        prefix      = config.prefix_patterns.generic
    },

    ---------------------------- limits -----------------------------
    {
        expanded    = '\\lim',
        trigger     = 'lim',
        description = 'Limit',
    },
    {
        expanded    = '\\lim_{<>}',
        trigger     = 'liml',
        description = 'Limit (Lower Limit)',
        auto        = true,
        prefix      = config.prefix_patterns.generic
    },
    {
        expanded    = '\\limsup_{<>}',
        trigger     = 'lims',
        description = 'Limit Supremum (Lower Limit)',
        auto        = true,
        prefix      = config.prefix_patterns.generic
    },
    {
        expanded    = '\\liminf_{<>}',
        trigger     = 'limi',
        description = 'Limit Infimum (Lower Limit)',
        auto        = true,
        prefix      = config.prefix_patterns.generic
    },

    --------------------------- integrals ---------------------------
    {
        expanded    = '\\int',
        trigger     = 'int',
        description = 'Integral',
    },
    {
        expanded    = '\\int_{<>}',
        trigger     = 'intl',
        description = 'Integral (Lower Limit)',
        auto        = true,
        prefix      = config.prefix_patterns.generic
    },
    {
        expanded    = '\\int_{<>}^{<>}',
        trigger     = 'intb',
        description = 'Integral (Both Limits)',
        auto        = true,
        prefix      = config.prefix_patterns.generic
    },
    {
        expanded    = '\\int_{-\\infty}^{\\infty}',
        trigger     = 'inti',
        description = 'Integral (Infinite Limits)',
        auto        = true,
        prefix      = config.prefix_patterns.generic
    },

    --------------- minimum/maximum/supremum/infimum ----------------
    {
        expanded    = '\\min',
        trigger     = 'min',
        description = 'Minimum',
    },
    {
        expanded    = '\\min_{<>}',
        trigger     = 'minl',
        description = 'Minimum (Lower Limit)',
        auto        = true,
        prefix      = config.prefix_patterns.generic
    },
    {
        expanded    = '\\max',
        trigger     = 'max',
        description = 'Maximum',
    },
    {
        expanded    = '\\max_{<>}',
        trigger     = 'maxl',
        description = 'Maximum (Lower Limit)',
        auto        = true,
        prefix      = config.prefix_patterns.generic
    },
    {
        expanded    = '\\inf',
        trigger     = 'inf',
        description = 'Infimum',
    },
    {
        expanded    = '\\inf_{<>}',
        trigger     = 'infl',
        description = 'Infimum (Lower Limit)',
        auto        = true,
        prefix      = config.prefix_patterns.generic
    },
    {
        expanded    = '\\sup',
        trigger     = 'sup',
        description = 'Supremum',
    },
    {
        expanded    = '\\sup_{<>}',
        trigger     = 'supl',
        description = 'Supremum (Lower Limit)',
        auto        = true,
        prefix      = config.prefix_patterns.generic
    },

    ------------------------ over/undersets -------------------------
    {
        expanded    = '\\overset{<>}{<>}',
        trigger     = 'ovs',
        description = 'Overset',
        default     = { 'over', 'main' }
    },
    {
        expanded    = '\\underset{<>}{<>}',
        trigger     = 'uns',
        description = 'Underset',
        default     = { 'under', 'main' }
    },
    {
        expanded    = '\\overbrace{<>}^{<>}',
        trigger     = 'ovb',
        description = 'Overbrace',
    },
    {
        expanded    = '\\underbrace{<>}^{<>}',
        trigger     = 'unb',
        description = 'Underbrace',
    },

    --------------------------- fractions ---------------------------
    {
        expanded    = '\\frac{<>}{<>}',
        trigger     = '//',
        description = 'Fraction',
        auto        = true,
        prefix      = config.prefix_patterns.generic
    },
    {
        expanded    = '\\frac{\\diff <>}{\\diff <>}',
        trigger     = 'dff',
        description = 'Differential',
    },
    {
        expanded    = '\\frac{\\partial <>}{\\partial <>}',
        trigger     = 'pff',
        description = 'Partial Differential',
    },

    --------------------- sub and superscripts ----------------------
    {
        expanded    = '^{<>}',
        trigger     = '.;',
        description = 'Superscript',
        auto        = true,
    },
    {
        expanded    = '_{<>}',
        trigger     = ';.',
        description = 'Subscript',
        auto        = true,
    },
    {
        expanded    = '^',
        trigger     = '.\'',
        description = 'Superscript (Simple)',
        auto        = true,
    },
    {
        expanded    = '_{<>}',
        trigger     = '\'.',
        description = 'Subscript (Simple)',
        auto        = true,
    },

    ---------------------- node for exparrows -----------------------
    {
        expanded    = '\\expnode{<>}{$<>$}{<>}',
        trigger     = 'node',
        description = 'Expositionary Node',
        defaults    = { 'math', 'label', 'color' },
        visual      = 2,
    },

    ----------------------------- cases -----------------------------
    {
        expanded    =
        [[\begin{cases}
    <> & <> \\
    <> & <> \\
\end{cases}]],
        trigger     = 'case',
        description = 'Cases',
        defaults    = { 'case 1', 'conditional 1', 'case 2', 'conditional 2' },
    },
}

-- a modifier snippet is defined as an entry in the following table
--     trigger      (string)  : regex trigger for snippet          (required)
--     modifier     (string)  : the modifier itself                (required)
--     description  (string)  : description of snippet             (optional => autogen-ed)
--     english_only (boolean) : english only (as opposed to Greek) (optional => false)
config.modifiers = {
    {
        trigger = 'cal',
        modifier = 'cal',
        description = 'Calligraphic',
        english_only = true,
    },
    {
        trigger = 'scr',
        modifier = 'scr',
        description = 'Script',
        english_only = true,
    },
    {
        trigger = 'frk',
        modifier = 'frak',
        description = 'Fraktur',
        english_only = true,
    },
    {
        trigger = 'bb',
        modifier = 'bb',
        description = 'Blackboard',
        english_only = true,
    },
    {
        trigger = 'bar',
        modifier = 'bar',
        description = 'Bar',
    },
    {
        trigger = 'hat',
        modifier = 'hat',
        description = 'Hat',
    },
    {
        trigger = 'vec',
        modifier = 'vec',
        description = 'Vector',
    },
    {
        trigger = 'tld',
        modifier = 'tld',
        description = 'Tilde',
    },
    {
        trigger = 'bra',
        modifier = 'bra',
        description = 'Bra (bra-ket)',
    },
    {
        trigger = 'ket',
        modifier = 'ket',
        description = 'Ket (bra-ket)',
    },
    {
        trigger = 'ckk',
        modifier = 'check',
        description = 'Check',
    },
    {
        trigger = 'nrm',
        modifier = 'nrm',
        description = 'Norm',
    },
    {
        trigger = 'flr',
        modifier = 'floor',
        description = 'Floor',
    },
    {
        trigger = 'cei',
        modifier = 'ceil',
        description = 'Ceiling',
    },
}

-- this system is specialized for delimiters
--     { left, right }
config.delimiters = {
    { '(', ')' },
    { '{', '}' },
    { '[', ']' },
    { '<', '>' },
    { '|', '|' },
}

-- a symbol snippet is defined as a table in the following array
--     trigger     (string)                  : regex trigger for snippet            (required)
--     program     (string/function/integer) : how to get string                    (required)
--     description (string)                  : description of snippet               (optional => autogen-ed)
--     prefix      (string)                  : required prefix for expansion        (optional => nil)
--     suffix      (string)                  : required suffix for expansion        (optional => nil)
--     mathmode    (boolean)                 : snippet is defined in math mode      (optional => true)
--     defaults    (table)                   : default entries for each insert node (optional => nil)
--     auto        (boolean)                 : automatically expand                 (optional => false)
-- nodes are auto-generated: the first node captures any stored visual input, and the rest are insert nodes
config.math_symbols    = {
    ------------------------- greek letters -------------------------
    {
        trigger = '(%;' .. config.greek_st_pat .. ')',
        program = function(captures)
            return config.greek_letters[captures[1]]
        end,
        description = 'Greek Letters',
    },
    {
        trigger = '(%;v' .. config.greek_vs_pat .. ')',
        program = function(captures)
            return config.greek_letters[captures[1]]
        end,
        description = 'Greek Letters (Special)',
    },
    ---------------------------- arrows -----------------------------
    {
        trigger = '%|%>',
        program = '\\mapsto',
        auto    = true,
        prefix  = config.prefix_patterns.no_dashes,
        suffix  = config.prefix_patterns.no_dashes
    },
    {
        trigger = '%-%>',
        program = '\\rightarrow',
        auto    = true,
        prefix  = config.prefix_patterns.no_dashes,
        suffix  = config.prefix_patterns.no_dashes

    },
    {
        trigger = '%<%-',
        program = '\\leftarrow',
        auto    = true,
        prefix  = config.prefix_patterns.no_dashes,
        suffix  = config.prefix_patterns.no_dashes

    },
    {
        trigger = '%=%=%>',
        program = '\\Rightarrow',
        auto    = true,
        prefix  = config.prefix_patterns.no_dashes,
        suffix  = config.prefix_patterns.no_dashes

    },
    {
        trigger = '%<%=%=',
        program = '\\Leftarrow',
        auto    = true,
        prefix  = config.prefix_patterns.no_dashes,
        suffix  = config.prefix_patterns.no_dashes

    },
    {
        trigger = '%|%^',
        program = '\\uparrow',
        auto    = true,
        prefix  = config.prefix_patterns.no_dashes,
        suffix  = config.prefix_patterns.no_dashes

    },
    {
        trigger = '%^%|',
        program = '\\uparrow',
        auto    = true,
        prefix  = config.prefix_patterns.no_dashes,
        suffix  = config.prefix_patterns.no_dashes

    },
    {
        trigger = '%|%v',
        program = '\\downarrow',
        auto    = true,
        prefix  = config.prefix_patterns.no_dashes,
        suffix  = config.prefix_patterns.no_dashes

    },
    {
        trigger = '%v%|',
        program = '\\downarrow',
        auto    = true,
        prefix  = config.prefix_patterns.no_dashes,
        suffix  = config.prefix_patterns.no_dashes

    },
    {
        trigger  = '%<%-%>',
        program  = '\\leftrightarrow',
        auto     = true,
        prefix   = config.prefix_patterns.no_dashes,
        suffix   = config.prefix_patterns.no_dashes,
        priority = 101
    },
    {
        trigger  = '%-%-%>',
        program  = '\\longrightarrow',
        auto     = true,
        prefix   = config.prefix_patterns.no_dashes,
        suffix   = config.prefix_patterns.no_dashes,
        priority = 101
    },
    {
        trigger  = '%<%=%=%=',
        program  = '\\Longleftarrow',
        auto     = true,
        prefix   = config.prefix_patterns.no_dashes,
        suffix   = config.prefix_patterns.no_dashes,
        priority = 101
    },
    {
        trigger  = '%=%=%=%>',
        program  = '\\Longrightarrow',
        auto     = true,
        prefix   = config.prefix_patterns.no_dashes,
        suffix   = config.prefix_patterns.no_dashes,
        priority = 101
    },
    {
        trigger  = '%<%-%>',
        program  = '\\leftrightarrow',
        auto     = true,
        prefix   = config.prefix_patterns.no_dashes,
        suffix   = config.prefix_patterns.no_dashes,
        priority = 101
    },
    {
        trigger  = '%<%=%=%>',
        program  = '\\Leftrightarrow',
        auto     = true,
        prefix   = config.prefix_patterns.no_dashes,
        suffix   = config.prefix_patterns.no_dashes,
        priority = 102
    },
    {
        trigger  = '%-%>%-%>',
        program  = '\\rightrightarrows',
        auto     = true,
        prefix   = config.prefix_patterns.no_dashes,
        suffix   = config.prefix_patterns.no_dashes,
        priority = 102
    },
    {
        trigger  = '%<%-%<%-',
        program  = '\\leftleftarrows',
        auto     = true,
        prefix   = config.prefix_patterns.no_dashes,
        suffix   = config.prefix_patterns.no_dashes,
        priority = 102
    },
    {
        trigger  = '%|%-%>',
        program  = '\\hookrightarrow',
        auto     = true,
        prefix   = config.prefix_patterns.no_dashes,
        suffix   = config.prefix_patterns.no_dashes,
        priority = 102
    },
    {
        trigger  = '%<%-%|',
        program  = '\\hookleftarrow',
        auto     = true,
        prefix   = config.prefix_patterns.no_dashes,
        suffix   = config.prefix_patterns.no_dashes,
        priority = 102
    },
    {
        trigger  = '%-%>%>',
        program  = '\\twoheadrightarrow',
        auto     = true,
        prefix   = config.prefix_patterns.no_dashes,
        suffix   = config.prefix_patterns.no_dashes,
        priority = 102
    },
    {
        trigger  = '%<%<%-',
        program  = '\\twoheadleftarrow',
        auto     = true,
        prefix   = config.prefix_patterns.no_dashes,
        suffix   = config.prefix_patterns.no_dashes,
        priority = 102
    },
    {
        trigger  = '%<%-%-%>',
        program  = '\\longleftrightarrow',
        auto     = true,
        prefix   = config.prefix_patterns.no_dashes,
        suffix   = config.prefix_patterns.no_dashes,
        priority = 102
    },
    {
        trigger  = '%<%=%=%=%>',
        program  = '\\Longleftrightarrow',
        auto     = true,
        prefix   = config.prefix_patterns.no_dashes,
        suffix   = config.prefix_patterns.no_dashes,
        priority = 102
    },
    {
        trigger  = '%-%-%-%>',
        program  = '\\xrightarrow[<>]{<>}',
        auto     = true,
        defaults = { 'sub', 'sup' },
        prefix   = config.prefix_patterns.no_dashes,
        suffix   = config.prefix_patterns.no_dashes,
        priority = 102
    },
    {
        trigger  = '%<%-%-%-',
        program  = '\\xleftarrow[<>]{<>}',
        auto     = true,
        defaults = { 'sub', 'sup' },
        prefix   = config.prefix_patterns.no_dashes,
        suffix   = config.prefix_patterns.no_dashes,
        priority = 102
    },
    {
        trigger  = '%<%-%-%-%>',
        program  = '\\xleftrightarrow[<>]{<>}',
        auto     = true,
        defaults = { 'sub', 'sup' },
        prefix   = config.prefix_patterns.no_dashes,
        suffix   = config.prefix_patterns.no_dashes,
        priority = 102
    },
    {
        trigger  = '%=%=%=%>',
        program  = '\\xRightarrow[<>]{<>}',
        auto     = true,
        defaults = { 'sub', 'sup' },
        prefix   = config.prefix_patterns.no_dashes,
        suffix   = config.prefix_patterns.no_dashes,
        priority = 102
    },
    {
        trigger  = '%<%=%=%=',
        program  = '\\xLeftarrow[<>]{<>}',
        auto     = true,
        defaults = { 'sub', 'sup' },
        prefix   = config.prefix_patterns.no_dashes,
        suffix   = config.prefix_patterns.no_dashes,
        priority = 102
    },
    {
        trigger  = '%<%=%=%=%>',
        program  = '\\xLeftrightarrow[<>]{<>}',
        auto     = true,
        defaults = { 'sub', 'sup' },
        prefix   = config.prefix_patterns.no_dashes,
        suffix   = config.prefix_patterns.no_dashes,
        priority = 102
    },

    -------------------------- containment --------------------------
    {
        trigger  = 'cc',
        program  = '\\subseteq',
        auto     = true,
        prefix   = config.prefix_patterns.generic,
        suffix   = config.prefix_patterns.generic,
        priority = 102
    },
    {
        trigger  = 'ccc',
        program  = '\\subset',
        auto     = true,
        prefix   = config.prefix_patterns.generic,
        suffix   = config.prefix_patterns.generic,
        priority = 102
    },
    {
        trigger  = 'ncc',
        program  = '\\subsetneq',
        auto     = true,
        prefix   = config.prefix_patterns.generic,
        suffix   = config.prefix_patterns.generic,
        priority = 102
    },
    {
        trigger  = 'dd',
        program  = '\\supseteq',
        auto     = true,
        prefix   = config.prefix_patterns.generic,
        suffix   = config.prefix_patterns.generic,
        priority = 102
    },
    {
        trigger  = 'ddd',
        program  = '\\supset',
        auto     = true,
        prefix   = config.prefix_patterns.generic,
        suffix   = config.prefix_patterns.generic,
        priority = 102
    },
    {
        trigger  = 'ndd',
        program  = '\\supsetneq',
        auto     = true,
        prefix   = config.prefix_patterns.generic,
        suffix   = config.prefix_patterns.generic,
        priority = 102
    },
    {
        trigger  = 'oo',
        program  = '\\varnothing',
        auto     = true,
        prefix   = config.prefix_patterns.generic,
        suffix   = config.prefix_patterns.generic,
        priority = 102
    },
    {
        trigger  = ';\\',
        program  = '\\setminus',
        auto     = true,
        prefix   = config.prefix_patterns.generic,
        suffix   = config.prefix_patterns.generic,
        priority = 102
    },

    ----------------------------- dots ------------------------------
    {
        trigger = '.',
        program = '\\cdot',
    },
    {
        trigger = '**',
        program = '\\cdots',
    },
    {
        trigger = ':',
        program = '\\vdots',
    },
    {
        trigger  = '..',
        program  = '\\ldots',
        priority = 101,
    },
    {
        trigger  = '.:',
        program  = '\\ddots',
        priority = 101,
    },
    {
        trigger  = ':.',
        program  = '\\iddots',
        priority = 101,
    },
    {
        trigger = 'x',
        program = '\\times',
    },
    {
        trigger = 'ox',
        program = '\\otimes',
    },

    --------------------------- equality ----------------------------
    {
        trigger = '%=%=',
        program = '&=',
        auto    = true,
        prefix  = config.prefix_patterns.generic,
        suffix  = config.prefix_patterns.generic,
    },
    {
        trigger = '%!%=',
        program = '\\neq',
        auto    = true,
        prefix  = config.prefix_patterns.generic,
        suffix  = config.prefix_patterns.generic,
    },
    {
        trigger = '%=%<',
        program = '\\leq',
        auto    = true,
        prefix  = config.prefix_patterns.generic,
        suffix  = config.prefix_patterns.generic,
    },
    {
        trigger = '%<%=',
        program = '\\leq',
        auto    = true,
        prefix  = config.prefix_patterns.generic,
        suffix  = config.prefix_patterns.generic,
    },
    {
        trigger = '%>%=',
        program = '\\geq',
        auto    = true,
        prefix  = config.prefix_patterns.generic,
        suffix  = config.prefix_patterns.generic,
    },
    {
        trigger = '%=%>',
        program = '\\geq',
        auto    = true,
        prefix  = config.prefix_patterns.generic,
        suffix  = config.prefix_patterns.generic,
    },
    {
        trigger = '%>%>',
        program = '\\gg',
        auto    = true,
        prefix  = config.prefix_patterns.generic,
        suffix  = config.prefix_patterns.generic,
    },
    {
        trigger = '%<%<',
        program = '\\ll',
        auto    = true,
        prefix  = config.prefix_patterns.generic,
        suffix  = config.prefix_patterns.generic,
    },
    {
        trigger = '%~%~',
        program = '\\approx',
        auto    = true,
        prefix  = config.prefix_patterns.generic,
        suffix  = config.prefix_patterns.generic,
    },


    ----------------------------- misc ------------------------------
    {
        trigger = 'df',
        program = '\\diff',
    },
    {
        trigger = 'll',
        program = '\\ell',
    },
    {
        trigger = ';6',
        program = '\\partial',
        auto    = true,
    },
    {
        trigger = ';8',
        program = '\\infty',
        auto    = true,
    },
}

---------------------------- special ----------------------------
-- an m_by_n snippet is defined as a table in the following array
--     environment (string)  : environment name                     (required)
--     trigger     (string)  : regex trigger for snippet            (required)
--     program     (table)   : how to compute prefix, m, n, suffix  (required)
--     description (string)  : description of snippet               (optional => autogenerated)
--     mathmode    (boolean) : snippet is defined in math mode      (optional => false)
--     auto        (boolean) : automatically expand w/o <Tab> press (optional => false)
--     default     (table)   : default entry for each insert node   (optional => nil)
-- nodes are auto-generated: the first node captures any stored visual input, and the rest are insert nodes
config.m_by_n_objects  = {
    ---------------------------- matrix -----------------------------
    {
        environment = 'matrix',
        trig        = '([bpv]?)mat(%d+)x(%d+)',
        program     = {
            prefix = 1,
            m      = 2,
            n      = 3,
        },
        description = 'Matrix',
        mathmode    = true,
        default     = 0,
    },
    ----------------------------- table -----------------------------
    {
        environment = 'tabular',
        trig        = 'tab(%d+)x(%d+)',
        program     = {
            m      = 1,
            n      = 2,
            suffix = function(m, n)
                return '{ ' .. string.rep('c', n, ' ') .. ' }'
            end
        },
        description = 'Tabular',
        mathmode    = false,
        default     = 0,
    },
}

return config
