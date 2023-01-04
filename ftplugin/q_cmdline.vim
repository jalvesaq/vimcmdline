" Write a temp file and source this temp file
function! KdbSourceLines(lines)
    call writefile(a:lines, g:cmdline_tmp_dir . "/lines.q")
    call cmdline#SendCmd("\\l " . g:cmdline_tmp_dir . "/lines.q")
endfunction

let b:cmdline_nl = "\n"
" b:cmdline_app should not be an expression like 'rlwrap q' 
" to do this create a script, add it to your PATH and set b:cmdlineapp
" accordingly
let b:cmdline_app = "q"
let b:cmdline_quit_cmd = "\\\\"
let b:cmdline_source_fun = function("KdbSourceLines")
let b:cmdline_send_empty = 1
let b:cmdline_filetype = "kdb"

if !exists("g:cmdline_map_start")
    let g:cmdline_map_start = "<LocalLeader>s"
endif
exe 'nmap <buffer><silent> ' . g:cmdline_map_start . ' :call cmdline#StartApp()<CR>'
