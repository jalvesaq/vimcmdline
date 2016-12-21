
function! OctaveSourceLines(lines)
    call writefile(a:lines, g:cmdline_tmp_dir . "/lines.m")
    call VimCmdLineSendCmd('source ("' . g:cmdline_tmp_dir . '/lines.m");')
endfunction

let b:cmdline_nl = "\n"
let b:cmdline_app = "octave"
let b:cmdline_quit_cmd = "exit"
let b:cmdline_source_fun = function("OctaveSourceLines")
let b:cmdline_send_empty = 0

nmap <buffer><silent> <LocalLeader>s :call VimCmdLineStartApp()<CR>

execute 'autocmd VimLeave * call delete(g:cmdline_tmp_dir . "/lines.m")'
