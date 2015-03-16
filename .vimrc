" set up steps:
"   git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"   :PluginInstall
"   git clone https://github.com/zivv/UltiSnips.git ~/.vim/UltiSnips
"
" Install YouCompleteMe
"   Make sure cmake, gcc, g++ and python-dev are installed (if need clang)
"     cd ~/.vim/bundle/YouCompleteMe && ./install.sh --clang-completer
" Install fugitive
"     vim -u NONE -c "helptags vim-fugitive/doc" -c q
" Install Taglist
"   Make sure exuberant-ctags is installed
"
" Notes:
"   for Definition/Reference jump:
"     exuberant-ctags & cscope & quickfix & YouCompleteMe & winmanager
"     commands like: C-] C-t <C-\>s [w z]
"     See 'conf/vim/files/cscope_maps.vim' for commands of cscope.

" Basic paths -------------------------------------------------------------{{{1
if filereadable(expand('~/.vimrc_path'))
  source ~/.vimrc_path
endif


" Basic settings ----------------------------------------------------------{{{1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set textwidth=79

syntax enable

set number " show line number
set relativenumber " show relative line number

set ruler " show line number and column number in bottom right

set encoding=utf-8
set fileencodings=utf-8,gb2312 " gb2312 is windows' default encoding

" set different indent setting for certain file type
au BufNewFile *.py set softtabstop=4 | set shiftwidth=4
au FileType python set softtabstop=4 | set shiftwidth=4

au BufNewFile Makefile 0r ~/.vim/skeletons/Makefile
au BufNewFile *.tex 0r ~/.vim/skeletons/skeleton.tex
au BufNewFile py_wrapper.cc 0r ~/.vim/skeletons/py_wrapper.cc


" Basic custom commands ---------------------------------------------------{{{1
nn <silent> ;h :nohl<CR>

nm <silent> ;p :set spell!<CR>
set spellfile=~/.vim/spell/.vimspelldict.utf-8.add

" easy to copy
nm <silent> ;n :set rnu!<CR>:set nu!<CR>

" switch between .h / -inl.h / .cc / .py / .js / _test.* / _unittest.*
" TODO(ziv): understand and update it
let pattern = '\(\(_\(unit\)\?test\)\?\.\(c\|cc\|cpp\|js\|py\)\|\(-inl\)\?\.h\)$'
nm ,c :fin <C-R>=substitute(expand("%"), pattern, ".c", "")<CR><CR>
nm ,cc :fin <C-R>=substitute(expand("%"), pattern, ".cc", "")<CR><CR>
nm ,cp :fin <C-R>=substitute(expand("%"), pattern, ".cpp", "")<CR><CR>
nm ,h :fin <C-R>=substitute(expand("%"), pattern, ".h", "")<CR><CR>
nm ,i :fin <C-R>=substitute(expand("%"), pattern, "-inl.h", "")<CR><CR>
nm ,t :fin <C-R>=substitute(expand("%"), pattern, "_test.", "").substitute(expand("%:e"), "h", "cc", "")<CR><CR>
" nm ,u :fin <C-R>=substitute(expand("%"), pattern, "_unittest.", "").substitute(expand("%:e"), "h", "cc", "")<CR><CR>
" nm ,p :e <C-R>=substitute(expand("%"), pattern, ".py", "")<CR><CR>
" nm ,j :e <C-R>=substitute(expand("%"), pattern, ".js", "")<CR><CR>

" move to column 80
nm ;80 079l

" delete the comment, in current line
" TODO(ziv): collect the comment leading character and then update this
nm <silent> dc :.s#[ ]*[#"] .*$\\|[ ]*// .*$##g<CR>;h

" delete the extra spaces, in current line
" TODO(ziv): update to could be used for a selected block
nm <silent> ds :.s/[ \t]*$//g<CR>;h

