" Set up steps ------------------------------------------------------------{{{1
"   git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"   :PluginInstall
"   git clone https://github.com/zivv/UltiSnips.git ~/.vim/UltiSnips
"
" Install YouCompleteMe
"   Make sure cmake, gcc, g++ and python-dev are installed (if need clang)
"     cd ~/.vim/bundle/YouCompleteMe
"     ./install.sh --clang-completer --gocode-completer
" Install different formatprograms for vim-autoformat
"   See https://github.com/Chiel92/vim-autoformat, or README.md
" Install vim-go
"     vim -c "GoInstallBinaries" -c q
" Install fugitive
"     vim -u NONE -c "helptags vim-fugitive/doc" -c q
" Install Taglist
"   Make sure exuberant-ctags is installed
"
" Notes -------------------------------------------------------------------{{{1
"   for Definition/Reference jump:
"     exuberant-ctags & cscope & quickfix & YouCompleteMe & winmanager
"     commands like: C-] C-t <C-\>s [w z;
"
"     See 'conf/vim/files/cscope_maps.vim' for commands of cscope.
"
"     The various YcmCompleter GoTo* subcommands add entries to Vim's jumplist
"     so you can use CTRL-O to jump back to where you where before invoking
"     the command (and CTRL-I to jump forward; see :h jumplist for details).

" Basic paths -------------------------------------------------------------{{{1
if filereadable(expand('~/.vimrc_path'))
  source ~/.vimrc_path
endif


" Basic settings ----------------------------------------------------------{{{1
set tabstop=8
set shiftwidth=2
set softtabstop=2
set expandtab
set textwidth=80

syntax enable

set number  " show line number
set relativenumber  " show relative line number

set ruler  " show line number and column number in bottom right

set encoding=utf-8
set fileencodings=utf-8,gb2312  " gb2312 is windows' default encoding

set foldmethod=marker  " autofold by marker {{{ and }}}

" set different indent setting for certain file type
aug SpecialIndent
  au!
  au BufNewFile *.py set softtabstop=4 | set shiftwidth=4
  au FileType python set softtabstop=4 | set shiftwidth=4
aug END

" skeleton files
aug SkeletonFiles
  au!
  au BufNewFile Makefile 0r ~/.vim/skeletons/Makefile
  au BufNewFile *.tex 0r ~/.vim/skeletons/skeleton.tex
  au BufNewFile py_wrapper.cc 0r ~/.vim/skeletons/py_wrapper.cc
aug END


" Basic custom commands ---------------------------------------------------{{{1
"   Note before adding new mappings, try `:verbose map <key>` to check it

" easy to close highlighting after searching
nn <silent> ;h :nohl<CR>

" easy to open or close spell check
nn <silent> ;p :set spell!<CR>
set spellfile=~/.vim/spell/.vimspelldict.utf-8.add

" easy to copy
nn <silent> ;n :set rnu!<CR>:set nu!<CR>

" switch between .cc / .h / -inl.h / _test.cc / _unittest.cc / .py / .js
let pat = '\(\(_\(unit\)\?test\)\?\.\(c\|cc\|cpp\|js\|py\)\|\(-inl\)\?\.h\)$'
nn <space>c<space> :fin <C-R>=substitute(expand("%"), pat, ".c", "")<CR><CR>
nn <space>cc :fin <C-R>=substitute(expand("%"), pat, ".cc", "")<CR><CR>
nn <space>cp :fin <C-R>=substitute(expand("%"), pat, ".cpp", "")<CR><CR>
nn <space>h  :fin <C-R>=substitute(expand("%"), pat, ".h", "")<CR><CR>
nn <space>i  :fin <C-R>=substitute(expand("%"), pat, "-inl.h", "")<CR><CR>
nn <space>t  :fin <C-R>=substitute(expand("%"), pat, "_test.", "").
      \substitute(expand("%:e"), "h", "cc", "")<CR><CR>
nn <space>u  :fin <C-R>=substitute(expand("%"), pat, "_unittest.", "").
      \substitute(expand("%:e"), "h", "cc", "")<CR><CR>
nn <space>p  :e <C-R>=substitute(expand("%"), pat, ".py", "")<CR><CR>
nn <space>j  :e <C-R>=substitute(expand("%"), pat, ".js", "")<CR><CR>

