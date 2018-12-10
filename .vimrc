" Set up steps ------------------------------------------------------------{{{1
"
" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" vim -c "PluginInstall" -c q
" git clone https://github.com/zivv/UltiSnips.git ~/.vim/UltiSnips
"
" Install https://github.com/Valloric/YouCompleteMe
"   # Completer options for install.py
"   #   --clang-completer (need cmake, gcc, g++ and python-dev)
"   #   --gocode-completer
"   cd ~/.vim/bundle/YouCompleteMe && ./install.py --clang-completer
" Install https://github.com/Chiel92/vim-autoformat
"   brew install clang-format autopep8
"   # js-beautify for Javascript and JSON or
"   # html-beautify for HTML or css-beautify for CSS.
"   # See https://github.com/einars/js-beautify.
"   npm install -g js-beautify
"   # remark for Markdown. A Javascript based markdown processor.
"   # See https://github.com/wooorm/remark.
"   npm install -g remark-cli
"   # shfmt for Shell. A shell formatter written in Go supporting POSIX Shell.
"   # See https://github.com/mvdan/sh.
"   go get -u mvdan.cc/sh/cmd/shfmt
"   # buildifier for bazel BUILD files.
"   # See https://github.com/bazelbuild/buildtools/tree/master/buildifier.
"   go get github.com/bazelbuild/buildtools/buildifier
" Install https://github.com/majutsushi/tagbar
"   Depend exuberant-ctags
" Install https://github.com/tpope/vim-fugitive
"   vim -c "helptags ~/.vim/bundle/vim-fugitive/doc" -c q
" Install https://github.com/fatih/vim-go
"   vim -c "GoInstallBinaries" -c q
"
"
" Notes -------------------------------------------------------------------{{{1
"   For Definition/Reference jump:
"     exuberant-ctags & cscope & quickfix & YouCompleteMe
"     commands like: C-] C-t <C-\>s [w ;j
"
"     See '~/conf/vim/files/cscope_maps.vim' for commands of cscope.
"     Normally just build cscope.out by run `cscope -Rbkq`.
"     Put 'let $CSCOPE_DB = CSCOPE_OUT_FILE' in .vim_env if necessary.
"
"     The various YcmCompleter GoTo* subcommands add entries to Vim's jumplist
"     so you can use CTRL-O to jump back to where you where before invoking
"     the command (and CTRL-I to jump forward; see :h jumplist for details).
"
"   Could find unused key like:
"     for i in {a..z};do;if ! grep \;$i ~/.vimrc>/dev/null;then;echo $i;fi;done


" Basic environment and setting -------------------------------------------{{{1
if filereadable(expand('~/.vim_env'))
  source ~/.vim_env
endif

syntax enable


" Vundle -- manage Vim plugins --------------------------------------------{{{1
"        -- https://github.com/gmarik/Vundle.vim

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
"           -- https://github.com/SirVer/ultisnips
Plugin 'SirVer/ultisnips'

" UltiSnips settings
" Default value is <Tab>.
let g:UltiSnipsExpandTrigger = "<C-j>"
" Default value is <C-Tab>.
"let g:UltiSnipsListSnippets = "<C-Tab>"
" Default value is <C-j>.
"let g:UltiSnipsJumpForwardTrigger = "<Tab>"
" Default value is <C-k>.
"let g:UltiSnipsJumpBackwardTrigger = "<C-Tab>"

" Snipmate & UltiSnip Snippets -- for UltiSnips
"   https://github.com/honza/vim-snippets
"   Seems support <C-p>(or <Tab>) & <C-n> to choose trigger.
Plugin 'honza/vim-snippets'


" vim-multiple-cursors -- True Sublime Text style multiple selections -----{{{2
"                      -- https://github.com/terryma/vim-multiple-cursors
" TODO(ziv): g:multi_cursor_quit_key & g:multi_cursor_normal_maps not working
Plugin 'terryma/vim-multiple-cursors'


" YCM -- code completion engine -------------------------------------------{{{2
"     -- require vim 7.3.584+
"     -- https://github.com/Valloric/YouCompleteMe
if filereadable(expand('~/.at_google'))
  " Google-only
else
  " Non-Google only
  Plugin 'Valloric/YouCompleteMe'
endif

