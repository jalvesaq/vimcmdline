function! KotlinSourceLines(lines)
    call cmdline#SendCmd(join(add(a:lines, ''), b:cmdline_nl))
endfunction

let b:cmdline_nl = "\n"
let b:cmdline_quit_cmd = ":quit"
let b:cmdline_app = "kotlinc-jvm"
let b:cmdline_source_fun = function("KotlinSourceLines")
let b:cmdline_send_empty = 1
let b:cmdline_filetype = "kotlin"

if !exists("g:cmdline_map_start")
    let g:cmdline_map_start = "<LocalLeader>s"
endif
exe 'nmap <buffer><silent> ' . g:cmdline_map_start . ' :call cmdline#StartApp()<CR>'
