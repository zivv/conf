" Basic settings ----------------------------------------------------------{{{1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set cursorline
hi CursorLine cterm=none ctermbg=darkgrey
set cursorcolumn
hi CursorColumn cterm=none ctermbg=darkgrey

set number " show line number

set hlsearch " highlight when search

set ruler " show line number and column number in bottom right


" Basic custom commands ---------------------------------------------------{{{1
nn <silent> zz zz:nohl<cr>

nm <silent> zp :set spell!<cr>
set spellfile=~/.vim/spell/.vimspelldict.utf-8.add

" easy to copy
nm <silent> zn :set nu!<cr>

nm <C-h> <C-w>h
nm <C-j> <C-w>j
nm <C-k> <C-w>k
nm <C-l> <C-w>l

" switch between .h / -inl.h / .cc / .py / .js / _test.* / _unittest.*
let pattern = '\(\(_\(unit\)\?test\)\?\.\(cc\|js\|py\)\|\(-inl\)\?\.h\)$'
nm ,c :fin <C-R>=substitute(expand("%"), pattern, ".cc", "")<CR><CR>
nm ,h :fin <C-R>=substitute(expand("%"), pattern, ".h", "")<CR><CR>
nm ,i :fin <C-R>=substitute(expand("%"), pattern, "-inl.h", "")<CR><CR>
nm ,t :fin <C-R>=substitute(expand("%"), pattern, "_test.", "") . substitute(expand("%:e"), "h", "cc", "")<CR><CR>
nm ,u :fin <C-R>=substitute(expand("%"), pattern, "_unittest.", "") . substitute(expand("%:e"), "h", "cc", "")<CR><CR>
" nm ,p :e <C-R>=substitute(expand("%"), pattern, ".py", "")<CR><CR>
" nm ,j :e <C-R>=substitute(expand("%"), pattern, ".js", "")<CR><CR>

" Vundle -- manage Vim plugins --------------------------------------------{{{1
"        -- https://github.com/gmarik/vundle#readme
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'


" Plugins -----------------------------------------------------------------{{{2
" original repos on github

" SnipMate
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
" SnipMate settings
let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['cpp'] = 'cpp,c,common'
let g:snipMate.scope_aliases['python'] = 'python,common'

" YCM
"     -- require vim 7.3.584+
if filereadable(expand('~/.at_google'))
  " Google-only
else
  " Non-Google only
  Bundle 'Valloric/YouCompleteMe'
endif
" YCM settings
" default is ['<TAB>', '<Down>'], and '<TAB>' will conflict with snippets
let g:ycm_key_list_select_completion = ['<Down>, <C-n>']
" default is ['<S-TAB>', '<Up>']
let g:ycm_key_list_previous_completion = ['<Up>, <C-p>']

" Not widely used
" Bundle "derekwyatt/scala"
" Bundle "digitaltoad/vim-jade"

" vim-scripts repos

" non github repos

" git repos on your local machine (ie. when working on your own plugin)

filetype plugin indent on     " required! for vindle



" Local settings ----------------------------------------------------------{{{1
if filereadable(expand('~/.vimrc_local'))
  source ~/.vimrc_local
endif
