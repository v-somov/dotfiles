set nocompatible              " be iMproved, required
filetype off                  " required

syntax enable
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
set background=dark

language en_US
set hls
set backspace=indent,eol,start
set mouse=a
set clipboard=unnamed
set number
set relativenumber
set ignorecase
set smartcase
set nofoldenable

set nobackup
set nowb
set noswapfile

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

set sw=2 ts=2 sts=2
au FileType go setl sw=4 sts=4 ts=4
au FileType swift setl sw=4 sts=4 ts=4
au FileType py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79

set expandtab

" Undo
set undofile
set undodir=$HOME/.vim/undo

let mapleader = "\<Space>"

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Search result to the center
nnoremap n nzz
nnoremap N Nzz

noremap <up>    <C-W>+
noremap <down>  <C-W>-
noremap <left>  3<C-W><
noremap <right> 3<C-W>>

call plug#begin('~/.config/nvim/plugged')

Plug 'mhinz/vim-startify'

Plug 'keith/swift.vim', { 'for': 'swift' }

Plug 'trevordmiller/nova-vim'
Plug 'hzchirs/vim-material'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'junegunn/vim-easy-align'
Plug 'foosoft/vim-argwrap'

"tpope
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-jdaddy'

Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
Plug 'haya14busa/incsearch.vim'
Plug 'jszakmeister/vim-togglecursor'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'terryma/vim-expand-region'
Plug 'majutsushi/tagbar'

Plug 'w0rp/ale'
Plug 'tomlion/vim-solidity'

Plug 'junegunn/goyo.vim'
nnoremap <leader>gg :Goyo<CR>

"rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'cespare/vim-toml', { 'for': 'rust' }

"JS
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
"let g:jsx_ext_required = 0 " Allow JSX in normal JS files
Plug 'ternjs/tern_for_vim', { 'do': 'npm install && npm install -g tern', 'for': ['javascript', 'javascript.jsx'] }
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }

Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }
Plug 'nsf/gocode', { 'for': 'go' }
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'zchee/deoplete-go', {'build': {'unix': 'make'}, 'for': 'go' }
  Plug 'jodosha/vim-godebug', { 'for': 'go' } " Debugger integration via delve
  Plug 'zchee/deoplete-jedi'
endif

"Python
"Plug 'python-mode/python-mode', { 'branch': 'develop' }
"let g:pymode_python = 'python3'
"let g:pymode_rope_completion = 1
"let g:pymode_syntax = 1
"let g:pymode_rope_complete_on_dot = 0
"let g:pymode_lint = 0
"let g:pymode_indent = 1
Plug 'hdima/python-syntax'
let python_highlight_all = 1
Plug 'hkupty/iron.nvim', { 'do': ':UpdateRemotePlugins' }

"Plug 'google/yapf', { 'rtp': 'plugins/vim', 'for': 'python' }
"map <C-Y> :call yapf#YAPF()<cr>
"imap <C-Y> <c-o>:call yapf#YAPF()<cr><Paste>

"Ruby
"Plug 'tpope/vim-rails'
"Plug 'thoughtbot/vim-rspec'

" Initialize plugin system
call plug#end()

colorscheme vim-material

"ale
" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_fixers = {
\   'go': ['gofmt', 'goimports'],
\}
let g:ale_fix_on_save = 1

"GO
au FileType go nmap <Leader>gor <Plug>(go-run-vertical)
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
let g:go_auto_sameids = 1
let g:go_auto_type_info = 1
let g:go_term_enabled = 1

"Deoplete
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

nnoremap <leader><leader> :e #<CR>

imap <c-x><c-l> <plug>(fzf-complete-line)

"Mappings
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :wq<CR>
nnoremap <Leader>x :q!<CR>
nnoremap <leader>h :hide<CR>  
nnoremap <leader>o :only<CR>  
nnoremap <leader>t :vsplit term://$SHELL<CR>

