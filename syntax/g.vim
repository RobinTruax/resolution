" Vim syntax file
" Language:	GAP
" Author:  Frank Lübeck,  highlighting based on file by Alexander Hulpke
" Maintainer:	Frank Lübeck
" Last change:	June 2010 
" 
" Comments: If you want to use this file, you may want to adjust colors to
" your taste. There are some functions/macros for 
" GAPnl                -- newline, with reindenting the old line
"                         (mapped on <CTRL>-j)
" ToggleCommentGAP     -- toggle comment, add or remove "##  " 
"                         (mapped on F12)
" <F4>                 -- macro to add word under cursor to `local' list
" GAPlocal             -- add whole `local' declaration to current function
"                         (mapped on <F5>)
" Then the completion mechanism <CTRL>-p is extended to complete all
" GAP variable names - search `GAPWORDS' below, how to do this.
"
" For vim version >= 6.0 folding is switched on.
" 
" For vim version >= 6.0 there is another file gap_indent.vim which you 
" may want to copy into ~/.vim/indent/gap.vim -- this provides a nice
" automatic indenting while writing GAP code.
"

" Please, send comments and suggestions to:  Frank.Luebeck@Math.RWTH-Aachen.De

" Remove any old syntax stuff hanging around
syn clear

" comments
syn match gapComment "\(#.*\)*" contains=gapTodo,gapFunLine

" strings and characters
syn region gapString  start=+"+ end=+\([^\\]\|^\)\(\\\\\)*"+
syn match  gapString  +"\(\\\\\)*"+
syn match gapChar +'\\\=.'+ 
syn match gapChar +'\\"'+

" must do
syn keyword gapTodo TODO contained
syn keyword gapTodo XXX contained

" basic infos in file and folded lines
syn match gapFunLine '^#[FVOMPCAW] .*$' contained

syn keyword gapDeclare	DeclareOperation DeclareGlobalFunction 
syn keyword gapDeclare  DeclareGlobalVariable
syn keyword gapDeclare	DeclareAttribute DeclareProperty
syn keyword gapDeclare	DeclareCategory DeclareFilter DeclareCategoryFamily
syn keyword gapDeclare	DeclareRepresentation DeclareInfoClass
syn keyword gapDeclare	DeclareCategoryCollections DeclareSynonym
" the CHEVIE utils
syn keyword gapDeclare  MakeProperty MakeAttribute MakeOperation 
syn keyword gapDeclare  MakeGlobalVariable MakeGlobalFunction

syn keyword gapMethsel	InstallMethod InstallOtherMethod NewType Objectify 
syn keyword gapMethsel	NewFamily InstallTrueMethod
syn keyword gapMethsel  InstallGlobalFunction ObjectifyWithAttributes
syn keyword gapMethsel  BindGlobal BIND_GLOBAL InstallValue
" CHEVIE util
syn keyword gapMethsel  NewMethod

syn keyword gapOperator	and div in mod not or

syn keyword gapFunction	function -> return local end Error 
syn keyword gapConditional	if else elif then fi
syn keyword gapRepeat		do od for while repeat until
syn keyword gapOtherKey         Info Unbind IsBound

syn keyword gapBool         true false fail
syn match  gapNumber		"-\=\<\d\+\>\/"
syn match  gapListDelimiter	"[][]"
syn match  gapParentheses	"[)(]"
syn match  gapSublist	"[}{]"

"hilite
" this is very much dependent on personal taste, the gui* entries are for
" gvim (see below for an alternative to link the layout to predefined
" values, see `:highlight` for an overview of defined names).
" hi gapString ctermfg=2 guifg=Green
" hi gapFunction  ctermfg=1 guifg=Red
" hi gapDeclare  cterm=bold ctermfg=4 guifg=DarkBlue
" hi gapMethsel  ctermfg=6 guifg=Cyan
" hi gapOtherKey  ctermfg=3 guifg=Yellow
" hi gapOperator cterm=bold ctermfg=8 guifg=DarkGray
" hi gapConditional cterm=bold ctermfg=9 guifg=DarkRed
" hi gapRepeat cterm=bold ctermfg=12 guifg=DarkGray
" hi gapComment  ctermfg=4 guifg=Blue
" hi gapTodo  ctermbg=2 ctermfg=0 guibg=Green guifg=Black
" hi link gapTTodoComment  gapTodo 
" hi link gapTodoComment	gapComment
" hi gapNumber ctermfg=5 guifg=Magenta
" hi gapBool ctermfg=5 guifg=Magenta
" hi gapChar ctermfg=3 guifg=Yellow
" hi gapListDelimiter ctermfg=8 guifg=Gray
" hi gapParentheses ctermfg=12 guifg=Blue
" hi gapSublist ctermfg=14 guifg=LightBlue
" hi gapFunLine ctermbg=3 ctermfg=0 guibg=LightBlue guifg=Black
""""  alternatively, comment the `hi ...` lines above and uncomment below
hi link gapString                      String
hi link gapFunction                    Function
hi link gapDeclare                     Define
hi link gapMethsel                     Special
hi link gapOtherKey                    SpecialKey
hi link gapOperator                    Operator
hi link gapConditional                 Conditional
hi link gapRepeat                      Repeat
hi link gapComment                     Comment
hi link gapTodo                        Todo
hi link gapTTodoComment                gapTodo 
hi link gapTodoComment                 gapTodo
hi link gapNumber                      Number
hi link gapBool                        Boolean
hi link gapChar                        Character
hi link gapListDelimiter               Delimiter
hi link gapParentheses                 gapListDelimiter
hi link gapSublist                     gapListDelimiters
hi link gapFunLine                     TabLine

syn sync maxlines=500

" an ex function which returns a `fold level' for line n of the current
" buffer (only used with folding in vim >= 6.0) 
func! GAPFoldLevel(n) 
  " none at top of file
  if (a:n==0)
    return 0
  endif
  let l = getline(a:n)
  let lb = getline(a:n-1)
  " GAPDoc in comment is level 1
  if (l =~ "^##.*<#GAPDoc")
    return 1
  endif
  if (lb =~ "^##.*<#/GAPDoc")
    return 0
  endif
  " recurse inside comment
  if (l =~ "^#" && lb =~ "^#")
    return GAPFoldLevel(a:n-1)
  endif
  " in code one level per 4 blanks indent
  " from previous non-blank line
  let n = a:n
  while (n>1 && getline(n) =~ '^\s*$')
    let n = n - 1
  endwhile
  return (indent(n)+3)/4
endfunc

" enable folding and much better indenting in  vim >= 6.0
if version>=600
  syn sync fromstart
  set foldmethod=expr
  set foldminlines=3
  set foldexpr=GAPFoldLevel(v:lnum)
  hi Folded ctermbg=6 ctermfg=0
  " load the indent file
  runtime indent/gap.vim
endif

let b:current_syntax = "gap"
