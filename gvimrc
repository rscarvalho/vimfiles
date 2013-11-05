set go-=T
set bg=dark

colorscheme mayansmoke

" if &background == "dark"
" 	hi normal guibg=black
" 	set transp=8
" endif

if has("gui_mac") || has("gui_macvim")
    set guifont=Source\ Code\ Pro\ Medium:h16
else
    set guifont=Source\ Code\ Pro\ Medium\ 13
endif


if has("gui_gtk") || has("gui_gtk2")
    map <C-S-t> <ESC>:tabnew<CR>
endif

set columns=160
set lines=60

" set guioptions-=r " Removes right hand scroll bar
set go-=L " Removes left hand scroll bar
set go-=b
autocmd User Rails let b:surround_{char2nr('-')} = "<% \r %>" " displays <% %> correctly
set cpoptions+=$ " puts a $ marker for the end of words/lines in cw/c$ comments
