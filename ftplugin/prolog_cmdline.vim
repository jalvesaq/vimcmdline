function! PrologSourceLines(lines)
    call writefile(a:lines, g:cmdline_tmp_dir . "/lines.pl")
    call cmdline#SendCmd("consult('" . g:cmdline_tmp_dir . "/lines.pl').")
endfunction

let b:cmdline_nl = "\n"
let b:cmdline_app = "swipl"
let b:cmdline_quit_cmd = "halt."
let b:cmdline_source_fun = function("PrologSourceLines")
let b:cmdline_send_empty = 0
let b:cmdline_filetype = "prolog"

if !exists("g:cmdline_map_start")
    let g:cmdline_map_start = "<LocalLeader>s"
endif
exe 'nmap <buffer><silent> ' . g:cmdline_map_start . ' :call cmdline#StartApp()<CR>'
