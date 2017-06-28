au FileType go nmap <Leader>gor :GoRun<CR>
au FileType go nmap <Leader>b  :GoBuild<CR>
"<Plug>(go-build)
au FileType go nmap <Leader>gi :GoInstall<CR>
au FileType go nmap <leader>gt :GoTest<CR>
au FileType go nmap <leader>goc <Plug>(go-coverage)

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
"au FileType go nmap <Leader>dt <Plug>(go-def-tab)

"au FileType go nmap <Leader>god <Plug>(go-doc)
"au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>e <Plug>(go-rename)

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