" YCM settings
" Default value is ['<TAB>', '<Down>'].
"let g:ycm_key_list_select_completion = ['<Down>']
" Default value is ['<S-TAB>', '<Up>'].
"let g:ycm_key_list_previous_completion = ['<Up>']
" Default value is 'same-buffer', could also be 'horizontal-split' or 'vertical-split'.
let g:ycm_goto_buffer_command = 'new-or-existing-tab'
" Global conf file, see YCM's own .ycm_extra_conf.py:
"   https://github.com/Valloric/ycmd/blob/master/cpp/ycm/.ycm_extra_conf.py
let g:ycm_global_ycm_extra_conf = '~/.vim/files/.ycm_extra_conf.py'
" YCM will automatically found '.ycm_extra_conf.py' file in path and ask if it
" is safe to be loaded. To selectively get YCM to ask/not ask about loading
" files, put the following line to '.vim_local' and add rules to it.
"let g:ycm_extra_conf_globlist = []

" Shortcuts for YCM commands
" Jump to the header/definition/declaration.
nn <silent> ;j :YcmCompleter GoTo<CR>
" Echos the semantic parent of the point under the cursor.
nn <silent> ;v :YcmCompleter GetType<CR>
" View documentation comments for identifiers.
nn <silent> ;d :YcmCompleter GetDoc<CR>
" Attempts to correct the diagnostic closest to the cursor position.
nn <silent> ;x :YcmCompleter FixIt<CR>
" Refresh the diagnostics.
nn <silent> ;c :YcmForceCompileAndDiagnostics<CR>


" vim-autoformat -- format code with one button press ---------------------{{{2
"                -- https://github.com/Chiel92/vim-autoformat
Plugin 'Chiel92/vim-autoformat'

" vim-autoformat settings
" See ~/.vim/bundle/vim-autoformat/plugin/defaults.vim.
" Only change the style option to Google.
let g:formatdef_clangformat = "'clang-format ".
      \"-lines='.a:firstline.':'.a:lastline.' ".
      \"--assume-filename=\"'.expand('%:p').'\" ".
      \"-style=\"{BasedOnStyle: Google, ".
      \"          BinPackArguments: false, BinPackParameters: false, ".
      \"          DerivePointerAlignment: false, PointerAlignment: Left}\"'"
" Default style is 'ansi'.
" TODO(ziv): Consider if change to use .astylerc conf file.
let g:formatdef_astyle_cs   = '"astyle --mode=cs   --style=google '.
      \'--indent-namespaces -pcH".(&expandtab ? "s".shiftwidth() : "t")'
let g:formatdef_astyle_c    = '"astyle --mode=c    --style=google '.
      \'-pcH".(&expandtab ? "s".shiftwidth() : "t")'
let g:formatdef_astyle_cpp  = '"astyle --mode=c    --style=google '.
      \'-pcH".(&expandtab ? "s".shiftwidth() : "t")'
let g:formatdef_astyle_java = '"astyle --mode=java --style=google '.
      \'-pcH".(&expandtab ? "s".shiftwidth() : "t")'
" Add formatter for bazel BUILD files.
" See https://github.com/bazelbuild/buildtools/tree/master/buildifier.
let g:formatters_bzl = ['buildifier']
let g:formatdef_buildifier = '"buildifier"'
" Change the order of formatters for json to use fixjson at first.
let g:formatters_json = ['fixjson', 'jsbeautify_json', 'prettier']

" Shortcuts for vim-autoformat commands
" For Normal, Visual, Select, Operator-pending modes.
map <silent> <C-k> :Autoformat<CR>


" Tagbar -- a class outline viewer for Vim --------------------------------{{{2
"        -- https://github.com/majutsushi/tagbar
Plugin 'majutsushi/tagbar'

" Shortcuts for Tagbar commands
nn <silent> ;k :TagbarToggle<CR>


" nerdcommenter -- Vim plugin for intensely orgasmic commenting -----------{{{2
"               -- https://github.com/scrooloose/nerdcommenter
"   Useful keys like: `,cl` `,cu`
Plugin 'scrooloose/nerdcommenter'

" nerdcommenter settings
let g:NERDBlockComIgnoreEmpty = 0
let g:NERDCommentWholeLinesInVMode = 1
let g:NERDSpaceDelims = 1
" default python-left is '# '
let g:NERDCustomDelimiters = {
      \ 'python': { 'left': '#' },
      \ }


" startify -- The fancy start screen for Vim ------------------------------{{{2
"          -- https://github.com/mhinz/vim-startify
"   Useful commands:
"     :Startify    reopen the start screen
"     :SLoad       load a session
"     :SSave       save a session
"     :SDelete[!]  delete a session(If ! is given, you won't get prompted.)
"     :SClose      close a session
Plugin 'mhinz/vim-startify'

" startify settings
let g:startify_enable_special         = 0
let g:startify_relative_path          = 1
let g:startify_change_to_dir          = 1
" The default for Windows systems is '$HOME\vimfiles\session'.
let g:startify_session_dir = '~/.vim/session'
let g:startify_session_autoload       = 1
let g:startify_session_persistence    = 1
let g:startify_session_delete_buffers = 1
let g:startify_bookmarks = [
      \ { 'c': '~/conf/' },
      \ { 'v': '~/conf/.vimrc' },
      \ { 'u': '~/.vim/UltiSnips' },
      \ ]
