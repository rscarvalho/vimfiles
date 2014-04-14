" Last editing: Wed Jan 29 10:53:03 BRST 2014

set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/

call vundle#rc()

" Vundle setup {{{
Bundle "gmarik/vundle"

" Libraries
Bundle "rizzatti/funcoo.vim"
Bundle "tomtom/tlib_vim"
Bundle "MarcWeber/vim-addon-mw-utils"

" Documentation
" Bundle "rizzatti/dash.vim"

" Editor power-ups
Bundle "xolox/vim-misc"
Bundle "xolox/vim-session"
Bundle "kien/ctrlp.vim"
Bundle "tpope/vim-surround"
Bundle "tpope/vim-sensible"
Bundle "tpope/vim-fugitive"
Bundle "bling/vim-airline"
Bundle "garbas/vim-snipmate"
Bundle "honza/vim-snippets"
" Bundle \"mattn/gist-vim\"
Bundle "terryma/vim-multiple-cursors"
Bundle "scrooloose/syntastic"
Bundle "mileszs/ack.vim"
Bundle "majutsushi/tagbar"
Bundle "benmills/vimux"
Bundle "jgdavey/vim-turbux"
Bundle "tomtom/tcomment_vim"
Bundle "duff/vim-scratch"
" Bundle "Valloric/YouCompleteMe"

" Language support
" Bundle "dart-lang/dart-vim-plugin"
Bundle "pangloss/vim-javascript"
Bundle "vim-ruby/vim-ruby"
Bundle "nono/vim-handlebars"
Bundle "evanmiller/nginx-vim-syntax"
Bundle "kchmck/vim-coffee-script"
Bundle "tpope/vim-cucumber"
Bundle "plasticboy/vim-markdown"
" Messing up with colors on other windows
" Bundle \"ap/vim-css-color\"
Bundle "vim-scripts/Vim-R-plugin"
Bundle "vim-scripts/po.vim--Jelenak"
Bundle "Rip-Rip/clang_complete"
Bundle "vim-scripts/ingo-library"
Bundle "vim-scripts/CountJump"
Bundle "vim-scripts/ConflictDetection"
Bundle "vim-scripts/ConflictMotions"

" Color schemes
Bundle "croaker/mustang-vim"
Bundle "altercation/vim-colors-solarized"
Bundle "chriskempson/base16-vim"

" Ruby on Rails support
Bundle "tpope/vim-rails"
" Bundle \"tpope/vim-bundler\"

" Miscelaneous
Bundle "ivalkeen/vim-simpledb"
Bundle "tacahiroy/ctrlp-funky"
" }}}

filetype plugin indent on

" General Options {{{
set hlsearch
set incsearch
set ignorecase
set smartcase

set anti
set enc=utf-8
set nowrap

set textwidth=0
set wrapmargin=0

set smartindent
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set noshowcmd

set foldenable
set foldmethod=marker
set foldmarker={{{,}}}

set mousehide
set mouse=a

set splitbelow
set splitright

set wildmenu wildmode=list:longest
set number
set formatoptions=qrn1

set synmaxcol=150
set omnifunc=syntaxcomplete#Complete

set completeopt=longest,menuone

