set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'The-NERD-Commenter'
Plugin 'kien/ctrlp.vim'
Plugin 'dkprice/vim-easygrep'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'yukunlin/auto-pairs'
Plugin 'haya14busa/incsearch.vim'
Plugin 'jszakmeister/vim-togglecursor'
Plugin 'godlygeek/tabular'
Plugin 'cyphactor/vim-open-alternate'
Plugin 'terryma/vim-expand-region'
Plugin 'majutsushi/tagbar'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-jdaddy'
"ruby
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-rails'
Plugin 'elixir-lang/vim-elixir'
Plugin 'thoughtbot/vim-rspec'
"go
Plugin 'fatih/vim-go'
"swift
Plugin 'keith/swift.vim'
Plugin 'scrooloose/syntastic'
"js
Plugin 'marijnh/tern_for_vim'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
let g:jsx_ext_required = 0

Plugin 'junegunn/vim-easy-align'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'valloric/youcompleteme'
  let g:ycm_collect_identifiers_from_tags_files = 1
  let g:ycm_min_num_of_chars_for_completion = 2
  let g:ycm_collect_identifiers_from_comments_and_strings = 0
  let g:ycm_seed_identifiers_with_syntax = 0
  let g:ycm_register_as_syntastic_checker = 0
  let g:ycm_path_to_python_interpreter = '/usr/local/bin/python3'
"Plugin 'AutoComplPop'
"Themes
"Plugin 'trevordmiller/nova-vim'
 "Track the engine.
 Plugin 'SirVer/ultisnips'

 " Snippets are separated from the engine. Add this if you want them:
 Plugin 'honza/vim-snippets'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

call vundle#end()            " required
" To ignore plugin indent changes, instead use:
filetype plugin indent on    " required
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

"" Put your non-Plugin stuff after
