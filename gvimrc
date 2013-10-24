set go-=T
set bg=dark

colorscheme codeschool

" if &background == "dark"
" 	hi normal guibg=black
" 	set transp=8
" endif

set guifont=Source\ Code\ Pro\ Light:h13

set columns=160
set lines=60
set number

" map <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :CommandT<CR>
" map <F5> <ESC>:NERDTreeFind<CR>

" move cursor to editor window when clicking on NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" set guioptions-=r " Removes right hand scroll bar
set go-=L " Removes left hand scroll bar
autocmd User Rails let b:surround_{char2nr('-')} = "<% \r %>" " displays <% %> correctly
set cpoptions+=$ " puts a $ marker for the end of words/lines in cw/c$ comments
