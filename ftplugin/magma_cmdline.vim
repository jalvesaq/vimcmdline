function! MagmaSourceLines(lines)
    call cmdline#SendCmd(join(a:lines, b:cmdline_nl))
endfunction

let b:cmdline_nl = "\n"
let b:cmdline_app = 'magma'
let b:cmdline_quit_cmd = 'quit;'
let b:cmdline_source_fun = function('MagmaSourceLines')
let b:cmdline_send_empty = 1
let b:cmdline_filetype = 'magma'

if !exists("g:cmdline_map_start")
    let g:cmdline_map_start = "<LocalLeader>s"
endif
exe 'nmap <buffer><silent> ' . g:cmdline_map_start . ' :call cmdline#StartApp()<CR>'
