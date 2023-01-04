function! ShellSourceLines(lines)
    call writefile(a:lines, g:cmdline_tmp_dir . "/lines.sh")
    call cmdline#SendCmd(". " . g:cmdline_tmp_dir . "/lines.sh")
endfunction

let b:cmdline_nl = "\n"
let b:cmdline_app = "sh"
let b:cmdline_quit_cmd = "exit"
let b:cmdline_source_fun = function("ShellSourceLines")
let b:cmdline_send_empty = 0
let b:cmdline_filetype = "sh"

if !exists("g:cmdline_map_start")
    let g:cmdline_map_start = "<LocalLeader>s"
endif
exe 'nmap <buffer><silent> ' . g:cmdline_map_start . ' :call cmdline#StartApp()<CR>'
