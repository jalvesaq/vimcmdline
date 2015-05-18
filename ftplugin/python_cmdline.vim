
function! PythonSourceLines(lines)
    call writefile(a:lines, g:cmdline_tmp_dir . "/lines.py")
    call VimCmdLineSendCmd("import " . g:cmdline_tmp_dir . "/lines.py")
endfunction

let b:cmdline_nl = "\n"
let b:cmdline_app = "python"
let b:cmdline_quit_cmd = "quit()"
let b:cmdline_source_fun = function("PythonSourceLines")
let b:cmdline_send_empty = 1

nmap <buffer><silent> <LocalLeader>s :call VimCmdLineStartApp()<CR>

exe 'autocmd VimLeave * call delete(g:cmdline_tmp_dir . "/lines.py")'
