nnoremap <leader>p :call print_debug#print_debug()<cr>
let g:print_debug_templates = {
\   'go':         'fmt.Printf("+++ {}\n")',
\   'python':     'print(f"+++ {}")',
\   'javascript': 'console.log(`+++ {}`);',
\   'c':          'printf("+++ {}\n");',
\ }
