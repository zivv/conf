" setting
set hlsearch
set nu
set ts=4
set softtabstop=4
set shiftwidth=4
set expandtab
set si

" command
nn <silent> zz zz:nohl<cr>

" for vundle
set nocompatible               " be iMproved
filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
" original repos on github
Bundle 'davidhalter/jedi-vim'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
" vim-scripts repos
" non github repos
" git repos on your local machine (ie. when working on your own plugin)
filetype plugin indent on     " required!

" for snippets
let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['cpp'] = 'cpp,c,common'
let g:snipMate.scope_aliases['python'] = 'python,common'
