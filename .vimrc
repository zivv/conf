" Basic settings ----------------------------------------------------------{{{1
nn <silent> zz zz:nohl<cr>
nm <silent> zp :set spell!<cr>
set spellfile=~/.vim/spell/.vimspelldict.utf-8.add


" Vundle -- manage Vim plugins --------------------------------------------{{{1
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" Plugins -----------------------------------------------------------------{{{2
" original repos on github

" for snippets
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'

" YCM
if filereadable(expand('~/.at_google'))
  " Google-only
else
  " Non-Google only
  Bundle 'Valloric/YouCompleteMe'
endif

" vim-scripts repos

" non github repos

" git repos on your local machine (ie. when working on your own plugin)

filetype plugin indent on     " required! for vindle


" Snippets ----------------------------------------------------------------{{{1
let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['cpp'] = 'cpp,c,common'
let g:snipMate.scope_aliases['python'] = 'python,common'


" YCM ---------------------------------------------------------------------{{{1
" default is ['<TAB>', '<Down>'], and '<TAB>' will conflict with snippets
let g:ycm_key_list_select_completion = ['<Down>, <C-n>']
" default is ['<S-TAB>', '<Up>']
let g:ycm_key_list_previous_completion = ['<Up>, <C-p>']



" Local settings ----------------------------------------------------------{{{1
if filereadable(expand('~/.vimrc_local'))
  source ~/.vimrc_local
endif
