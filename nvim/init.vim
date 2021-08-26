set nocompatible              " be iMproved, required
filetype off                  " required

let g:python3_host_prog = "/Users/vladsomov/anaconda3/bin/python3"
let g:black_virtualenv = "/Users/vladsomov/anaconda3"

syntax enable
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

set title
set titlestring=%F

set laststatus=0

language en_US
set hls
set backspace=indent,eol,start
set mouse=a
set clipboard=unnamed
set number

set relativenumber
set lazyredraw
set regexpengine=1

set ignorecase
set smartcase
set foldmethod=indent
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

nnoremap ,, :noh<CR>

call plug#begin('~/.config/nvim/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'yggdroot/indentline'

Plug 'justinmk/vim-dirvish'
  let dirvish_mode = ':sort | sort ,^.*/,'
  nnoremap \ :Dirvish<cr>
  autocmd! FileType dirvish setlocal relativenumber

Plug 'aklt/plantuml-syntax'
  if exists("g:loaded_plantuml_plugin")
      finish
  endif
  let g:loaded_plantuml_plugin = 1

  if !exists("g:plantuml_executable_script")
    let g:plantuml_executable_script='java -jar /Users/vladsomov/Developer/sources/plantuml.jar'
  endif
  let s:makecommand=g:plantuml_executable_script." %"

  " command! Make silent lua require'async_make'.make()

  " define a sensible makeprg for plantuml files
  autocmd Filetype plantuml let &l:makeprg=s:makecommand
  " au BufWritePost *.plantuml silent make

Plug 'foosoft/vim-argwrap'
  nmap <Leader>a :ArgWrap<CR>

" tpope
Plug 'tpope/vim-fugitive'
  autocmd BufReadPost fugitive://* set bufhidden=delete

Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'

"Mappings
command! -nargs=* VT vsplit | terminal <args>
command! -nargs=* ST split | terminal <args>

function! RunInTerminal(cmd)
  if has("nvim")
    exec("tabedit \| term " . a:cmd)
    startinsert
  else
    exec("tab terminal " . a:cmd)
  endif
endfunction

Plug 'tpope/vim-projectionist'
  nnoremap <leader>s. :AV<cr>
  nnoremap <leader>. :A<cr>
  nnoremap ,m :call RunInTerminal(&makeprg)<cr>
  nnoremap ,. :call RunInTerminal(&makeprg . ":" . line('.'))<cr>
  nnoremap ,a :call RunInTerminal(&makeprg . " --only-failures")<cr>


Plug 'vim-ruby/vim-ruby'
  let g:ruby_indent_assignment_style = 'variable'

" js
Plug 'kchmck/vim-coffee-script'

