set nocompatible              " be iMproved, required
filetype off                  " required

let g:python3_host_prog = "/usr/local/bin/python3"

syntax enable
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

set laststatus=0
set lazyredraw

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
set noerrorbells                  " No bells!
set novisualbell                  " I said, no bells!
set autowrite

" set ai "Auto indent
" set si "Smart indent
set wrap "Wrap lines

set sw=2 ts=2 sts=2
au FileType go setl noexpandtab sw=4 sts=4 ts=4
au FileType python setl sw=4 sts=4 ts=4 tw=79
au FileType swift setl sw=2 sts=2 ts=2
au FileType rb setl expandtab sw=2 sts=2 ts=2 tw=79

set expandtab
set splitright
set splitbelow

autocmd BufEnter * highlight OverLength ctermbg=7 guibg=Grey30
autocmd BufEnter * match OverLength /\%81v.*/

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

Plug 'keith/swift.vim', { 'for': 'swift' }

Plug 'altercation/vim-colors-solarized'
Plug 'yggdroot/indentline'

Plug 'tpope/vim-eunuch'
Plug 'justinmk/vim-dirvish'
  let dirvish_mode = ':sort | sort ,^.*/,'
  nnoremap \ :Dirvish<cr>
autocmd! FileType dirvish setlocal relativenumber


Plug 'foosoft/vim-argwrap'
nmap <Leader>a :ArgWrap<CR>

" tpope
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-endwise'

Plug 'vim-ruby/vim-ruby'
let g:ruby_indent_assignment_style = 'variable'

" js
Plug 'kchmck/vim-coffee-script'
Plug 'posva/vim-vue'

Plug 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims = 1

Plug 'aklt/plantuml-syntax'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'haya14busa/incsearch.vim'
Plug 'jszakmeister/vim-togglecursor'
Plug 'godlygeek/tabular'

Plug 'w0rp/ale'

" rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'cespare/vim-toml', { 'for': 'rust' }

Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }
Plug 'nsf/gocode', { 'for': 'go' }

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'Shougo/neosnippet'
  Plug 'Shougo/neosnippet-snippets'
  Plug 'zchee/deoplete-go', {'build': {'unix': 'make'}, 'for': 'go' }
  Plug 'jodosha/vim-godebug', { 'for': 'go' } " Debugger integration via delve
  Plug 'zchee/deoplete-jedi'
endif

Plug 'hdima/python-syntax', { 'for': 'python' }
let python_highlight_all = 1
Plug 'ambv/black', { 'for': 'python' }

Plug 'christoomey/vim-tmux-navigator'

call plug#end()

cnoremap <expr> %% expand('%:h').'/'

set shell=zsh
set tags+=.git/tags,.git/rubytags,.git/bundlertags
set tagcase=match
noremap ,gt :!gentags<CR>

colorscheme solarized
set background=light
let g:solarized_bold=1

" Breakpoints
autocmd! FileType python nnoremap ,b Oimport ipdb; ipdb.set_trace()<ESC>
autocmd! FileType ruby nnoremap ,b Obinding.pry<ESC>
autocmd! FileType coffee nnoremap ,b Odebugger;<ESC>

nnoremap ,f :tabnew %<CR>

" Tabular
vmap ,:  :Tabularize /:\zs/l0l1<CR>
vmap ,": :Tabularize /":\zs/l0l1<CR>
vmap ,=  :Tabularize /=<CR>
vmap ,=> :Tabularize /=/l1l1<CR>

" ALE
" Error and warning signs.
let g:ale_sign_error = 'E'
let g:ale_sign_warning = '⚠'
let g:ale_change_sign_column_color = 1

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
au FileType go nmap <leader>ga :GoAlternate<CR>
au FileType go nmap <leader>goc <Plug>(go-coverage)

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>e <Plug>(go-rename)

let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_fields = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
" let g:go_auto_sameids = 1
let g:go_auto_type_info = 1
let g:go_term_enabled = 1

"Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_completion_start_length = 1
let g:deoplete#omni#input_patterns = get(g:,'deoplete#omni#input_patterns',{})
call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
let g:deoplete#omni#functions = {}

set completeopt-=preview

" neosnippet
let g:neosnippet#enable_completed_snippet = 1
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

"Go Deoplete
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#use_cache = 1
let g:deoplete#sources#go#json_directory = '~/.cache/deoplete/go/$GOOS_$GOARCH'

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

:tnoremap <Esc> <C-\><C-n>

nnoremap <leader><leader> :e #<CR>

