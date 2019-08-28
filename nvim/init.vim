set nocompatible              " be iMproved, required
filetype off                  " required

let g:python3_host_prog = "/Users/vladsomov/anaconda3/bin/python3"
let g:black_virtualenv = "/Users/vladsomov/anaconda3"

syntax enable
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

set title
set titlestring=%F

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
set wrap "Wrap lines

set sw=2 ts=2 sts=2
au FileType go setl noexpandtab sw=4 sts=4 ts=4
au FileType python setl sw=4 sts=4 ts=4 tw=79
au FileType swift setl sw=2 sts=2 ts=2
au FileType rb setl expandtab sw=2 sts=2 ts=2 tw=79

set expandtab
set splitright
set splitbelow

" Undo
set undofile
set undodir=$HOME/.nvim/undo

let mapleader = "\<Space>"

" Search result to the center
nnoremap n nzz
nnoremap N Nzz

noremap <up>    <C-W>+
noremap <down>  <C-W>-
noremap <left>  3<C-W><
noremap <right> 3<C-W>>

call plug#begin('~/.config/nvim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug 'yggdroot/indentline'

Plug 'justinmk/vim-dirvish'
  let dirvish_mode = ':sort | sort ,^.*/,'
  nnoremap \ :Dirvish<cr>
  autocmd! FileType dirvish setlocal relativenumber

Plug 'aklt/plantuml-syntax'
let g:plantuml_executable_script='java -jar /Users/vladsomov/Developer/plantuml.jar'

Plug 'foosoft/vim-argwrap'
  nmap <Leader>a :ArgWrap<CR>

" tpope
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'

Plug 'vim-ruby/vim-ruby'
  let g:ruby_indent_assignment_style = 'variable'

" js
Plug 'kchmck/vim-coffee-script'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'sbdchd/neoformat'
Plug 'flowtype/vim-flow'

Plug 'scrooloose/nerdcommenter'
  let g:NERDSpaceDelims = 1

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'haya14busa/incsearch.vim'
Plug 'jszakmeister/vim-togglecursor'
Plug 'godlygeek/tabular'

" rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'cespare/vim-toml', { 'for': 'rust' }

Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }

Plug 'slashmili/alchemist.vim'
Plug 'elixir-editors/vim-elixir'

Plug 'ervandew/supertab'
  let g:loaded_ruby_provider = 1
  let g:SuperTabDefaultCompletionType = 'context'
  let g:SuperTabContextDefaultCompletionType = '<c-n>'

if has('nvim')
  Plug 'sebdah/vim-delve'
endif

Plug 'hdima/python-syntax', { 'for': 'python' }
  let python_highlight_all = 1
Plug 'python/black'
  autocmd BufWritePre *.py execute ':Black'

Plug 'christoomey/vim-tmux-navigator'

call plug#end()

let g:flow#autoclose = 1

set completeopt-=menu
set completeopt+=menuone   " show the popup menu even when there is only 1 match
set completeopt-=longest   " don't insert the longest common text
set completeopt-=preview   " don't show preview window
" set completeopt+=noinsert  " don't insert any text until user chooses a match
set completeopt-=noselect  " select first match
set pumheight=10

cnoremap <expr> %% expand('%:h').'/'
nnoremap <leader>cd :lcd %:p:h<CR>:pwd<CR>

set shell=zsh
set tags+=.git/tags,.git/rubytags,.git/bundlertags
set tags+=~/.rubies/ruby-2.4.5/tags,~/src/ruby-2.4.5/tags
set tagcase=match
noremap ,gt :!gentags<CR>

colorscheme solarized
set background=light
let g:solarized_bold=1

" Breakpoints
autocmd! FileType python nnoremap ,b Obreakpoint()<ESC>
autocmd! FileType ruby nnoremap ,b Obinding.pry<ESC>
autocmd! FileType coffee nnoremap ,b Odebugger;<ESC>

nnoremap ,f :tabnew %<CR>

" Tabular
vmap ,:  :Tabularize /:\zs/l0l1<CR>
vmap ,": :Tabularize /":\zs/l0l1<CR>
vmap ,=  :Tabularize /=<CR>
vmap ,{  :Tabularize /{<CR>
vmap ,=> :Tabularize /=>/l1l1<CR>
vmap ,,  :Tabularize /,\zs/l1r0<CR>

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

nnoremap <leader><leader> :e #<CR>

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :wq<CR>
nnoremap <Leader>x :bd!<CR>
nnoremap <leader>h :hide<CR>
nnoremap <leader>o :only<CR>

nmap <Leader>r<CR> *:%s///g<left><left>
nmap <Leader>rc<CR> *:%s///gc<left><left><left>
nmap <Leader>gn<CR> *:%s///gn<CR>

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
nnoremap <leader>co :Commits<CR>
nnoremap <leader>ch :History:<CR>
nnoremap ,t :Tags<CR>
nnoremap <leader>d :BTags<CR>

nnoremap <silent> gqaj :%!jq '.'<CR>
command! -nargs=* JQFind :new | :read !jq <args> #

vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>
"using rg for find in project
let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{coffee,haml,hamlc,erb,js,json,rs,go,rb,py,swift,scss}"
  \ -g "!{.git,node_modules,vendor,log,swp,tmp,venv,__pychache__,pyc}/*" '

command! -bang -nargs=* F
                 \ call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1,
                 \ fzf#vim#with_preview({'options': '--bind ctrl-a:select-all,ctrl-d:deselect-all --delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
                 \ <bang>0)
nnoremap <leader>f :F<CR>

command! -bang -nargs=* FF
                 \ call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1,
                 \ fzf#vim#with_preview({'options': '--bind ctrl-a:select-all,ctrl-d:deselect-all'}, 'right:50%:hidden', '?'),
                 \ <bang>0)
nnoremap ,f :FF<CR>

command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \ 'rg --column --line-number --no-heading --color=always --ignore-case '.shellescape(<q-args>), 0,
      \ fzf#vim#with_preview({'options': '--bind ctrl-a:select-all,ctrl-d:deselect-all'}, 'right:50%:hidden', '?'),
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

" Auto-format on save
augroup fmt
  autocmd!
  autocmd BufWritePre *.js,*.jsx Neoformat prettier
augroup END

nnoremap ,r :redraw! <CR>
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd VimResized * wincmd =
autocmd BufWritePre * :%s/\s\+$//e " Delete trailing spaces on save

command! Scratch :exe "e " . "~/.scratch/" . strftime('%Y-%m-%d') . ".txt"

augroup filetype
  au! BufRead,BufNewFile *.proto set filetype=proto
  au BufRead,BufNewFile Podfile set filetype=ruby
  au BufRead,BufNewFile Dangerfile set filetype=ruby
  au BufRead,BufNewFile Fastfile set filetype=ruby

  au BufRead,BufNewFile *.gohtml set filetype=html
  au BufRead,BufNewFile *.pbxproj set syntax=xml

  au BufRead,BufNewFile *.hamlc setlocal ft=haml
  au BufRead /tmp/psql.edit.* set syntax=sql

  au FileType sql setl formatprg=/usr/local/Cellar/pgformatter/3.0/bin/pg_format\ -
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
  let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<workers\>') != -1 || match(current_file, '\<views\>') != -1 || match(current_file, '\<helpers\>') != -1 || match(current_file, '\<services\>') != -1

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

"Mappings
command! -nargs=* VT vsplit | terminal <args>
command! -nargs=* ST split | terminal <args>

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

