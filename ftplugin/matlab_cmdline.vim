function! OctaveSourceLines(lines)
    call writefile(a:lines, g:cmdline_tmp_dir . "/lines.m")
    if b:cmdline_app =~? "^matlab"
        call cmdline#SendCmd('run("' . g:cmdline_tmp_dir . '/lines.m"); clear lines.m;')
    else
        call cmdline#SendCmd('source("' . g:cmdline_tmp_dir . '/lines.m");')
    endif
endfunction

let b:cmdline_nl = "\n"
let b:cmdline_app = "octave"
let b:cmdline_quit_cmd = "exit"
let b:cmdline_source_fun = function("OctaveSourceLines")
let b:cmdline_send_empty = 0
let b:cmdline_filetype = "matlab"

if !exists("g:cmdline_map_start")
    let g:cmdline_map_start = "<LocalLeader>s"
endif
exe 'nmap <buffer><silent> ' . g:cmdline_map_start . ' :call cmdline#StartApp()<CR>'
