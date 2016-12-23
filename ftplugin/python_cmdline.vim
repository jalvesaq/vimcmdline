function! PythonSourceLines(lines)
    call VimCmdLineSendCmd(join(add(a:lines, ''), b:cmdline_nl))
endfunction

if g:cmdline_ipyhton
    let b:cmdline_app = "ipython"
else
    let b:cmdline_app = "python"
endif

let b:cmdline_nl = "\n"
let b:cmdline_quit_cmd = "quit()"
let b:cmdline_source_fun = function("PythonSourceLines")
let b:cmdline_send_empty = 1

nmap <buffer><silent> <LocalLeader>s :call VimCmdLineStartApp()<CR>