let g:startify_custom_header =
      \ ['', "   Hi Zi! \\o/", '']
let g:startify_custom_footer = [
      \ '',
      \ "   Press 'e' for <empty buffer> and 'q' for <quit>.",
      \ '',
      \ "   Vim is charityware. Please read ':help uganda'.",
      \ '',
      \ "                           -- ziv @ Feb 2016",
      \ '']

" Shortcuts for startify
nn <silent> gs :tabe<CR>:Startify<CR>


" Solarized -- Precision colors for machines and people -------------------{{{2
"           -- https://github.com/altercation/vim-colors-solarized
Plugin 'altercation/vim-colors-solarized'

" Required settings
if has('gui_running')
  set background=light
else
  set background=dark
endif
let g:solarized_termcolors = 256
colorscheme solarized


" fugitive -- a Git wrapper -----------------------------------------------{{{2
"          -- https://github.com/tpope/vim-fugitive
Plugin 'tpope/vim-fugitive'

" Shortcuts for fugitive commands
" Use `g?` to show help after `;gs`.
nn <silent> ;gs :Gstatus<CR>
nn <silent> ;ga :Git add . -A<CR>
nn <silent> ;gc :Gcommit<CR>
nn <silent> ;gl :Gpull<CR>
nn <silent> ;gu :Gpush<CR>
nn <silent> ;gd :Gvdiff<CR>
nn <silent> ;gh :Gvdiff HEAD<CR>
nn <silent> ;gb :Gblame<CR>


" vim-go -- Go (golang) support for Vim -----------------------------------{{{2
"        -- https://github.com/fatih/vim-go
Plugin 'fatih/vim-go'

" vim-go settings
" By default when :GoInstallBinaries is called,
" the binaries are installed to $GOBIN or $GOPATH/bin. To change it:
"let g:go_bin_path = expand("~/.gotools")
" Customed syntax highlighting. They are disabled by default. (:h go-syntax)
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_arguments = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_variable_declarations = 1
"let g:go_highlight_variable_assignments = 1
" Enable goimports to automatically insert import paths instead of gofmt.
let g:go_fmt_command = "goimports"
" Use this option to jump to an existing buffer for the split, vsplit and tab
" mappings of |:GoDef|. By default it's disabled.
let g:go_def_reuse_buffer = 1

" Shortcuts for vim-go commands
" Use same shortcuts with YCM for consistency.
aug GoShortcuts
  au!
  " Open the target identifier in current buffer.
  " By default the mapping `gd` is enabled.
  au FileType go nm ;j <Plug>(go-def-tab)
  " go run/build/test for the current package.
  au FileType go nm gr <Plug>(go-run)
  au FileType go nm ;c <Plug>(go-build)
  au FileType go nm gt <Plug>(go-test)
  " Beautifully anmotated source code to see which functions are covered.
  au FileType go nm gc <Plug>(go-coverage)
  " Open the relevant Godoc for the word under the cursor.
  au FileType go nm ;d <Plug>(go-doc)
  " Rename the identifier under the cursor to a new name.
  au FileType go nm ge <Plug>(go-rename)
aug END


" Settings ----------------------------------------------------------------{{{1
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

" Highlight column 80 as well as 100 and onward.
" Google java style accepts a column limit of either 80 or 100 characters.
let &colorcolumn = "80,".join(range(100,256),",")

source ~/.vim/files/cscope_maps.vim

