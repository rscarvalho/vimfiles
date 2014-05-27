filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" Libraries
Plugin 'rizzatti/funcoo.vim'
Plugin 'tomtom/tlib_vim'
Plugin 'MarcWeber/vim-addon-mw-utils'

" Editor power-ups
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/syntastic'
Plugin 'mileszs/ack.vim'
Plugin 'majutsushi/tagbar'
Plugin 'benmills/vimux'
Plugin 'jgdavey/vim-turbux'
Plugin 'tomtom/tcomment_vim'
Plugin 'duff/vim-scratch'
" Plugin 'Valloric/YouCompleteMe'

" Language support
" Plugin "dart-lang/dart-vim-plugin"
Plugin 'pangloss/vim-javascript'
Plugin 'vim-ruby/vim-ruby'
Plugin 'nono/vim-handlebars'
Plugin 'evanmiller/nginx-vim-syntax'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-cucumber'
Plugin 'plasticboy/vim-markdown'
Plugin 'vim-scripts/Vim-R-plugin'
Plugin 'vim-scripts/po.vim--Jelenak'
Plugin 'Rip-Rip/clang_complete'
Plugin 'vim-scripts/ingo-library'
Plugin 'vim-scripts/CountJump'
Plugin 'vim-scripts/ConflictDetection'
Plugin 'vim-scripts/ConflictMotions'

" Color schemes
Plugin 'croaker/mustang-vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'chriskempson/base16-vim'
Plugin 'w0ng/vim-hybrid'
Plugin 'Lokaltog/vim-distinguished'

" Ruby on Rails support
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'

" Miscelaneous
Plugin 'ivalkeen/vim-simpledb'
Plugin 'tacahiroy/ctrlp-funky'

call vundle#end()
filetype plugin indent on
