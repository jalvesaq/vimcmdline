" Ensure that plugin/vimcmdline.vim was sourced
if !exists("g:cmdline_job")
    runtime plugin/vimcmdline.vim
endif

if exists("g:cmdline_app")
    for key in keys(g:cmdline_app)
        if key == "python" && match(g:cmdline_app["python"], "ipython") != -1
            let b:cmdline_ipython = 1
        endif
    endfor
endif

function! PythonSourceLines(lines)
    if exists("b:cmdline_ipython")
        call VimCmdLineSendCmd("%cpaste -q")
        sleep 100m " Wait for IPython to read stdin
        call VimCmdLineSendCmd(join(add(a:lines, '--'), b:cmdline_nl))
    else
        call VimCmdLineSendCmd(join(add(a:lines, ''), b:cmdline_nl))
    endif
endfunction

let b:cmdline_nl = "\n"
let b:cmdline_app = "python"
let b:cmdline_quit_cmd = "quit()"
let b:cmdline_source_fun = function("PythonSourceLines")
let b:cmdline_send_empty = 1
let b:cmdline_filetype = "python"

exe 'nmap <buffer><silent> ' . g:cmdline_map_start . ' :call VimCmdLineStartApp()<CR>'

call VimCmdLineSetApp("python")
