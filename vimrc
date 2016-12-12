syntax on
colorscheme gruvbox
set background=dark
set nocompatible              " be iMproved, required
filetype off                  " required
set laststatus=2
set hls
set backspace=indent,eol,start
set mouse=a
set clipboard=unnamed
set relativenumber

let mapleader = "\<Space>"

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :wq<CR>

nnoremap \ :NERDTreeToggle<CR>  
nnoremap <C-l> :vertical resize +10<CR>
nnoremap <C-h> :vertical resize -10<CR>

nnoremap <silent> <C-L> :noh<CR>
nmap K <Plug>(devdocs-under-cursor)
"nmap <C-j> :%!python -m json.tool<CR>

:nnoremap gr :grep <cword> *<CR>
:nnoremap Gr :grep <cword> %:p:h/*<CR>
:nnoremap gR :grep '\b<cword>\b' *<CR>
:nnoremap GR :grep '\b<cword>\b' %:p:h/*<CR>

nmap <Leader>r<CR> *:%s///g<left><left>
nmap <Leader>rc<CR> *:%s///gc<left><left><left>

nnoremap <leader>. :OpenAlternate<cr>
cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
let g:rspec_command = "!bundle exec rspec -f d -c {spec}"

nmap <F8> :TagbarToggle<CR>

map <M-K> <C-W>j<C-W>_
map <M-K> <C-W>k<C-W>_

"swap words
:nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>:nohlsearch<CR>"

let g:airline_powerline_fonts=1
let g:airline_theme='tomorrow'

"let g:easy_gitlab_url='https://git.saltedge.com'

set sw=2 ts=2 sts=2
au FileType go setl sw=4 sts=4 ts=4
au FileType swift setl sw=4 sts=4 ts=4

autocmd QuickFixCmdPost *grep* cwindow

set expandtab

" Undo
set undofile
set undodir=$HOME/.vim/undo

au BufRead,BufNewFile Podfile set filetype=ruby
au BufRead,BufNewFile Dangerfile set filetype=ruby

au BufRead,BufNewFile *.pbxproj set syntax=xml
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gor <Plug>(go-run)
au FileType go nmap <Leader>b <Plug>(go-build)
au FileType ruby nmap <Leader>r :!ruby %<CR>

"GO syntax hilighting
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

"Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_mode_map = { 'passive_filetypes': ['html', 'css', 'leaf'] }

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"let g:syntastic_swift_checkers = ['swiftpm', 'swiftlint']
 
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
 
" Move a line of text using CTRL+[jk]
nnoremap <C-j> :m .+1<CR>
nnoremap <C-k> :m .-2<CR>
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

"Paste yanked text
noremap <Leader>p "0p
noremap <Leader>P "0P
vnoremap <Leader>p "0p
"Automatically jump to the end of text pasted
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

"let g:ctrlp_custom_ignore = '\v[\/]\.(.build|Packages)$'
let g:ctrlp_use_caching = 0
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif

" fugitive git bindings
nnoremap <space>ga :Git add %:p<CR><CR>
nnoremap <space>gs :Gstatus<CR>
nnoremap <space>gc :Gcommit -v -q<CR>
nnoremap <space>gt :Gcommit -v -q %:p<CR>
nnoremap <space>gd :Gdiff<CR>
nnoremap <space>ge :Gedit<CR>
nnoremap <space>gr :Gread<CR>
nnoremap <space>gw :Gwrite<CR><CR>
nnoremap <space>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <space>gp :silent! Ggrep<Space>
nnoremap <space>gm :Gmove<Space>
nnoremap <space>gb :Git branch<Space>
nnoremap <space>go :Git checkout<Space>
nnoremap <space>gps :Dispatch! git push<CR>
nnoremap <space>gpl :Dispatch! git pull<CR>

"incsearch.vim
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'AutoComplPop'
Plugin 'The-NERD-Commenter'
Plugin 'dkprice/vim-easygrep'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'yukunlin/auto-pairs'
Plugin 'haya14busa/incsearch.vim'
Plugin 'jszakmeister/vim-togglecursor'
Plugin 'godlygeek/tabular'
Plugin 'xiaogaozi/easy-gitlab.vim'
Plugin 'cyphactor/vim-open-alternate'
Plugin 'terryma/vim-expand-region'
Plugin 'rhysd/devdocs.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-rails'
Plugin 'elixir-lang/vim-elixir'
Plugin 'thoughtbot/vim-rspec'
Plugin 'majutsushi/tagbar'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'fatih/vim-go'
Plugin 'tpope/vim-surround'
"swift
Plugin 'keith/swift.vim'
Plugin 'scrooloose/syntastic'
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

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-n>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ag \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

"Auto reload vimrc
"augroup reload_vimrc " {
    "autocmd!
    "autocmd BufWritePost $MYVIMRC source $MYVIMRC
"augroup END " }