" move to column 80
nn ;80 079l

" for window size
nn [r :resize 
nn [v :vert resize 

" specific for quickfix window
nn <silent> [w :cw<CR>
nn <silent> [n :cn<CR>
nn <silent> [p :cp<CR>

" just avoid plugins' mapping with default key \
let mapleader = ","
" keep the default behavior of key ; to other key
nn <silent> \ ;
" convenient use of pair \ and |
nn <silent> <bar> ,

" quit all files without saving
nn <silent> ;qa :qa!<CR>
" quit current file without saving
nn <silent> ;qq :q!<CR>
" close all windows but current without saving
nn <silent> ;qo :only!<CR>
" saving
nn ;w :w<CR>
" forced saving
nn ;fw :w!<CR>
" edit
nn ;e :e 
" tab edit
nn ;t :tabe 
" switch between tabs
nn ;i :tabp<CR>
nn ;o :tabn<CR>

" get out of insert mode
ino jk <Esc>


" Vundle -- manage Vim plugins --------------------------------------------{{{1
"        -- https://github.com/gmarik/vundle#readme

set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

Plugin 'gmarik/Vundle.vim'


" Examples of adding scripts from different repos
"   scripts on GitHub repos
"     eg. Plugin 'gmarik/vundle' for http://github.com/gmarik/vundle
"   scripts from http://vim-scripts.org/vim/scripts.html
"     eg. Plugin 'L9'
"   scripts not on GitHub
"     eg. Plugin 'git://git.wincent.com/command-t.git'
"   git repos on your local machine (i.e. when working on your own plugin)
"     eg. Plugin 'file:///home/gmarik/path/to/plugin'


" UltiSnips -- The ultimate solution for snippets in Vim ------------------{{{2
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


" YCM -- code completion engine -------------------------------------------{{{2
"     -- require vim 7.3.584+
"   Install:
"     cd ~/.vim/bundle/YouCompleteMe
"     ./install.sh --clang-completer --gocode-completer
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
" jump to the header/definition/declaration
nn <silent> z; :YcmCompleter GoTo<CR>
" Echos the semantic parent of the point under the cursor.
nn <silent> ze :YcmCompleter GetType<CR>
" View documentation comments for identifiers
nn <silent> zh :YcmCompleter GetDoc<CR>
" Attempts to correct the diagnostic closest to the cursor position.
nn <silent> zl :YcmCompleter FixIt<CR>
" refresh the diagnostics
nn <silent> <F5> :YcmForceCompileAndDiagnostics<CR>


" vim-autoformat -- format code with one button press ---------------------{{{2
"   See README.md for the list of default formatprograms
Plugin 'Chiel92/vim-autoformat'

" vim-autoformat settings
" only change the style option to Google
" default style is a complex dict, see vim-autoformat/plugin/defaults.vim
let g:formatdef_clangformat = "'clang-format ".
      \"-lines='.a:firstline.':'.a:lastline.' ".
      \"--assume-filename='.bufname('%').' -style=google'"
" default style is 'ansi'
let g:formatdef_astyle_cs   = '"astyle --mode=cs   --style=google '.
      \'--indent-namespaces -pcH".(&expandtab ? "s".shiftwidth() : "t")'
let g:formatdef_astyle_c    = '"astyle --mode=c    --style=google '.
      \'-pcH".(&expandtab ? "s".shiftwidth() : "t")'
let g:formatdef_astyle_cpp  = '"astyle --mode=c    --style=google '.
      \'-pcH".(&expandtab ? "s".shiftwidth() : "t")'
let g:formatdef_astyle_java = '"astyle --mode=java --style=google '.
      \'-pcH".(&expandtab ? "s".shiftwidth() : "t")'

" Shortcuts for vim-autoformat commands
" for Normal, Visual, Select, Operator-pending modes
map <silent> <C-j> :Autoformat<CR>

Plugin 'scrooloose/nerdcommenter'


" vim-go -- Go (golang) support for Vim -----------------------------------{{{2
"   Install: `vim -c "GoInstallBinaries" -c q`
Plugin 'fatih/vim-go'

" Shortcuts for vim-go commands
aug GoShortcuts
  au!
  " Open the target identifier in current buffer
  " By default the mapping gd is enabled
  " For consistency of the same shortcut with YCM
  au FileType go nn z; <Plug>(go-def)
  " go run/build/test for the current package
  au FileType go nn gr <Plug>(go-run)
  au FileType go nn gb <Plug>(go-build)
  au FileType go nn gt <Plug>(go-test)
  " Display beautifully annotated source code to see which functions are covered
  au FileType go nn gc <Plug>(go-coverage)
  " Open the relevant Godoc for the word under the cursor
  " For consistency of the same shortcut with YCM
  au FileType go nn zh <Plug>(go-doc)
  " Rename the identifier under the cursor to a new name
  au FileType go nn ge <Plug>(go-rename)
aug END

" vim-go settings
" By default when :GoInstallBinaries is called,
" the binaries are installed to $GOBIN or $GOPATH/bin. To change it:
let g:go_bin_path = expand("~/.gotools")
" By default syntax-highlighting for Functions, Methods and Structs is
" disabled. To change it:
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
" Enable goimports to automatically insert import paths instead of gofmt:
let g:go_fmt_command = "goimports"

Plugin 'majutsushi/tagbar'


" fugitive -- a Git wrapper -----------------------------------------------{{{2
"   Install: `vim -u NONE -c "helptags vim-fugitive/doc" -c q`
Plugin 'tpope/vim-fugitive'

" Shortcuts for fugitive commands
" `g?` to see help after `Gs`
nn <silent> Gs :Gstatus<CR>
nn <silent> Ga :Git add . -A<CR>
nn <silent> Gl :Gpull<CR>
nn <silent> Gu :Gpush<CR>


" Solarized -- Precision colors for machines and people -------------------{{{2
"   Note that if need to add Solarized osx terminal profiles, see
"     folder 'osx-terminal.app-colors-solarized'
"     under 'https://github.com/altercation/solarized/'
Plugin 'altercation/vim-colors-solarized'

" Required settings
" dark or light background mode
set background=dark
" For mac, must set terminal as 'xterm-256color' in preference
let g:solarized_termcolors=256
colorscheme solarized


" Basic color settings ----------------------------------------------------{{{2
set cursorline
hi CursorLine cterm=none ctermbg=235
set cursorcolumn
hi CursorColumn cterm=none ctermbg=235

set hlsearch " highlight when search
hi Search cterm=none ctermfg=grey ctermbg=darkyellow

" show trailing whithspace
hi TrailingWhitespace ctermbg=darkgreen
match TrailingWhitespace /\s\+$/

" highlight TODO
hi TODOs ctermfg=white ctermbg=darkgreen
2match TODOs /TODO:\|TODO(.*):/

" Google-logo \o/
hi default googleBlue ctermfg=blue guifg=blue
hi default googleRed ctermfg=red guifg=red
hi default googleYellow ctermfg=yellow guifg=yellow
hi default googleGreen ctermfg=green guifg=green
syntax match googleBlue /[Gg]\(oogle\)\@=/ containedin=ALL display
syntax match googleRed /\([Gg]\)\@<=o\(ogle\)\@=/ containedin=ALL display
syntax match googleYellow /\([Gg]o\)\@<=o\(gle\)\@=/ containedin=ALL display
syntax match googleBlue /\([Gg]oo\)\@<=g\(le\)\@=/ containedin=ALL display
syntax match googleGreen /\([Gg]oog\)\@<=l\(e\)\@=/ containedin=ALL display
syntax match googleRed /\([Gg]oogl\)\@<=e/ containedin=ALL display


" taglist.vim -- Source code browser --------------------------------------{{{2
"             -- http://www.vim.org/scripts/script.php?script_id=273
Plugin 'taglist.vim'


" winmanager -- A windows style IDE for Vim 6.0 ---------------------------{{{2
"            -- http://vim.sourceforge.net/scripts/script.php?script_id=95
Plugin 'winmanager'
" use <C-n> and <C-p> to switch between explorers in same group
let g:winManagerWindowLayout='FileExplorer,TagList'
nn <silent> ;wm :WMToggle<cr>


" Specific settings -------------------------------------------------------{{{1
source ~/.vim/files/cscope_maps.vim


" Local settings ----------------------------------------------------------{{{1
if filereadable(expand('~/.vimrc_local'))
  source ~/.vimrc_local
endif


" Enable all the plugins
filetype plugin indent on