set wildignore+=*/vendor/ruby/*,*/vendor/jruby/*
set wildignore+=vendor/ruby/*,vendor/jruby/*

set title
set history=1000
set undolevels=1000

set nobackup
set noswapfile
set hidden
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
set t_Co=256
set nrformats=

set spelllang=en_us
set grepprg=ack
set cursorline
" set scrolloff=9999 " set cursor in middle of the screen when searching

set clipboard=unnamed
set cpoptions+=$ " puts a $ marker for the end of words/lines in cw/c$ comments
" }}}

set bg=dark
syntax on
" colorscheme solarized
colorscheme base16-eighties

" Filetype-specific settings {{{
autocmd! FileType ruby setlocal shiftwidth=2 tabstop=2
autocmd! FileType eruby setlocal shiftwidth=2 tabstop=2
autocmd! FileType css setlocal shiftwidth=2 tabstop=2
autocmd! FileType coffee setlocal shiftwidth=2 tabstop=2
autocmd! FileType yaml setlocal shiftwidth=2 tabstop=2
autocmd! FileType vim setlocal shiftwidth=2 tabstop=2
autocmd! BufNewFile,BufRead *.jbuilder set filetype=ruby
autocmd! BufWritePre * :%s/\s\+$//e

" special settings for omnicomplete with ruby
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
" autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

" autocmd! User Rails let b:surround_{char2nr('-')} = "<% \r %>" " displays <% %> correctly
autocmd! User Rails nmap <Leader>sc :sp db/schema.rb<CR>
" }}}

" Custom Functions {{{
function! MoveTo(newname)
    let a:oldname = expand("%:p")
    exec "saveas " . a:newname
    call delete(a:oldname)
    exec "bdelete " . a:oldname
endfunction

function! DeleteFile()
  let a:name = expand("%:p")
  call delete(a:name)
  exec "bprevious"
  exec "bdelete " . a:name
endfunction

function! OpenSourceTree()
    let l:git_root=system("cd " . shellescape(expand("%:p:h")) . " && git rev-parse --show-toplevel")
    let l:git_root=strpart(l:git_root, 0, strlen(l:git_root) - 1)
    execute "silent !/usr/bin/open -a SourceTree " . shellescape(l:git_root)
endfunction

function! LandSlide(nargs, ...)
    let l:t = strftime("%m%d%H%M")
    let l:tmpdir = expand("$TMPDIR")

    if a:0 > 0
        let theme = a:1
    else
        let theme = -1
    endif

    let l:fname = l:tmpdir . "/landslide-slideshow-" . l:t . ".html"

    let l:cmdargs = "-c -i"
    if theme != -1
        let l:cmdargs .= " -t " . theme
    endif

    echom "Generating slideshow " . expand("%")
    execute 'silent !/usr/bin/env landslide ' . l:cmdargs . " -d " . shellescape(l:fname) . " " . expand("%:p")
    execute 'silent !/usr/bin/env open ' . shellescape(l:fname)
endfunction

function! ToggleMaxWins()
  if exists('g:windowMax')
    au! maxCurrWin
    wincmd =
    unlet g:windowMax
  else
    augroup maxCurrWin
      au! WinEnter * wincmd _ | wincmd |
    augroup END
    do maxCurrWin WinEnter
    let g:windowMax = 1
  endif
endfunction
" }}}

" General-purpose commands {{{
command! SourceTree call OpenSourceTree()
command! -nargs=+ Heroku :!heroku <args>
command! W execute 'silent w !sudo tee % > /dev/null' | edit!

" Remove whitespaces
command! TrimSpaces %s/\s\+$//e
command! StripBlankLines exec ':%s/\(\s*\n\s*\)\{2,}/\r\r'|:noh

command! -nargs=1 -complete=file MoveTo call MoveTo(<f-args>)
command! LandSlide call LandSlide(0)

command! DeleteFile call DeleteFile()
" }}}

" Plugin Configuration {{{
let mapleader=","
let maplocalleader = "\\"

" CtrlP {{{
let g:ctrlp_follow_symlinks=1
" let g:airline_powerline_fonts = 1
" if !exists('g:airline_symbols')
"   let g:airline_symbols = {}
" endif
" let g:airline_symbols.branch = "\ue0a0"
" let g:airline_left_sep = "\ue0b0"
" let g:airline_right_sep = "\ue0b2"

if has("gui")
    let g:airline_theme="luna"
else
    let g:airline_theme="bubblegum"
endif
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1

let g:ctrlp_extensions = ['tag', 'buffertag', 'funky', 'quickfix', 'rtscript']
let g:ctrlp_funky_syntax_highlight = 1

if has("mac")
  let g:ctrlp_buftag_ctags_bin = "/usr/local/bin/ctags"
endif
" }}}

let g:netrw_liststyle=3

let g:syntastic_ruby_checkers = ['mri', 'rubocop']

let coffee_compiler = '/usr/local/share/npm/bin/coffee'
let g:vim_markdown_folding_disabled=1

" TagBar {{{
let g:tagbar_type_css = {
            \        'ctagstype' : 'Css',
            \        'kinds'     : [
            \        'c:classes',
            \        's:selectors',
            \        'i:identities'
            \       ]
            \ }
let g:tagbar_type_sass = g:tagbar_type_css
let g:tagbar_type_scss = g:tagbar_type_css
" }}}

" Syntastic options
let g:syntastic_html_tidy_ignore_errors = [" proprietary attribute \"role\"", " trimming empty <"]

" vim-session variables {{{
let g:session_autosave = 'yes'
let g:session_autoload = 1
let g:session_autosave_periodic = 5 "minutes
" }}}

" gitgutter config
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

" let g:turbux_command_test_unit = 'clear; zeus test'
" let g:turbux_command_rspec = 'clear; zeus test'

let &titleold=getcwd()
let g:clang_library_path = "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/"

let g:VimuxUseNearestPane = 0

" rails.vim {{{
let g:rails_projections = {
      \     "app/jobs/*_job.rb": {
      \         "command": "job",
      \         "template": "class %SJob\nend",
      \         "test": [
      \             "test/jobs/%s_job_test.rb",
      \             "spec/jobs/%s_job_spec.rb"
      \         ],
      \         "keywords": "background task"
      \     }
      \ }
" }}}

" SnipMate
imap <C-J> <esc>a<Plug>snipMateNextOrTrigger
smap <C-J> <Plug>snipMateNextOrTrigger
" }}}

" Keyboard mappings: {{{
" NORMAL {{{
nnoremap <Leader>l :set number!<CR>
nnoremap <Leader>p :set paste!<CR>
nnoremap <Leader>q :set nohlsearch<CR>

nnoremap <Leader>x :chdir ~/code/
nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>
nnoremap <Leader>bd :bd<CR>

nnoremap tt :silent! TagbarToggle<CR>
nnoremap <C-s> :w<CR>

nnoremap <Leader>tn :tabnext<CR>
nnoremap <Leader>tp :tabprevious<CR>

nnoremap <Leader>max :call ToggleMaxWins()<CR>

" Navigate to the last edited buffer
nmap <C-e> :b#<CR>

nmap j gj
nmap k gk


" Splits
" window
nmap <Leader>swl :topleft vnew<CR>
nmap <Leader>swh :botright vnew<CR>
nmap <Leader>swk :topleft new<CR>
nmap <Leader>swj :botright new<CR>

" buffer
nmap <Leader>sl :leftabove vnew<CR>
nmap <Leader>sh :rightbelow vnew<CR>
nmap <Leader>sk :leftabove new<CR>
nmap <Leader>sj :rightbelow new<CR>

nnoremap ; :CtrlPBuffer<CR>
nnoremap <Leader>fu :CtrlPFunky<CR>
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<CR>


nnoremap <C-w>gd <C-w>h<C-w>c:diffoff<CR>:echom "Diff closed"<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <F8> :TagbarToggle<CR>

nnoremap <Space> za

nnoremap rp :VimuxPromptCommand<CR>
nnoremap rl :VimuxRunLastCommand<CR>
nnoremap ri :VimuxInspectRunner<CR>
nnoremap rx :VimuxCloseRunner<CR>
nnoremap rz :VimuxZoomRunner<CR>
" }}}

" INSERT {{{

" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
"   \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
" inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
"   \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
"
" " open omni completion menu closing previous if open and opening new menu without changing the text
" inoremap <expr> <C-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
"             \ '<C-x><C-o><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'
" " open user completion menu closing previous if open and opening new menu without changing the text
" inoremap <expr> <S-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
"             \ '<C-x><C-u><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'
"

inoremap <C-Space> <C-x><C-o>
inoremap jj <ESC>

inoremap <C-s> <ESC>:w<CR>i
" }}}

" COMMAND {{{
" Make command-line acts like a shell in emacs-mode
cnoremap <C-a>  <Home>
cnoremap <C-b>  <Left>
cnoremap <C-f>  <Right>
cnoremap <C-d>  <Delete>
cnoremap <M-b>  <S-Left>
cnoremap <M-f>  <S-Right>
cnoremap <M-d>  <S-right><Delete>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
cnoremap <Esc>d <S-right><Delete>
cnoremap <C-g>  <C-c>
command! Q q
command! Bw exec 'b #'|'bd #'
" }}}
" }}}

" Abbreviations {{{
iabbr {{now}} <C-r>=system("date")<CR>
" }}}
