" This is the default extra key bindings
"let g:fzf_action = {
  "\ 'ctrl-t': 'tab split',
  "\ 'ctrl-x': 'split',
  "\ 'ctrl-v': 'vsplit' }

"" Default fzf layout
"" - down / up / left / right
"let g:fzf_layout = { 'down': '~40%' }


"map <C-p> :Files<cr>
"nmap <C-p> :Files<cr>

"nmap <Leader>c :Commits<cr>
"inoremap <expr> <C-x><C-k> fzf#complete

" Mapping selecting mappings
"nmap <leader><tab> <plug>(fzf-maps-n)
"xmap <leader><tab> <plug>(fzf-maps-x)
"omap <leader><tab> <plug>(fzf-maps-o)
"
" " Insert mode completion
"imap <c-x><c-k> <plug>(fzf-complete-word)
"imap <c-x><c-f> <plug>(fzf-complete-path)
"imap <c-x><c-j> <plug>(fzf-complete-file-ag)
"imap <c-x><c-l> <plug>(fzf-complete-line)"
"Advanced customization using autoload functions
"inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

"Don't load ctrlp
"let g:loaded_ctrlp = 1
