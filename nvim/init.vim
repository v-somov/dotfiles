syntax enable
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors

"set background=light
"colorscheme solarized8_light_flat
"
"set background=dark
"colorscheme gruvbox

set nocompatible              " be iMproved, required
filetype off                  " required
set laststatus=2
set hls
set backspace=indent,eol,start
set mouse=a
set clipboard=unnamed
set number
set relativenumber
set ignorecase
set smartcase

let mapleader = "\<Space>"

let g:airline_powerline_fonts=1
"let g:airline_theme='solarized'  
"let g:airline_theme='tomorrow'

set sw=2 ts=2 sts=2
au FileType go setl sw=4 sts=4 ts=4
au FileType swift setl sw=4 sts=4 ts=4

"Ctrp
set wildignore+=*/tmp/*,*/vendor/*,*.so,*.swp,*.zip
set expandtab

" Undo
set undofile
set undodir=$HOME/.vim/undo

call plug#begin('~/.config/nvim/plugged')

Plug 'trevordmiller/nova-vim'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'junegunn/vim-easy-align'
Plug 'foosoft/vim-argwrap'

Plug 'tommcdo/vim-lion'
let g:lion_squeeze_spaces = 1
"
"tpope
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-jdaddy'

Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'The-NERD-Commenter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'dkprice/vim-easygrep'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
Plug 'haya14busa/incsearch.vim'
Plug 'jszakmeister/vim-togglecursor'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'terryma/vim-expand-region'
Plug 'majutsushi/tagbar'
Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/syntastic'

Plug 'junegunn/goyo.vim'
nnoremap <leader>gg :Goyo<CR>

"Rust
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'

"JS
Plug 'mxw/vim-jsx'
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
let g:syntastic_javascript_checkers = ['eslint']
Plug 'ternjs/tern_for_vim', { 'do': 'npm install && npm install -g tern', 'for': ['javascript', 'javascript.jsx'] }
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }

Plug 'fatih/vim-go', { 'tag': '*' }
Plug 'nsf/gocode'
if has('nvim')
 Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
 Plug 'zchee/deoplete-go', {'build': {'unix': 'make'}}
 Plug 'sebastianmarkow/deoplete-rust'
 Plug 'jodosha/vim-godebug' " Debugger integration via delve
endif

" Initialize plugin system
call plug#end()

"Deoplete Rust
let g:deoplete#sources#rust#racer_binary='/Users/myair/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path='/Users/myair/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src'

let g:rustfmt_autosave = 1

"GO
au FileType go nmap <Leader>gor :GoRun<CR>
au FileType go nmap <Leader>gb  :GoBuild<CR>
au FileType go nmap <Leader>gi :GoInstall<CR>
au FileType go nmap <leader>gt :GoTest<CR>
au FileType go nmap <leader>goc <Plug>(go-coverage)

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>e <Plug>(go-rename)

let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_completion_start_length = 1
let g:deoplete#omni#input_patterns = get(g:,'deoplete#omni#input_patterns',{})
call deoplete#custom#set('_', 'matchers', ['matcher_full_fuzzy'])
let g:deoplete#omni#functions = {}

"JS
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
  \ 'jspc#omni'
\]
set completeopt=longest,menuone,preview
let g:deoplete#sources = {}
let g:deoplete#sources['javascript.jsx'] = ['buffer', 'file', 'ultisnips', 'ternjs']
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']

"go
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#use_cache = 1
let g:deoplete#sources#go#json_directory = '~/.cache/deoplete/go/$GOOS_$GOARCH'

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

:tnoremap <Esc> <C-\><C-n>

"Disable preview window on top for YouAutoCompleteMe
set completeopt-=preview

"Mappings
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :wq<CR>
nnoremap <leader>h :hide<CR>  
nnoremap <leader>t :term<CR>

nnoremap \ :NERDTreeToggle<CR>  
map <leader>r :NERDTreeFind<cr>

autocmd VimEnter * nnoremap <C-l> :vertical resize +10<CR>

nnoremap <silent> <C-L> :noh<CR>
nmap K <Plug>(devdocs-under-cursor)

nmap <Leader>r<CR> *:%s///g<left><left>
nmap <Leader>rc<CR> *:%s///gc<left><left><left>

cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' : '%%'

nmap <F8> :TagbarToggle<CR>

map <M-K> <C-W>j<C-W>_
map <M-K> <C-W>k<C-W>_

noremap <silent><Leader>/ :nohls<CR>

" Visual mode pressing * or # searches for the current selection
" " Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

"Paste yanked text
noremap <Leader>p "0p
noremap <Leader>P "0P
vnoremap <Leader>p "0p

"Automatically jump to the end of text pasted
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

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

" Fuzzy file finder
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
let g:fzf_layout = { 'down': '~25%' }
nnoremap <C-p> :FZF -m<CR>
nnoremap <leader>b :Buffers<CR>  
nnoremap <leader>l :Lines<CR>  
nnoremap <leader>c :Commits<CR>  
nnoremap <leader>ch :History:<CR>  

"using rg for find in project
let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,rs,go,rb,swift}"
  \ -g "!{.git,node_modules,vendor,log,swp}/*" '
command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)
nnoremap <leader>f :F<CR>

"FZF using zsh config for finding and theme

"incsearch.vim
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

"EasyAlign
nmap ga :EasyAlign
xmap ga :EasyAlign

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_mode_map = { 'passive_filetypes': ['html', 'css', 'leaf'] }

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"Visual Selection
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

au BufRead,BufNewFile Podfile set filetype=ruby
au BufRead,BufNewFile Dangerfile set filetype=ruby

au BufRead,BufNewFile *.gohtml set filetype=html
au BufRead,BufNewFile *.pbxproj set syntax=xml

autocmd BufWinEnter,WinEnter term://* startinsert
autocmd VimResized * wincmd =

syntax enable
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
set background=dark
colorscheme nova
