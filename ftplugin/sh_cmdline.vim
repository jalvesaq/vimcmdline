
function! ShellSourceLines(lines)
    call writefile(a:lines, g:vimcmdline_tmp_dir . "/lines_for_vimcmdline.sh")
    call VimCmdLineSendCmd("import " . g:vimcmdline_tmp_dir . "/lines_for_vimcmdline.sh")
endfunction

let b:vimcmdline_nl = "\n"
let b:vimcmdline_app = "sh"
let b:vimcmdline_quit_cmd = "exit"
let b:vimcmdline_source_fun = function("ShellSourceLines")
nmap <buffer><silent> <LocalLeader>s :call VimCmdLineStartApp()<CR>

exe 'autocmd VimLeave * call delete("' . g:vimcmdline_tmp_dir . '/lines_for_vimcmdline.sh")'
