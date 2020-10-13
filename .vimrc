" Set up steps ------------------------------------------------------------{{{1
"
" The installation for vim-plug and all plugins will be auto triggered.
"
" Install https://github.com/ryanoasis/vim-devicons
"   Install https://github.com/ryanoasis/nerd-fonts
"     MacOS - https://github.com/ryanoasis/nerd-fonts#option-4-homebrew-fonts
"       brew tap caskroom/fonts && brew cask install font-hack-nerd-font
"       # Then open iTerm2 and set `Preference`->`Profiles`->`Text`->
"       # `Non-ASCII Font` as `Hack Nerd Font`.
"     Linux - https://github.com/ryanoasis/nerd-fonts#linux
" Install https://github.com/Chiel92/vim-autoformat
"   MacOS:
"     brew install clang-format python3 && pip3 install black
"   Linux:
"     sudo apt-get install clang-format python3-pip && pip3 install black
"   # Bazel BUILD - buildifier.
"   # See https://github.com/bazelbuild/buildtools/tree/master/buildifier.
"   go get github.com/bazelbuild/buildtools/buildifier
"   # Shell - shfmt. A shell formatter written in Go supporting POSIX Shell.
"   # See https://github.com/mvdan/sh.
"   go get -u mvdan.cc/sh/cmd/shfmt
"   # Markdown - remark. A Javascript based markdown processor.
"   # See https://github.com/wooorm/remark.
"   npm install -g remark-cli
"   # JSON - fixjson. A JSON fixer for humans using (relaxed) JSON5.
"   # See https://github.com/rhysd/fixjson.
"   npm install -g fixjson
" Install https://github.com/Valloric/YouCompleteMe
"   # Completer options for install.py
"   #   --clang-completer (need cmake, gcc, g++ and python-dev)
"   #   --gocode-completer
"   #   --ts-completer (JavaScript and TypeScript support)
"   #   --all (with everything enabled except --clangd-completer)
"   cd ~/.vim/plugged/YouCompleteMe && ./install.py --clangd-completer
" Install https://github.com/majutsushi/tagbar
"   Depend on Exuberant Ctags or Universal Ctags (See https://ctags.io/).
"   MacOS:
"     brew install --HEAD universal-ctags/universal-ctags/universal-ctags
"   Linux:
"     snap install universal-ctags
"   # Javascript - jsctags.
"   # See https://github.com/sergioramos/jsctags.
"   npm install -g jsctags
" Install https://github.com/dense-analysis/ale
"   # Vim - vint. A vim script language lint.
"   # See https://github.com/Kuniwak/vint.
"   pip3 install vim-vint
"   # Protobuf - protoc-gen-lint. A plug-in for protobufs compiler to lint.
"   # See https://github.com/ckaznocha/protoc-gen-lint.
"   go get github.com/ckaznocha/protoc-gen-lint
"
"
" Notes -------------------------------------------------------------------{{{1
"   For Definition/Reference jump:
"     exuberant-ctags & cscope & quickfix & YouCompleteMe
"     Commands like: C-] C-t <C-\>s [w ;j
"
"     See '~/conf/vim/files/cscope_maps.vim' for commands of cscope.
"     Normally just build cscope.out by run `cscope -Rbkq`.
"     Put 'let $CSCOPE_DB = CSCOPE_OUT_FILE' in .vim_env if necessary.
"
"     The various YcmCompleter GoTo* subcommands add entries to Vim's jumplist
"     so you can use CTRL-O to jump back to where you where before invoking
"     the command (and CTRL-I to jump forward; see `:h jumplist` for details).
"
"   To find unused keys:
"     for i in {a..z};do;if ! grep \;$i ~/.vimrc>/dev/null;then;echo $i;fi;done


" Basic environment and setting -------------------------------------------{{{1
if filereadable(expand('~/.vim_env'))
  source ~/.vim_env
endif


" vim-plug -- A minimalist Vim plugin manager -----------------------------{{{1
"          -- https://github.com/junegunn/vim-plug

" Automatic installation.
" See https://github.com/junegunn/vim-plug/wiki/tips.
" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Specify a directory for plugins.
call plug#begin('~/.vim/plugged')


" Solarized -- Precision colors for machines and people -------------------{{{2
"           -- https://github.com/altercation/vim-colors-solarized
Plug 'altercation/vim-colors-solarized'