" Plug 'sbdchd/neoformat'
" Plug 'flowtype/vim-flow'
" Plug 'othree/yajs.vim', { 'for': 'typescript' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'peitalin/vim-jsx-typescript', { 'for': 'typescript' }
Plug 'HerringtonDarkholme/yats.vim', { 'for': 'typescript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'eliba2/vim-node-inspect'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
  let g:coc_node_path = '/Users/vladsomov/.nvm/versions/node/v10.19.0/bin/node'
  let g:coc_global_extensions = [
    \ 'coc-tsserver'
    \ ]

  if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
    let g:coc_global_extensions += ['coc-prettier']
  endif

  if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
    let g:coc_global_extensions += ['coc-eslint']
  endif

  au BufNewFile,BufRead *.ts set filetype=typescript

  augroup js_mappings
    autocmd!


    autocmd FileType typescript,javascript nnoremap <silent> K :call CocAction('doHover')<CR>
    autocmd FileType typescript,javascript nmap <silent> gd <Plug>(coc-definition)
    autocmd FileType typescript,javascript nmap <silent> gt :call CocAction('jumpDefinition', 'tabe')<CR>
    autocmd FileType typescript,javascript nmap <silent> gs :call CocAction('jumpDefinition', 'vsplit')<CR>
    autocmd FileType typescript,javascript nmap <silent> gv :call CocAction('jumpDefinition', 'split')<CR>
    autocmd FileType typescript,javascript nmap <silent> gy <Plug>(coc-type-definition)
    autocmd FileType typescript,javascript nmap <silent> gr <Plug>(coc-references)
    autocmd FileType typescript,javascript nmap <silent> [g <Plug>(coc-diagnostic-prev)
    autocmd FileType typescript,javascript nmap <silent> ]g <Plug>(coc-diagnostic-next)
    autocmd FileType typescript,javascript nmap <leader>ca <Plug>(coc-codeaction)
    autocmd FileType typescript,javascript nmap <silent> gi <Plug>(coc-implementation)
    autocmd FileType typescript,javascript xmap <leader>cs  <Plug>(coc-codeaction-selected)
    autocmd FileType typescript,javascript nmap <leader>cs  <Plug>(coc-codeaction-selected)
  augroup END

Plug 'digitaltoad/vim-pug'
Plug 'mustache/vim-mode'

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
  let g:go_def_mapping_enabled = 0
  let g:go_doc_keywordprg_enabled = 0
  let g:go_term_mode = "split"
  let g:go_list_type = "quickfix"
  let g:go_list_type_commands = {
    \ "GoBuild": "quickfix",
    \ }

  au FileType go nmap gr <Plug>(go-run)
  au FileType go nmap gb <Plug>(go-build)
  au FileType go nmap gt <Plug>(go-test)
  au FileType go nmap gi <Plug>(go-install)

  au FileType go nmap gd <Plug>(go-def-vertical)
  au FileType go nmap gs <Plug>(go-implements)
  au FileType go nmap ge <Plug>(go-rename)


Plug 'slashmili/alchemist.vim'
Plug 'elixir-editors/vim-elixir'

Plug 'ervandew/supertab'
  let g:loaded_ruby_provider = 1
  let g:SuperTabDefaultCompletionType = 'context'
  let g:SuperTabContextDefaultCompletionType = '<c-n>'

if has('nvim')
  Plug 'sebdah/vim-delve', { 'for': 'go' }
endif

Plug 'hdima/python-syntax', { 'for': 'python' }
  let python_highlight_all = 1
Plug 'python/black', { 'for': 'python', 'branch': 'stable'}
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
set tags+=~/.rubies/ruby-2.5.7/tags,~/src/ruby-2.5.7/tags
set tagcase=match
noremap ,gt :!gentags<CR>

colorscheme solarized
set background=light
let g:solarized_bold=1

" Breakpoints
autocmd! FileType python nnoremap ,b Obreakpoint()<ESC>
autocmd! FileType ruby nnoremap ,b Obinding.pry<ESC>
autocmd! FileType coffee nnoremap ,b Odebugger;<ESC>
autocmd! FileType javascript nnoremap ,b Odebugger;<ESC>
autocmd! FileType typescript nnoremap ,b Odebugger;<ESC>
autocmd! FileType go nnoremap ,b :GoDebugBreakpoint<CR>

nnoremap <Leader>t :tabnew %<CR>

" Tabular

" AddTabularPattern! colons    /^[^:]*:\s*\zs\s/l0
vmap ,: :Tabularize /^[^:]*:\s*\zs\s/l0<CR>
vmap ,": :Tabularize /":\zs/l0l1<CR>
vmap ,=  :Tabularize /=<CR>
vmap ,{  :Tabularize /{<CR>
vmap ,eq  :Tabularize /eq(/l1r0<CR>
vmap ,=> :Tabularize /=>/l1l1<CR>
vmap ,,  :Tabularize /,\zs/l1r0<CR>

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

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

" Fuzzy file finder
let g:fzf_action = {
      \ 'ctrl-q': function('s:build_quickfix_list'),
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
let g:fzf_layout = { 'down': '~25%' }
let g:fzf_preview_window = ['right:50%', 'ctrl-/']

imap <c-x><c-l> <plug>(fzf-complete-line)
nnoremap <C-p> :Files<CR>
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
  \ -g "*.{ts,coffee,haml,hamlc,erb,js,json,rs,go,rb,py,swift,scss,c}"
  \ -g "!{.git,node_modules,dist,vendor,log,swp,tmp,venv,__pychache__,pyc}/*" '

command! -bang -nargs=* F
                 \ call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1,
                 \ fzf#vim#with_preview({'options': '--bind ctrl-a:select-all,ctrl-d:deselect-all --delimiter : --nth 4..'}, 'right:50%:hidden', 'ctrl-/'),
                 \ <bang>0)
nnoremap <leader>f :F<CR>

command! -bang -nargs=* FF
                 \ call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1,
                 \ fzf#vim#with_preview({'options': '--bind ctrl-a:select-all,ctrl-d:deselect-all'}, 'right:50%:hidden', 'ctrl-/'),
                 \ <bang>0)
nnoremap ,f :FF<CR>

command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \ 'rg --column --line-number --no-heading --color=always --ignore-case '.shellescape(<q-args>), 0,
      \ fzf#vim#with_preview({'options': '--bind ctrl-a:select-all,ctrl-d:deselect-all'}, 'right:50%:hidden', 'ctrl-/'),
      \ <bang>0)

nnoremap <leader>rg :Rg <C-R><C-W><CR>
vnoremap <leader>rg y:Rg <C-R>"<CR>

nnoremap <leader>rt :Tags ' <C-R><C-W><CR>
vnoremap <leader>rt y:Tags ' <C-R>"<CR>
if executable('rg')
    set grepprg=rg\ --no-heading\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

"incsearch.vim
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

nnoremap ,r :redraw! <CR>

autocmd VimResized * wincmd =
autocmd BufWritePre * :%s/\s\+$//e " Delete trailing spaces on save

command! Notes :exe "e " . ".git/notes.md"
command! TODO  :exe "e " . ".git/notes.md"
command! Scratch :exe "e " . "~/.scratch/" . strftime('%Y-%m-%d') . ".txt"
command! Presentations :exe "e " . "~/.presentations.md"

augroup filetype
  au! BufRead,BufNewFile *.proto set filetype=proto
  au BufRead,BufNewFile Podfile set filetype=ruby
  au BufRead,BufNewFile Dangerfile set filetype=ruby
  au BufRead,BufNewFile Fastfile set filetype=ruby

  au BufRead,BufNewFile *.gohtml set filetype=html
  au BufRead,BufNewFile *.pbxproj set syntax=xml
  au BufRead,BufNewFile *.pcss set filetype=scss

  au BufRead,BufNewFile *.hamlc setlocal ft=haml
  au BufRead /tmp/psql.edit.* set syntax=sql

  au FileType sql setl formatprg=/usr/local/bin/pg_format\ -
augroup end

"Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Highlight merge conflict markers
match Todo '\v^(\<|\=|\>){7}([^=].+)?$'

" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
" ## added by OPAM user-setup for vim / ocp-indent ## d15857f7143dafc7a27a7a0f099b8f7d ## you can edit, but keep this line
if count(s:opam_available_tools,"ocp-indent") == 0
  source "/Users/vladsomov/.opam/default/share/ocp-indent/vim/indent/ocaml.vim"
endif
" ## end of OPAM user-setup addition for vim / ocp-indent ## keep this line


:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>


:tnoremap <Esc> <C-\><C-n>

" Vertical separator style
hi VertSplit ctermbg=NONE guibg=NONE
set fillchars+=vert:\|

