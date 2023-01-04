function! Macaulay2SourceLines(lines)
    call writefile(filter(a:lines, '!empty(v:val)'), g:cmdline_tmp_dir . '/lines.m2', 'b')
    call cmdline#SendCmd('input "' . g:cmdline_tmp_dir . '/lines.m2"')
endfunction

let b:cmdline_nl = "\n"
let b:cmdline_app = 'M2'
let b:cmdline_quit_cmd = 'exit'
let b:cmdline_source_fun = function('Macaulay2SourceLines')
let b:cmdline_send_empty = 0
let b:cmdline_filetype = 'Macaulay2'

if !exists("g:cmdline_map_start")
    let g:cmdline_map_start = "<LocalLeader>s"
endif
exe 'nmap <buffer><silent> ' . g:cmdline_map_start . ' :call cmdline#StartApp()<CR>'
