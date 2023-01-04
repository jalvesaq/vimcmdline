function! SageSourceLines(lines)
    call cmdline#SendCmd('%cpaste -q')
    sleep 100m " Wait for IPython to read stdin
    call cmdline#SendCmd(join(add(a:lines, '--'), b:cmdline_nl))
endfunction

let b:cmdline_nl = "\n"
let b:cmdline_app = 'sage'
let b:cmdline_quit_cmd = 'exit'
let b:cmdline_source_fun = function('SageSourceLines')
let b:cmdline_send_empty = 1
let b:cmdline_filetype = 'sage'

if !exists("g:cmdline_map_start")
    let g:cmdline_map_start = "<LocalLeader>s"
endif
exe 'nmap <buffer><silent> ' . g:cmdline_map_start . ' :call cmdline#StartApp()<CR>'
