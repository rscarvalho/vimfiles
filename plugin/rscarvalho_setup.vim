set omnifunc=syntaxcomplete#Complete
let mapleader=","

set smartindent
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set showcmd
set linespace=3
set formatoptions=qrn1

set incsearch
set hlsearch
set ignorecase
set smartcase

set foldenable
set mousehide
set splitbelow
set wildmenu
set wildmode=list:longest
set number
set synmaxcol=150
set foldmethod=marker
set foldmarker={{{,}}}

set mouse=a

let g:netrw_liststyle=3
let g:syntastic_ruby_checkers = ['mri', 'rubocop']

colorscheme solarized

if has("gui")
    let g:airline_theme="luna"
else
    let g:ariline_theme="bubblegum"
endif

set completeopt=longest,menuone

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
nnoremap <Space> za

autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2
autocmd FileType coffee setlocal shiftwidth=2 tabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2
autocmd FileType vim setlocal shiftwidth=2 tabstop=2

let coffee_compiler = '/usr/local/share/npm/bin/coffee'
let g:vim_markdown_folding_disabled=1

function! OpenSourceTree()
    let l:git_root=system("cd " . shellescape(expand("%:p:h")) . " && git rev-parse --show-toplevel")
    let l:git_root=strpart(l:git_root, 0, strlen(l:git_root) - 1)
    execute "silent !/usr/bin/open -a SourceTree " . shellescape(l:git_root)
endfunction

command! SourceTree call OpenSourceTree()
command! -nargs=+ Heroku :!heroku <args>

command! W execute 'silent w !sudo tee % > /dev/null' | edit!

au BufNewFile,BufRead *.jbuilder set filetype=ruby

" Remove whitespaces
command! TrimSpaces %s/\s\+$//e
autocmd! BufWritePre * :%s/\s\+$//e

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
command! LandSlide call LandSlide(0)


" nnoremap <F8> :chdir %:p:h<CR>:echom "Current Directory: " . expand("%:p:h")<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <F8> :TagbarToggle<CR>

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

" Splits
" window
nmap <leader>swl :topleft vnew<CR>
nmap <leader>swh :botright vnew<CR>
nmap <leader>swk :topleft new<CR>
nmap <leader>swj :botright new<CR>

" buffer
nmap <leader>sl :leftabove vnew<CR>
nmap <leader>sh :rightbelow vnew<CR>
nmap <leader>sk :leftabove new<CR>
nmap <leader>sj :rightbelow new<CR>


"" CommandT Settings
" let g:CommandTMaxHeight = 10
" let g:CommandTWildIgnore = &wildignore .
" let g:CommandTMatchWindowAtTop = 0

set wildignore+=*/vendor/ruby/*,*/vendor/jruby/*
set wildignore+=vendor/ruby/*,vendor/jruby/*

" nnoremap <C-p> :CommandT<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
let g:ctrlp_follow_symlinks=1


nnoremap <C-w>gd <C-w>h<C-w>c:diffoff<CR>:echom "Diff closed"<CR>
inoremap JJ <CR><ESC>O

" Syntastic options
let g:syntastic_html_tidy_ignore_errors = [" proprietary attribute \"role\"", " trimming empty <"]

" vim-session variables
let g:session_autosave = 'yes'
let g:session_autoload = 1
let g:session_autosave_periodic = 5 "minutes

function! MoveTo(newname)
    let a:oldname = expand("%:p")
    exec "saveas " . a:newname
    call delete(a:oldname)
    exec "bdelete " . a:oldname
endfunction

command! -nargs=1 -complete=file MoveTo call MoveTo(<f-args>)

nnoremap <leader>x :chdir ~/code/

iabbr {{now}} <C-r>=system("date")<CR>
nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>

" gitgutter config
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

" command! StripBlankLines exec ':%s/\(\s*\n\s*\)\{2,}/\r\r'|:noh