"NERDTree
nnoremap \ :NERDTreeToggle<CR>  
map <leader>r :NERDTreeFind<cr>

"nnoremap <silent> <C-L> :noh<CR>
"nmap K <Plug>(devdocs-under-cursor)

nmap <Leader>r<CR> *:%s///g<left><left>
nmap <Leader>rc<CR> *:%s///gc<left><left><left>

cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' : '%%'

nmap <leader>\ :TagbarToggle<CR>

map <M-K> <C-W>j<C-W>_
map <M-K> <C-W>k<C-W>_

noremap <silent><Leader>/ :nohls<CR>

" Visual mode pressing * or # searches for the current selection
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
  \ -g "*.{js,json,rs,go,rb,swift,scss}"
  \ -g "!{.git,node_modules,vendor,log,swp,tmp}/*" '
command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)
nnoremap <leader>f :F<CR>

command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --ignore-case '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

nnoremap <leader>rg :Rg <C-R><C-W><CR> 

if executable('rg')
    set grepprg=rg\ --no-heading\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif
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

au BufRead,BufNewFile Podfile set filetype=ruby
au BufRead,BufNewFile Dangerfile set filetype=ruby
au BufRead,BufNewFile Fastfile set filetype=ruby

au BufRead,BufNewFile *.gohtml set filetype=html
au BufRead,BufNewFile *.pbxproj set syntax=xml

autocmd BufWinEnter,WinEnter term://* startinsert
autocmd VimResized * wincmd =

augroup filetype
  au! BufRead,BufNewFile *.proto setfiletype proto
augroup end

"Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


"colorscheme nova

" Set status line
"hi slred guifg=#9D86DE guibg=#232526 gui=bold
"hi slgrn guifg=#A6E22E guibg=#232526 gui=bold
"hi slorg guifg=#7AA8E1 guibg=#232526 gui=bold
"hi slblu guifg=#9D86DE guibg=#232526 gui=bold

"set statusline=%#slorg#%{getcwd()}%=%#slred#\ PERM=%{getfperm(expand('%'))}\ TYPE=%Y\ %#slgrn#\ LINE=%l/%L\ COL=%v\ |

" Function: display errors from Ale in statusline
function! LinterStatus() abort
	 let l:counts = ale#statusline#Count(bufnr(''))
	 let l:all_errors = l:counts.error + l:counts.style_error
	 let l:all_non_errors = l:counts.total - l:all_errors
	 return l:counts.total == 0 ? '' : printf(
	 \ 'W:%d E:%d',
	 \ l:all_non_errors,
	 \ l:all_errors
	 \)
endfunction

set laststatus=2
set statusline=
set statusline+=%2*\ %l
set statusline+=\ %*
set statusline+=%1*\ ‹‹
set statusline+=%1*\ %f\ %*
set statusline+=%1*\ ››
set statusline+=%1*\ %m
set statusline+=%3*\ %F
set statusline+=%=
set statusline+=%3*\ %{LinterStatus()}
set statusline+=%3*\ ‹‹
set statusline+=%3*\ %{strftime('%R',getftime(expand('%')))}
set statusline+=%3*\ ::
set statusline+=%3*\ %n
set statusline+=%3*\ ››\ %*
hi User1 guifg=#FFFFFF guibg=#3E4B54 gui=BOLD
hi User2 guifg=#000000 guibg=#84ABF8
hi User3 guifg=#000000 guibg=#CBE594 

" Highlight merge conflict markers
match Todo '\v^(\<|\=|\>){7}([^=].+)?$'

" Jump to next/previous merge conflict marker
nnoremap <silent> ]c /\v^(\<\|\=\|\>){7}([^=].+)?$<CR>
nnoremap <silent> [c ?\v^(\<\|\=\|\>){7}([^=].+)\?$<CR>

let g:netrw_liststyle=3

 "Format the status line
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
		autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

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

