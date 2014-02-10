set go-=T
set bg=dark

" colorscheme mayansmoke
colorscheme mustang

if &background == "dark"
  "  hi normal guibg=black
  set transp=4
else
  set transparency=2
endif

if has("gui_mac") || has("gui_macvim")
  " set guifont=Source\ Code\ Pro\ Light:h16
  set guifont=Sauce\ Code\ Powerline\ Light:h14
  let g:airline_powerline_fonts = 1
  if !exists('g:airline_symbols')
      let g:airline_symbols = {}
  endif
  let g:airline_symbols.branch = "\ue0a0"
  let g:airline_left_sep = "\ue0b0"
  let g:airline_right_sep = "\ue0b2"
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
