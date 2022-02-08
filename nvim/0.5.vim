set nocompatible              " be iMproved, required
filetype off                  " required

set title
set titlestring=%F

set laststatus=0

set hls
set backspace=indent,eol,start
set mouse=a
set clipboard=unnamed

set number
set relativenumber

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
set undodir=$HOME/.nvim/undo-0.5

let mapleader = "\<Space>"

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

  " tpope
  Plug 'tpope/vim-fugitive'
    autocmd BufReadPost fugitive://* set bufhidden=delete

  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-bundler'
  Plug 'tpope/vim-eunuch'

  Plug 'hrsh7th/nvim-compe'

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'foosoft/vim-argwrap'
    nmap <Leader>a :ArgWrap<CR>

  Plug 'ervandew/supertab'
    let g:loaded_ruby_provider = 0
    let g:SuperTabDefaultCompletionType = 'context'
    let g:SuperTabContextDefaultCompletionType = '<c-n>'

  Plug 'christoomey/vim-tmux-navigator'

  Plug 'justinmk/vim-dirvish'
    let dirvish_mode = ':sort | sort ,^.*/,'
    nnoremap \ :Dirvish<cr>
    autocmd! FileType dirvish setlocal relativenumber

  Plug 'scrooloose/nerdcommenter'
    let g:NERDSpaceDelims = 1

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

  Plug 'haya14busa/incsearch.vim'
  Plug 'jszakmeister/vim-togglecursor'
  Plug 'godlygeek/tabular'
call plug#end()

set shell=zsh

cnoremap <expr> %% expand('%:h').'/'
nnoremap <leader>cd :lcd %:p:h<CR>:pwd<CR>

nnoremap <leader><leader> :e #<CR>

nnoremap <Leader>t :tabnew %<CR>

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :wq<CR>
nnoremap <Leader>x :bd!<CR>
nnoremap <leader>h :hide<CR>
nnoremap <leader>o :only<CR>

nmap <Leader>r<CR> *:%s///g<left><left>
nmap <Leader>rc<CR> *:%s///gc<left><left><left>
nmap <Leader>gn<CR> *:%s///gn<CR>

nnoremap <leader>rg :FzfLua live_grep <C-R><C-W><CR>
vnoremap <leader>rg y:FzfLua live_grep <C-R>"<CR>

"Paste yanked text
noremap <Leader>p "0p
noremap <Leader>P "0P
vnoremap <Leader>p "0p

"Automatically jump to the end of text pasted
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

"incsearch.vim
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

au BufNewFile,BufRead *.ts set filetype=typescript
au BufNewFile,BufRead *.tsx set filetype=typescript

" Breakpoints
autocmd! FileType python nnoremap ,b Obreakpoint()<ESC>
autocmd! FileType ruby nnoremap ,b Obinding.pry<ESC>
autocmd! FileType javascript nnoremap ,b Odebugger;<ESC>
autocmd! FileType typescript nnoremap ,b Odebugger<ESC>
autocmd! FileType javascript nnoremap ,cl Oconsole.log({});<left><left><left>
autocmd! FileType typescript nnoremap ,cl Oconsole.log({})<left><left>
autocmd! FileType go nnoremap ,b :GoDebugBreakpoint<CR>


colorscheme solarized
set background=light
let g:solarized_bold=1

function! SetIssueNumber()
  let gitBranch=system("git rev-parse --abbrev-ref HEAD")
  let issueNumber=split(gitBranch, "/")[0]

  :execute "normal o\<esc>"
  silent put =issueNumber
endfunction

" Co-authorship
function! AttributeCoauthorship(nameAndEmail)
  let attribution = "Co-authored-by: " . a:nameAndEmail
  call SetIssueNumber()
  :execute "normal 2o\<esc>"
  silent put =attribution
endfunction

function! Coauthorship()
  call fzf#run({
    \ 'source': 'git log --pretty="%an <%ae>" | sort | uniq',
    \ 'sink': function('AttributeCoauthorship'),
    \ 'options': "-i --multi --preview 'git log -1 --author {} --pretty=\"authored %h %ar:%n%n%B\"'"
    \ })
endfunction

command! Coauthorship call Coauthorship()
command! SetIssueNumber call SetIssueNumber()



" nvim-compe config
set completeopt=menuone,noselect
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true
let g:compe.source.luasnip = v:true
let g:compe.source.emoji = v:true

luafile $HOME/.config/nvim/lua/init.lua

