au FileType ruby nmap <Leader>r :!ruby %<CR>

nnoremap <leader>. :OpenAlternate<cr>

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
let g:rspec_command = "!bundle exec rspec -f d -c {spec}"