aug ZAug
  au!
  " Special indent.
  au FileType python set softtabstop=4 | set shiftwidth=4

  " Skeleton files.
  au BufNewFile Makefile 0r ~/.vim/skeletons/Makefile
  au BufNewFile *.tex 0r ~/.vim/skeletons/skeleton.tex
  au BufNewFile py_wrapper.cc 0r ~/.vim/skeletons/py_wrapper.cc

  " Filetype detection.
  au BufRead,BufNewFile *.sh_*,*.zsh_*,*.bash_* set filetype=sh
  au BufRead,BufNewFile *.vim_* set filetype=vim

  " Autosave config files.
  autocmd BufWritePost ~/conf/* !(cd ~/conf; ./set.sh)
aug END


" Powerline ---------------------------------------------------------------{{{2
"           -- https://powerline.readthedocs.org/en/master/usage/other.html
"   Check `vim --version | grep python3` first.
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
" Always display the statusline in all windows.
set laststatus=2
" Always display the tabline, even if there is only one tab.
set showtabline=2
" Hide the default mode text (e.g. -- INSERT -- below the statusline).
set noshowmode


" Color settings ----------------------------------------------------------{{{2
set cursorline
hi CursorLine cterm=none ctermbg=237
set cursorcolumn
hi CursorColumn cterm=none ctermbg=237

" Highlight during search.
set hlsearch
hi Search cterm=none ctermfg=grey ctermbg=darkyellow

" New syntax highlight rules for all files.
aug NewSyntaxHighlight
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



" Custom commands ---------------------------------------------------------{{{1
"   Check `:h <key>` and `:verb map <key>` before adding new mappings.

" Easy to close highlighting after searching.
nn <silent> ;h :nohl<CR>

" Easy to copy.
nn <silent> ;n :set rnu!<CR>:set nu!<CR>

" Move to column 80.
nn ;80 079l

" For window size.
nn <silent> [r :resize +5<CR>
nn <silent> [v :vert resize +5<CR>

" Specific for quickfix window.
nn <silent> [w :cw<CR>
nn <silent> [n :cn<CR>
nn <silent> [p :cp<CR>

" Just avoid plugins mapping with default key `\`.
let mapleader = ","
" Keep the default behavior of key `;` to other key.
nn <silent> \ ;
" Convenient use of pair `\` and `|`.
nn <silent> <bar> ,

" Quit current file without saving.
nn <silent> ;q :q!<CR>
" Quit all files without saving.
nn <silent> ;a :qa!<CR>
" Make the current window the only one on the screen, without saving.
nn <silent> ;l :only!<CR>
" Forced saving.
nn ;w :w!<CR>
" Edit file, empty for reading current file from disk again.
nn ;e :e 
" Edit file in a new tab.
nn ;t :tabe 
" Show all buffers and edit buffer [N] or {bufferName}, empty for nothing.
nn ;b :ls<CR>:tab sb 
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

" Delete trailing whithspace.
nn <silent> ds :%s#\s\+$##g<CR>

" Always use zM instead of zm.
nn zm zM
nn zr zR

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

" Substitute for all lines.
nn ;s :%s/
" Substitute for selected lines.
vn ;s :s/

" Commands for insert mode, see `:h Insert`.
" No need to map arrow keys since use Karabiner to map R_CMD+hjkl as arrows.
" Go to the beginning of the current line.
"ino <C-b> <Esc>I
" Go to the end of the current line.
"ino <C-c> <Esc>A
" Move cursor.
"ino <C-f> <Down>
"ino <C-g> <Up>

" Open file under cursor in a new tab.
nn gf <C-w>gf

" Open dir in a new window that will appear in the right.
command -n=1 -complete=dir ZOpenDir call s:ZOpenDir('<args>')
function s:ZOpenDir(dir)
  let l:width = winwidth(0) - 100
  if l:width < 30
    let l:width = 30
  endif
  exe "bo " . l:width . " vs " . a:dir
endfunction

" Edit the path of the current file.
nn ;r :ZOpenDir %:h<CR>

" Similar to :drop, but :drop can only be used in GUI.
command -n=1 -complete=file ZFindBufOrNew call s:ZFindBufOrNew('<args>')
function s:ZFindBufOrNew(filename)
  for tabnr in range(tabpagenr("$"))
    for bufnr in tabpagebuflist(tabnr + 1)
      if bufname(bufnr) == a:filename
        exe "sb " . a:filename
        return
      endif
    endfor
  endfor
  exe "tabf " . a:filename
endfunction

" Switch between .cc / .h / -inl.h / _test.cc
command -n=+ ZSwitch call s:ZSwitch(<f-args>)
function s:ZSwitch(expr, pat, ...)
  for sub in a:000
    let l:file = substitute(a:expr, a:pat, sub, "")
    if filereadable(l:file)
      ZFindBufOrNew l:file
      break
    endif
  endfor
endfunction
let pat = "\\(\\(_test\\)\\?.\\(c\\|cc\\|cpp\\)\\|\\(-inl\\)\\?.h\\)$"
nn <space>c :ZSwitch <C-R>=expand("%")<CR> <C-R>=pat<CR> .cc .c .cpp<CR>
nn <space>h :ZSwitch <C-R>=expand("%")<CR> <C-R>=pat<CR> .h<CR>
nn <space>i :ZSwitch <C-R>=expand("%")<CR> <C-R>=pat<CR> -inl.h<CR>
nn <space>t :ZSwitch <C-R>=expand("%")<CR> <C-R>=pat<CR> _test.cc _test\\0<CR>


" Local settings ----------------------------------------------------------{{{1
if filereadable(expand('~/.vim_local'))
  source ~/.vim_local
endif

" Enable all the plugins.
filetype plugin indent on
