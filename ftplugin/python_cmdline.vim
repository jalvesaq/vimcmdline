
function! PythonSourceLines(lines)
    call writefile(a:lines, g:vimcmdline_tmp_dir . "/lines_for_vimcmdline.py")
    call VimCmdLineSendCmd("import " . g:vimcmdline_tmp_dir . "/lines_for_vimcmdline.py")
endfunction

let b:vimcmdline_nl = "\n"
let b:vimcmdline_app = "python"
let b:vimcmdline_quit_cmd = "quit()"
let b:vimcmdline_source_fun = function("PythonSourceLines")
nmap <buffer><silent> <LocalLeader>s :call VimCmdLineStartApp()<CR>

exe 'autocmd VimLeave * call delete("' . g:vimcmdline_tmp_dir . '/lines_for_vimcmdline.py")'
