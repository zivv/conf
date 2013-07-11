set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" original repos on github
Bundle 'davidhalter/jedi-vim'
Bundle 'Rip-Rip/clang_complete'
Bundle 'derekwyatt/scala'
Bundle 'digitaltoad/vim-jade'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
" vim-scripts repos
" non github repos
" git repos on your local machine (ie. when working on your own plugin)

filetype plugin indent on

set hlsearch
set nu
set si

nn <silent> zz zz:nohl<cr>