" Startify -- The fancy start screen for Vim ------------------------------{{{2
"          -- https://github.com/mhinz/vim-startify
"   Useful commands:
"     :Startify    reopen the start screen
"     :SLoad       load a session
"     :SSave       save a session
"     :SDelete[!]  delete a session(If ! is given, you won't get prompted.)
"     :SClose      close a session
Plug 'mhinz/vim-startify'

" Startify settings.
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
  \ '                           -- ziv @ Feb 2016',
  \ '']

" Shortcuts for Startify commands.
nn <silent> gs :tabe<CR>:Startify<CR>


" NERDTree -- A file system explorer for Vim ------------------------------{{{2
"          -- https://github.com/scrooloose/nerdtree
Plug 'scrooloose/nerdtree'

" NERDTree plugins.
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'

" NERDTree settings.
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeHighlightFolders = 1
let g:NERDTreeHighlightFoldersFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeShowLineNumbers = 1

" Shortcuts for NERDTree commands.
" Switches NERDTree on/off for all tabs.
nm ;r <plug>NERDTreeTabsToggle<CR>
" Find and reveal the file for the active buffer in the NERDTree window.
nn [p :NERDTreeFind<CR>:NERDTreeTabsOpen<CR>
" Open a fresh NERD tree with root as the dir which current file is under.
nn [c :NERDTree %:h<CR>:NERDTreeTabsOpen<CR>


" CtrlP -- Fuzzy file, buffer, mru, tag, etc finder -----------------------{{{2
"       -- https://github.com/ctrlpvim/ctrlp.vim
"   Basic usage:
"     <ESC>/<C-c>/<C-g> cancel and go back to the prompt
"     <C-j>/<C-k>       arrow keys to navigate the result list
"     <CR>/<C-t>/<C-v>  open selected file in current window/new tab/vert split
"     <TAB>             auto-complete directory names
"     <C-f>/<C-b>       cycle between modes
"     <C-d>/<C-r>       switch to search by filename/regexp mode
"     <F5>              purge the cache for the current directory
"     <C-z> to mark/unmark multiple files and <C-o> to open them
"     Submit .. (or more dots) to up 1 (or more) level of directory tree
"     @cd path          change CtrlP's local working directory
Plug 'ctrlpvim/ctrlp.vim'

" CtrlP settings.
" Create file in a new tab when pressing <C-y>.
let g:ctrlp_open_new_file = 't'
" Enable cross-session caching by not deleting the cache files upon exiting.
let g:ctrlp_clear_cache_on_exit = 0
" Scan dotfiles and dotdirs.
let g:ctrlp_show_hidden = 1
" Follow symbolic links but ignore looped internal symlinks to avoid duplicates.
let g:ctrlp_follow_symlinks = 1
" Exclude files and directories from the results.
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn|clangd)|('.
  \         'third_party|node_modules|dist))$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'bazel-*',
  \ }

" Shortcuts for CtrlP commands.
nn ;<C-P> :CtrlP 


" vim-autoformat -- format code with one button press ---------------------{{{2
"                -- https://github.com/Chiel92/vim-autoformat
Plug 'Chiel92/vim-autoformat'

" Vim-autoformat settings.
" Uncomment to DEBUG.
"let g:autoformat_verbosemode=1
" See ~/.vim/plugged/vim-autoformat/plugin/defaults.vim.
" Only change the style option to Google.
let g:formatdef_clangformat = "'clang-format ".
  \ "-lines='.a:firstline.':'.a:lastline.' ".
  \ "--assume-filename=\"'.expand('%:p').'\" ".
  \ "-style=\"{BasedOnStyle: Google, ".
  \ '          BinPackArguments: false, BinPackParameters: false, '.
  \ "          DerivePointerAlignment: false, PointerAlignment: Left}\"'"
" Default style is 'ansi'.
" TODO(ziv): Consider if change to use .astylerc conf file.
let g:formatdef_astyle_cs   = '"astyle --mode=cs   --style=google '.
  \ '--indent-namespaces -pcH".(&expandtab ? "s".shiftwidth() : "t")'
let g:formatdef_astyle_c    = '"astyle --mode=c    --style=google '.
  \ '-pcH".(&expandtab ? "s".shiftwidth() : "t")'
let g:formatdef_astyle_cpp  = '"astyle --mode=c    --style=google '.
  \ '-pcH".(&expandtab ? "s".shiftwidth() : "t")'
let g:formatdef_astyle_java = '"astyle --mode=java --style=google '.
  \ '-pcH".(&expandtab ? "s".shiftwidth() : "t")'
" Add formatter for bazel BUILD files.
" See https://github.com/bazelbuild/buildtools/tree/master/buildifier.
let g:formatters_bzl = ['buildifier']
let g:formatdef_buildifier = '"buildifier"'

" Shortcuts for vim-autoformat commands.
" For Normal, Visual, Select, Operator-pending modes.
map <silent> <C-k> :Autoformat<CR>

" Settings for autoformatting.
aug AutoformatOnSaving
  au!
  au FileType javascript nn ;w :Autoformat<CR>:w!<CR>
aug END


" UltiSnips -- The ultimate solution for snippets in Vim ------------------{{{2
"           -- https://github.com/SirVer/ultisnips
Plug 'SirVer/ultisnips', {
  \ 'do': 'git clone https://github.com/zivv/UltiSnips.git ~/.vim/UltiSnips'
  \ }

" Settings for merging snippet filetypes.
aug UltiSnipsAddFiletypes
  au!
  au FileType javascript UltiSnipsAddFiletypes javascript.html
aug END

" UltiSnips settings.
" Default value is <Tab>. Do not use <Tab> if use YouCompleteMe.
let g:UltiSnipsExpandTrigger = '<C-h>'
" Default value is <C-Tab>.
"let g:UltiSnipsListSnippets = '<C-Tab>'
" Default value is <C-j>.
"let g:UltiSnipsJumpForwardTrigger = '<Tab>'
" Default value is <C-k>.
"let g:UltiSnipsJumpBackwardTrigger = '<C-Tab>'

" Snipmate & UltiSnip Snippets -- for UltiSnips
"   https://github.com/honza/vim-snippets
"   Seems support <C-p>(or <Tab>) & <C-n> to choose trigger.
Plug 'honza/vim-snippets'


" vim-multiple-cursors -- True Sublime Text style multiple selections -----{{{2
"                      -- https://github.com/terryma/vim-multiple-cursors
" TODO(ziv): g:multi_cursor_quit_key & g:multi_cursor_normal_maps not working
Plug 'terryma/vim-multiple-cursors'


" YCM -- code completion engine -------------------------------------------{{{2
"     -- require vim 7.3.584+
"     -- https://github.com/Valloric/YouCompleteMe
if filereadable(expand('~/.at_google'))
  " Google-only
else
  " Non-Google only
  Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
endif

" YCM settings.
" Uncomment to DEBUG. Try :YcmDebugInfo & :YcmToggleLogs.
"let g:ycm_log_level='debug'
" Default value is ['<TAB>', '<Down>'].
"let g:ycm_key_list_select_completion = ['<Down>']
" Default value is ['<S-TAB>', '<Up>'].
"let g:ycm_key_list_previous_completion = ['<Up>']
" Default value is 'same-buffer'.
let g:ycm_goto_buffer_command = 'new-or-existing-tab'
" Global conf file, see YCM's own .ycm_extra_conf.py:
"   https://github.com/Valloric/ycmd/blob/master/cpp/ycm/.ycm_extra_conf.py
let g:ycm_global_ycm_extra_conf = '~/.vim/files/.ycm_extra_conf.py'
" YCM will automatically found '.ycm_extra_conf.py' file in path and ask if it
" is safe to be loaded. To selectively get YCM to ask/not ask about loading
" files, put the following line to '.vim_local' and add rules to it.
let g:ycm_extra_conf_globlist = ['!~/conf/*']
" C-family Semantic Completion:
"   https://github.com/ycm-core/YouCompleteMe#c-family-semantic-completion
" Check https://clang.llvm.org/extra/clangd/Installation.html#editor-plugins.
" Let clangd fully control code completion.
let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
let g:ycm_clangd_binary_path = exepath('clangd')
" The command line arguments passed to the clangd binary.
"let g:ycm_clangd_args = ['-log=verbose', '-pretty']

" Shortcuts for YCM commands.
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


" Tagbar -- a class outline viewer for Vim --------------------------------{{{2
"        -- https://github.com/majutsushi/tagbar
"   Support for additional filetypes: https://github.com/majutsushi/tagbar/wiki
Plug 'majutsushi/tagbar'

" Shortcuts for Tagbar commands.
nn <silent> ;k :TagbarToggle<CR>


" ALE -- Asynchronous Lint Engine -----------------------------------------{{{2
"     -- https://github.com/dense-analysis/ale
"   Supported languages and tools:
"     https://github.com/dense-analysis/ale/blob/master/supported-tools.md
Plug 'dense-analysis/ale'

" ALE settings.
let g:ale_linters = {
  \ 'cpp': [''],
  \ }
" Use current path as include path.
let g:ale_proto_protoc_gen_lint_options = '-I .'


" NERDCommenter -- Vim plugin for intensely orgasmic commenting -----------{{{2
"               -- https://github.com/scrooloose/nerdcommenter
"   Useful keys like: `,cl` `,cu`
Plug 'scrooloose/nerdcommenter'

" NERDCommenter settings.
let g:NERDBlockComIgnoreEmpty = 0
let g:NERDCommentWholeLinesInVMode = 1
let g:NERDSpaceDelims = 1


" Fugitive -- a Git wrapper -----------------------------------------------{{{2
"          -- https://github.com/tpope/vim-fugitive
Plug 'tpope/vim-fugitive'

" Shortcuts for Fugitive commands.
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
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

" Vim-go settings.
" By default when :GoInstallBinaries is called,
" the binaries are installed to $GOBIN or $GOPATH/bin. To change it:
"let g:go_bin_path = expand('~/.gotools')
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
let g:go_fmt_command = 'goimports'
" Jump to an existing buffer for the split, vsplit and tab mappings of :GoDef.
let g:go_def_reuse_buffer = 1

" Shortcuts for vim-go commands.
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
  " Beautifully annotated source code to see which functions are covered.
  au FileType go nm gc <Plug>(go-coverage)
  " Open the relevant Godoc for the word under the cursor.
  au FileType go nm ;d <Plug>(go-doc)
  " Rename the identifier under the cursor to a new name.
  au FileType go nm ;;s <Plug>(go-rename)
  " Call `go-metalinter` for the current directory. By default the following
  " linters are enabled: `vet`, `golint`, and `errcheck`.
  au FileType go nm ;;l <Plug>(go-metalinter)
  " Show all refs to entity denoted by selected identifier.
  au FileType go nm ;;f <Plug>(go-referrers)
aug END


" vim-javascript -- Vastly improved JS indentation and syntax support -----{{{2
"                -- https://github.com/pangloss/vim-javascript
Plug 'pangloss/vim-javascript'

" Vim-javascript settings.
" Enables syntax highlighting for Flow (https://flowtype.org/).
let g:javascript_plugin_flow = 1


" VimDevIcons -- Adds file type glyphs/icons to popular Vim plugins -------{{{2
"             -- https://github.com/ryanoasis/vim-devicons
"   Need to install a Nerd Font compatible font or patch your own and then set
"   the terminal font. See
"   https://github.com/ryanoasis/nerd-fonts#font-installation or
"   https://github.com/ryanoasis/nerd-fonts#font-patcher.
" Always load the vim-devicons as the very last one.
Plug 'ryanoasis/vim-devicons'


" Initialize plugin system
call plug#end()

" Run PlugInstall if there are missing plugins
if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  aug AutoInstall
    au VimEnter * PlugInstall --sync | source $MYVIMRC
  aug END
endif


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
scriptencoding utf-8
" gb2312 is windows' default encoding.
set fileencodings=utf-8,gb2312

" Turn on spell checking.
set spell
set spelllang=en_gb,cjk

" Command-line completion operates in an enhanced mode.
set wildmenu

" Default fold method.
set foldmethod=indent
" Initially, no closed fold.
set foldlevelstart=99
" Special fold method, by marker {{{ and }}}
aug FoldMarker
  au!
  au BufRead,BufNewFile ~/conf/* set foldmethod=marker | set foldlevel=0
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

source ~/.vim/files/cscope_maps.vim

aug ZSetting
  au!
  " Special indent.
  au FileType python set softtabstop=4 | set shiftwidth=4
  au FileType go     set softtabstop=8 | set shiftwidth=8 | set noexpandtab
  au FileType bzl    set softtabstop=4 | set shiftwidth=4

  " Skeleton files.
  au BufNewFile Makefile 0r ~/.vim/skeletons/Makefile
  au BufNewFile *.tex 0r ~/.vim/skeletons/skeleton.tex
  au BufNewFile py_wrapper.cc 0r ~/.vim/skeletons/py_wrapper.cc
  au BufNewFile *.proto 0r ~/.vim/skeletons/skeleton.proto

  " Filetype detection.
  au BufRead,BufNewFile *.sh_*,*.zsh_*,*.bash_* set filetype=sh
  au BufRead,BufNewFile *.vim_* set filetype=vim
  au BufRead,BufNewFile *.BUILD set filetype=bzl
  " For better syntax highlight. (Looks poor if set ft=dockerfile)
  au BufRead,BufNewFile Dockerfile,*.dockerfile set filetype=config
  au BufRead,BufNewFile *.launch set filetype=xml

  " Autosave config files.
  au BufWritePost ~/conf/* !(cd ~/conf; ./set.sh)
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

" See Solarized.
if has('gui_running')
  set background=light
else
  set background=dark
endif
let g:solarized_termcolors = 256
colorscheme solarized

set cursorline
hi CursorLine cterm=none ctermbg=237
set cursorcolumn
hi CursorColumn cterm=none ctermbg=237

" Highlight column 80 as well as 100 and onward.
" Google java style accepts a column limit of either 80 or 100 characters.
let &colorcolumn = '80,'.join(range(100,256),',')

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



" Custom commands ---------------------------------------------------------{{{1
"   Check `:h <key>` and `:verb map <key>` before adding new mappings.

" Easy to close highlighting after searching.
nn <silent> ;h :nohl<CR>

" Keep the same direction of keys n/N after searching.
nn # *NN

" Easy to copy.
nn <silent> ;n :set rnu!<CR>:set nu!<CR>

" Move to column 80.
nn ;80 079l

" Increase current window height by 5.
nn <silent> [h :resize +5<CR>
" Increase current window width by 5.
nn <silent> [w :vert resize +5<CR>

" Specific for quickfix window.
nn <silent> [q :cw<CR>
nn <silent> [i :cp<CR>
nn <silent> [o :cn<CR>

" Just avoid plugins mapping with default key `\`.
let mapleader = ','
" Keep the default behavior of key `;` to other key.
nn <silent> \ ;
" Convenient use of pair `\` and `|`.
nn <silent> <bar> ,

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
vn ;p "+p
vn ;P "+P

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

" Open file under cursor in a new tab, see `:h CTRL-W_gf`.
nn gf <C-w>gf

" Similar to :drop, but :drop can only be used in GUI.
command -n=1 -complete=file ZFindBufOrNew call s:ZFindBufOrNew(<args>)
function s:ZFindBufOrNew(filename)
  for tabnr in range(tabpagenr('$'))
    for bufnr in tabpagebuflist(tabnr + 1)
      if bufname(bufnr) == a:filename
        exe 'sb ' . a:filename
        return
      endif
    endfor
  endfor
  exe 'tabf ' . a:filename
endfunction
" Open the related file found first.
command -n=+ ZSwitch call s:ZSwitch(<f-args>)
function s:ZSwitch(name, pat, ...)
  for sub in a:000
    let l:file = substitute(a:name, a:pat, sub, '')
    if l:file != a:name && filereadable(l:file)
      ZFindBufOrNew l:file
      break
    endif
  endfor
endfunction
" Switch between .cc / .h / -inl.h / _test.cc
let cpat = "\\(\\(_test\\)\\?.\\(c\\|cc\\|cpp\\)\\|\\(-inl\\)\\?.h\\)$"
nn <space>c :ZSwitch <C-R>=expand("%")<CR> <C-R>=cpat<CR> .cc .c .cpp<CR>
nn <space>h :ZSwitch <C-R>=expand("%")<CR> <C-R>=cpat<CR> .h<CR>
nn <space>i :ZSwitch <C-R>=expand("%")<CR> <C-R>=cpat<CR> -inl.h<CR>
nn <space>t :ZSwitch <C-R>=expand("%")<CR> <C-R>=cpat<CR> _test.cc _test\\0<CR>
" Switch between .go / _test.go
nn <space>g :ZSwitch <C-R>=expand("%")<CR> \\(_test\\)\\?.go$ .go _test.go<CR>


" Local settings ----------------------------------------------------------{{{1
if filereadable(expand('~/.vim_local'))
  source ~/.vim_local
endif
