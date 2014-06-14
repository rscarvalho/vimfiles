set go-=T

if &background == "dark"
  "  hi normal guibg=black
  set transp=3
else
  set transparency=2
endif


if has("gui_gtk") || has("gui_gtk2")
  map <C-S-t> <ESC>:tabnew<CR>
else
  set guifont=Source\ Code\ Pro:h15
endif

set columns=160
set lines=60

" set guioptions-=r " Removes right hand scroll bar
set go-=L " Removes left hand scroll bar
set go-=b
