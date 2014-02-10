" Last editing: Wed Jan 29 10:53:03 BRST 2014
"

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
Bundle "rizzatti/dash.vim"

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

" Color schemes
Bundle "croaker/mustang-vim"
Bundle "altercation/vim-colors-solarized"

" Ruby on Rails support
Bundle "tpope/vim-rails"
Bundle "tpope/vim-bundler"

" Miscelaneous
Bundle "ivalkeen/vim-simpledb"
" }}}

filetype plugin indent on