" for window size
nm [r :resize 
nm [v :vert resize 

" specific for quickfix window
nm <silent> [w :cw<CR>
nm <silent> [n :cn<CR>
nm <silent> [p :cp<CR>

" quit all files without saving
nm <silent> ;aq :qa!<CR>
" quit current file without saving
nm <silent> ;q :q!<CR>
" saving
nm ;w :w<CR>
" forced saving
nm ;fw :w!<CR>
" edit
nm ;e :e 
" tab edit
nm ;t :tabe 
" switch between tabs
nm ;i :tabp<CR>
nm ;o :tabn<CR>

" get out of insert mode
ino jk <Esc>


" Vundle -- manage Vim plugins --------------------------------------------{{{1
"        -- https://github.com/gmarik/vundle#readme

set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

Plugin 'gmarik/Vundle.vim'


" Plugins -----------------------------------------------------------------{{{2

" scripts on GitHub repos -----------------------------------------------------
"   eg. Plugin 'gmarik/vundle' for http://github.com/gmarik/vundle

" UltiSnips -- The ultimate solution for snippets in Vim ------------------{{{3
Plugin 'SirVer/ultisnips'

" UltiSnips settings
" default is <Tab>, better to be different with JumpForward key
let g:UltiSnipsExpandTrigger = "<C-h>"
" default is <C-Tab>, no need to worry about since using 'honza/vim-snippets'
"let g:UltiSnipsListSnippets = "<C-Tab>"
" default is <C-j>
"let g:UltiSnipsJumpForwardTrigger = "<Tab>"
" default is <C-k>
"let g:UltiSnipsJumpBackwardTrigger = "<C-Tab>"

" Snipmate & UltiSnip Snippets -- for UltiSnips
"   seems support <C-p>(or <Tab>) & <C-n> to choose trigger
Plugin 'honza/vim-snippets'

" YCM -- code completion engine -------------------------------------------{{{3
"     -- require vim 7.3.584+
"   Install: `cd ~/.vim/bundle/YouCompleteMe && ./install.sh --clang-completer`
" TODO(ziv): learn how to work with CMake
if filereadable(expand('~/.at_google'))
  " Google-only
else
  " Non-Google only
  Plugin 'Valloric/YouCompleteMe'
endif

" YCM settings
" default is ['<TAB>', '<Down>']
"let g:ycm_key_list_select_completion = ['<Down>']
" default is ['<S-TAB>', '<Up>']
"let g:ycm_key_list_previous_completion = ['<Up>']
" Global conf file, see YCM's own .ycm_extra_conf.py:
"   https://github.com/Valloric/ycmd/blob/master/cpp/ycm/.ycm_extra_conf.py
let g:ycm_global_ycm_extra_conf = '~/.vim/files/.ycm_extra_conf.py'

" Shortcuts for YCM commands
" jump to definition or declaration
nm <silent> z] :YcmCompleter GoTo<CR>

" fugitive -- a Git wrapper -----------------------------------------------{{{3
"   Install: `vim -u NONE -c "helptags vim-fugitive/doc" -c q`
Plugin 'tpope/vim-fugitive'

" Shortcuts for fugitive commands
nm <silent> Gs :Gstatus<CR>
nm <silent> Ga :Git add . -A<CR>
nm <silent> Gl :Gpull<CR>
nm <silent> Gu :Gpush<CR>

" Solarized -- Precision colors for machines and people -------------------{{{3
"   Note that if need to add Solarized osx terminal profiles, see
"     folder 'osx-terminal.app-colors-solarized'
"     under 'https://github.com/altercation/solarized/'
Plugin 'altercation/vim-colors-solarized'

set background=dark
" For mac, must set terminal as 'xterm-256color' in preference
let g:solarized_termcolors=256
colorscheme solarized

" Basic color settings --------------------------------------------------------
set cursorline
hi CursorLine cterm=none ctermbg=235
set cursorcolumn
hi CursorColumn cterm=none ctermbg=235

set hlsearch " highlight when search
hi Search cterm=none ctermfg=grey ctermbg=darkyellow

" show trailing whithspace
hi ExtraWhitespace ctermbg=darkgreen
match ExtraWhitespace /\s\+$/

" Required settings
" dark or light background mode

" Not widely used
" Plugin "derekwyatt/scala"
" Plugin "digitaltoad/vim-jade"

" scripts from http://vim-scripts.org/vim/scripts.html ------------------------
"   eg. Plugin 'L9'

" taglist.vim -- Source code browser --------------------------------------{{{3
"             -- http://www.vim.org/scripts/script.php?script_id=273
Plugin 'taglist.vim'

" winmanager -- A windows style IDE for Vim 6.0 ---------------------------{{{3
"            -- http://vim.sourceforge.net/scripts/script.php?script_id=95
Plugin 'winmanager'
" use <C-n> and <C-p> to switch between explorers in same group
let g:winManagerWindowLayout='FileExplorer,TagList'
nm <silent> ;wm :WMToggle<cr>

" scripts not on GitHub -------------------------------------------------------
"   eg. Plugin 'git://git.wincent.com/command-t.git'

" git repos on your local machine (i.e. when working on your own plugin) ------
"   eg. Plugin 'file:///home/gmarik/path/to/plugin'


" Specific settings -------------------------------------------------------{{{1
source ~/.vim/files/cscope_maps.vim


" Local settings ----------------------------------------------------------{{{1
if filereadable(expand('~/.vimrc_local'))
  source ~/.vimrc_local
endif


" Enable all the plugins
filetype plugin indent on