"Mappings
command! -nargs=* VT vsplit | terminal <args>
command! -nargs=* ST split | terminal <args>

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :wq<CR>
nnoremap <Leader>x :bd!<CR>
nnoremap <leader>h :hide<CR>
nnoremap <leader>o :only<CR>
nnoremap <leader>t :VT<CR>

nmap <Leader>r<CR> *:%s///g<left><left>
nmap <Leader>rc<CR> *:%s///gc<left><left><left>

"Paste yanked text
noremap <Leader>p "0p
noremap <Leader>P "0P
vnoremap <Leader>p "0p

"Automatically jump to the end of text pasted
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Ruby
command! Symbolicate  :%s/"\([a-z_]\+\)"/:\1/gc
command! Stringify    :%s/:\([a-z_]\+\)/"\1"/gc
command! NewHash      :%s/"\([^=,'"]*\)"\s\+=> /\1: /gc
command! OldHash      :%s/\(\w*\): \(\w*\)/"\1" => \2/gc

" Fuzzy file finder
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
let g:fzf_layout = { 'down': '~25%' }

imap <c-x><c-l> <plug>(fzf-complete-line)
nnoremap <C-p> :FZF -m<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>l :Lines<CR>
nnoremap <leader>c :Commits<CR>
nnoremap <leader>ch :History:<CR>
nnoremap ,t :Tags<CR>

vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

"using rg for find in project
let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{coffee,haml,hamlc,js,json,rs,go,rb,py,swift,scss}"
  \ -g "!{.git,node_modules,vendor,log,swp,tmp,venv,__pychache__}/*" '
command! -bang -nargs=* F
                 \ call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1,
                 \ fzf#vim#with_preview(),
                 \ <bang>0)
nnoremap <leader>f :F<CR>

command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \ 'rg --column --line-number --no-heading --color=always --ignore-case '.shellescape(<q-args>), 1,
      \ fzf#vim#with_preview(),
      \ <bang>0)

nnoremap <leader>rg :Rg <C-R><C-W><CR>
vnoremap <leader>rg y:Rg <C-R>"<CR>

if executable('rg')
    set grepprg=rg\ --no-heading\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

"incsearch.vim
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)


autocmd BufWinEnter,WinEnter term://* startinsert
autocmd VimResized * wincmd =
autocmd BufWritePre * :%s/\s\+$//e " Delete trailing spaces on save

augroup filetype
  au! BufRead,BufNewFile *.proto set filetype=proto
  au BufRead,BufNewFile Podfile set filetype=ruby
  au BufRead,BufNewFile Dangerfile set filetype=ruby
  au BufRead,BufNewFile Fastfile set filetype=ruby

  au BufRead,BufNewFile *.gohtml set filetype=html
  au BufRead,BufNewFile *.pbxproj set syntax=xml

  au BufRead,BufNewFile *.hamlc setlocal ft=haml
  au BufRead /tmp/psql.edit.* set syntax=sql
augroup end

"Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Highlight merge conflict markers
match Todo '\v^(\<|\=|\>){7}([^=].+)?$'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SWITCH BETWEEN TEST AND PRODUCTION CODE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction
function! OpenTestAlternateSplit()
  let new_file = AlternateForCurrentFile()
  exec ':vsp ' . new_file
endfunction
function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let going_to_spec = !in_spec
  let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<workers\>') != -1 || match(current_file, '\<views\>') != -1 || match(current_file, '\<helpers\>') != -1
  if going_to_spec
    if in_app
      let new_file = substitute(new_file, '^app/', '', '')
    end
    let new_file = substitute(new_file, '\.e\?rb$', '_spec.rb', '')
    let new_file = 'spec/' . new_file
  else
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
    if in_app
      let new_file = 'app/' . new_file
    end
  endif

  return new_file
endfunction

nnoremap <leader>. :call OpenTestAlternate()<cr>
nnoremap <leader>s. :call OpenTestAlternateSplit()<cr>

function! RunTests(filename)
    " Write the file and run tests for the given filename
    :w
    :silent !echo;echo;echo;echo;echo
    exec ":ST time bundle exec rspec " . a:filename
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_spec_file = match(expand("%"), '_spec.rb$') != -1
    if in_spec_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number)
endfunction

" Run this file
map ,m :call RunTestFile()<cr>
" Run only the example under the cursor
map ,. :call RunNearestTest()<cr>
" Run all test files
map ,a :call RunTests('spec')<cr>
" noremap ,a :ST bundle exec rspec %<CR>

