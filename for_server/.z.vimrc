" To setup:
" echo -e 'if filereadable(expand('\''~/.z.vimrc'\''))\n  source ~/.z.vimrc\nendif' >> .vimrc

syntax enable

set number  " show line number
set relativenumber  " show relative line number

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
nn <silent> [r :resize +5<CR>
nn <silent> [v :vert resize +5<CR>

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

" quit current file without saving
nn <silent> ;q :q!<CR>
" quit all files without saving
nn <silent> ;a :qa!<CR>
" close all windows but current without saving
nn <silent> ;l :only!<CR>
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
" switch between windows
nn ;u <C-W><C-W>

" get out of insert mode
ino jk <Esc>

" delete trailing whithspace
nn <silent> ds :%s#\s\+$##g<CR>

" always use zM instead of zm
nn zm zM
nn zr zR

" Redos since 'u' undos
nn U :redo<CR>

nn H ^
nn L g_

" Undo
ino <C-l> <C-o>u

" Delete current character
ino <C-x> <C-o>x

" Go to begin of line
ino <C-w> <Esc>I
" Go to end of line
ino <C-e> <Esc>A
" Move cursor
ino <C-o> <Down>
ino <C-p> <Up>
ino <C-r> <Left>
ino <C-t> <Right>
" Move a word forward/backward
ino <C-f> <C-o>b
ino <C-g> <C-o>w

" Yank to system clipboard
vn ;y "*y
" Paste the contents in system clipboard
nn ;p "*p
nn ;P "*P

"" Powerline
""   Check `vim --version | grep +python` first
"python3 from powerline.vim import setup as powerline_setup
"python3 powerline_setup()
"python3 del powerline_setup
"" Always display the statusline in all windows
"set laststatus=2
"" Always display the tabline, even if there is only one tab
"set showtabline=2
"" Hide the default mode text (e.g. -- INSERT -- below the statusline)
"set noshowmode
