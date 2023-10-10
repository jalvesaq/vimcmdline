function! SourceRLines(lines)
    call writefile(a:lines, g:cmdline_tmp_dir . "/lines.R")
    call cmdline#SendCmd("base::source('" . g:cmdline_tmp_dir . "/lines.R', local = parent.frame(), print.eval = TRUE)")
endfunction

let b:cmdline_nl = "\n"
let b:cmdline_app = "R"
let b:cmdline_quit_cmd = "quit(save = 'no')"
let b:cmdline_source_fun = function("SourceRLines")
let b:cmdline_send_empty = 0
let b:cmdline_filetype = "r"

if !exists("g:cmdline_map_start")
    let g:cmdline_map_start = "<LocalLeader>s"
endif
exe 'nmap <buffer><silent> ' . g:cmdline_map_start . ' :call cmdline#StartApp()<CR>'
