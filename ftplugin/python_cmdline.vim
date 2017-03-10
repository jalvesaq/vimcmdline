function! PythonSourceLines(lines)
    call VimCmdLineSendCmd(join(add(a:lines, ''), b:cmdline_nl))
endfunction

let b:cmdline_nl = "\n"
let b:cmdline_app = "python"
let b:cmdline_quit_cmd = "quit()"
let b:cmdline_source_fun = function("PythonSourceLines")
let b:cmdline_send_empty = 1

exe 'nmap <buffer><silent> ' . g:cmdline_map_start . ' :call VimCmdLineStartApp()<CR>'

if exists("g:cmdline_app")
    for key in keys(g:cmdline_app)
        if key == "python" && g:cmdline_app["python"] == "ipython"
            echohl WarningMsg
            echomsg "vimcmdline does not support ipython"
            sleep 3
            echohl Normal
        endif
    endfor
endif

call VimCmdLineSetApp("python")
