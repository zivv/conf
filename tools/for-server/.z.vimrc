set tabstop=8
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
" Disable auto-insert line breaks.
set textwidth=0

" Show line number.
set number
" Show relative line number.
set relativenumber

set encoding=utf-8
" gb2312 is windows' default encoding.
set fileencodings=utf-8,gb2312

" Command-line completion operates in an enhanced mode.
set wildmenu

" Default fold method.
set foldmethod=indent
" Initially, no closed fold.
set foldlevelstart=99
" Special fold method, by marker {{{ and }}}
aug FoldMarker
  au!
  au FileType vim,conf set foldmethod=marker | set foldlevel=0
aug END

" Display unprintable chars.
set list
set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣
"set showbreak=↪

" Jump to the first open tab that contains the specified buffer.
" Open a new tab page before loading a buffer for a quickfix command.
set switchbuf=usetab,newtab

" In Insert mode, allow backspacing over autoindent/line breaks/the start of
" insert. See `:h 'bs'`.
set backspace=indent,eol,start


python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
" Always display the statusline in all windows.
set laststatus=2
" Always display the tabline, even if there is only one tab.
set showtabline=2
" Hide the default mode text (e.g. -- INSERT -- below the statusline).
set noshowmode


set cursorline
hi CursorLine cterm=none ctermbg=237
set cursorcolumn
hi CursorColumn cterm=none ctermbg=237

" Highlight during search.
set hlsearch
hi Search cterm=none ctermfg=grey ctermbg=darkyellow

" Syntax highlight rules for all files.
aug ZSyntaxHighlight
  au!
  " Show trailing whithspace.
  hi TrailingWhitespace ctermbg=22
  au BufWinEnter * call matchadd('TrailingWhitespace', '\s\+$')

  " Highlight TODO, FIXME, REVIEW, NOTE, XXX(for tricks).
  " Valid format: TODO, TODO:, TODO(ziv), TODO(ziv):
  hi TODOs ctermfg=white ctermbg=33
  au BufWinEnter * call matchadd('TODOs', '\<TODO(.\{-}):\?\|\<TODO:\?')
  hi FIXMEs ctermfg=white ctermbg=196
  au BufWinEnter * call matchadd('FIXMEs', '\<FIXME(.\{-}):\?\|\<FIXME:\?')
  hi REVIEWs ctermfg=white ctermbg=208
  au BufWinEnter * call matchadd('REVIEWs', '\<REVIEW(.\{-}):\?\|\<REVIEW:\?')
  hi NOTEs ctermfg=white ctermbg=112
  au BufWinEnter * call matchadd('NOTEs', '\<NOTE(.\{-}):\?\|\<NOTE:\?')
  hi XXXs ctermfg=white ctermbg=99
  au BufWinEnter * call matchadd('XXXs', '\<XXX(.\{-}):\?\|\<XXX:\?')

  " Google-logo \o/
  hi googleBlue ctermfg=27
  hi googleRed ctermfg=160
  hi googleYellow ctermfg=214
  hi googleGreen ctermfg=34
  au BufWinEnter * call matchadd('googleBlue', '[Gg]\(oogle\)\@=')
  au BufWinEnter * call matchadd('googleRed', '\([Gg]\)\@<=o\(ogle\)\@=')
  au BufWinEnter * call matchadd('googleYellow', '\([Gg]o\)\@<=o\(gle\)\@=')
  au BufWinEnter * call matchadd('googleBlue', '\([Gg]oo\)\@<=g\(le\)\@=')
  au BufWinEnter * call matchadd('googleGreen', '\([Gg]oog\)\@<=l\(e\)\@=')
  au BufWinEnter * call matchadd('googleRed', '\([Gg]oogl\)\@<=e')
aug END


" Easy to close highlighting after searching.
nn <silent> ;h :nohl<CR>

" Easy to copy.
nn <silent> ;n :set rnu!<CR>:set nu!<CR>

" Move to column 80.
nn ;80 079l

" Quit current file without saving.
nn <silent> ;q :q!<CR>
" Quit all files without saving.
nn <silent> ;a :qa!<CR>
" Make the current window the only one on the screen, without saving.
nn <silent> ;l :only!<CR>:NERDTreeTabsClose<CR>
" Forced saving.
nn ;w :w!<CR>
" Edit file, empty for reading current file from disk again.
nn ;e :e 
" Edit file in a new tab.
nn ;t :tabe 
" Switch between tabs.
" {count}gT - Go {count} tab pages back.
nn ;i gT
" {count}gt - Go to tab page {count}.
nn ;o gt
" Switch between windows.
" {count};u - Go to {count}th window (when larger then # of wins, go to last).
nn ;u <C-W><C-W>

" Get out of insert mode.
" 'jk' is a good cmd for exiting insert mode but not good for virtual.
no! ;l <Esc>
" Get out of virtual mode.
vn ;l <Esc>

" Redo since key `u` for undos.
nn U :redo<CR>

" Go to the start/end of the current line.
no H ^
no L g_

" Check `vim --version | grep clipboard` or `:echo has("clipboard")`.
" Yank to system clipboard.
vn ;y "+y
" Paste the contents in system clipboard.
nn ;p "+p
nn ;P "+P
vn ;p "+p
vn ;P "+P

" Substitute for all lines.
nn ;s :%s/
" Substitute for selected lines.
vn ;s :s/

" Open file under cursor in a new tab, see `:h CTRL-W_gf`.
nn gf <C-w>gf
