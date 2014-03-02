" Last editing: Wed Jan 29 10:53:03 BRST 2014
"

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

" Color schemes
Bundle "croaker/mustang-vim"
Bundle "altercation/vim-colors-solarized"

" Ruby on Rails support
Bundle "tpope/vim-rails"
" Bundle \"tpope/vim-bundler\"

" Miscelaneous
Bundle "ivalkeen/vim-simpledb"
Bundle "tacahiroy/ctrlp-funky"
" }}}

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
set scrolloff=9999 " set cursor in middle of the screen when searching

set clipboard=unnamed
" }}}

set bg=dark
syntax on
colorscheme solarized

filetype plugin indent on

" Filetype-specific settings {{{
autocmd! FileType ruby setlocal shiftwidth=2 tabstop=2
autocmd! FileType eruby setlocal shiftwidth=2 tabstop=2
autocmd! FileType css setlocal shiftwidth=2 tabstop=2
autocmd! FileType coffee setlocal shiftwidth=2 tabstop=2
autocmd! FileType yaml setlocal shiftwidth=2 tabstop=2
autocmd! FileType vim setlocal shiftwidth=2 tabstop=2
autocmd! BufNewFile,BufRead *.jbuilder set filetype=ruby
autocmd! BufWritePre * :%s/\s\+$//e

autocmd! BufEnter * call ChangeWindowTitle()
" }}}

" Custom Functions {{{
function! MoveTo(newname)
    let a:oldname = expand("%:p")
    exec "saveas " . a:newname
    call delete(a:oldname)
    exec "bdelete " . a:oldname
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

function! ChangeWindowTitle()
  let &titlestring = hostname() . ":" . expand("%:p")
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
" }}}

" Plugin Configuration {{{
let mapleader=","
let maplocalleader = "\\"

let g:ctrlp_follow_symlinks=1
let g:ctrlp_extensions = ['funky']
let g:ctrlp_funky_syntax_highlight = 1

let g:netrw_liststyle=3

let g:syntastic_ruby_checkers = ['mri', 'rubocop']

if has("gui")
    let g:airline_theme="luna"
else
    let g:ariline_theme="bubblegum"
endif

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

let g:VimuxUseNearestPane = 1

let g:turbux_command_test_unit = 'clear; zeus test'

let &titleold=getcwd()
let g:clang_library_path = "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/"
" }}}

" Keyboard mappings: {{{
" NORMAL {{{

nnoremap <Leader>l :set number!<CR>
nnoremap <Leader>p :set paste!<CR>
nnoremap <Leader>q :set nohlsearch<CR>

nnoremap <Leader>x :chdir ~/code/
nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>

" Navigate to the last edited buffer
nmap <C-e> :b#<CR>

nmap j gj
nmap k gk

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
" }}}
" INSERT {{{

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" open omni completion menu closing previous if open and opening new menu without changing the text
inoremap <expr> <C-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
            \ '<C-x><C-o><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'
" open user completion menu closing previous if open and opening new menu without changing the text
inoremap <expr> <S-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
            \ '<C-x><C-u><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'

inoremap jj <ESC>

" }}}
" }}}

" Abbreviations {{{
iabbr {{now}} <C-r>=system("date")<CR>
" }}}

