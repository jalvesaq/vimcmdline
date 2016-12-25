function! PythonSourceLines(lines)
    call VimCmdLineSendCmd(join(add(a:lines, ''), b:cmdline_nl))
endfunction

let b:cmdline_nl = "\n"
let b:cmdline_app = "python"
let b:cmdline_quit_cmd = "quit()"
let b:cmdline_source_fun = function("PythonSourceLines")
let b:cmdline_send_empty = 1

nmap <buffer><silent> <LocalLeader>s :call VimCmdLineStartApp()<CR>

call VimCmdLineSetApp("python")
