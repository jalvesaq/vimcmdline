
function! ShellSourceLines(lines)
    call writefile(a:lines, g:vimcmdline_tmp_dir . "/lines.sh")
    call VimCmdLineSendCmd(". " . g:vimcmdline_tmp_dir . "/lines.sh")
endfunction

let b:vimcmdline_nl = "\n"
let b:vimcmdline_app = "sh"
let b:vimcmdline_quit_cmd = "exit"
let b:vimcmdline_source_fun = function("ShellSourceLines")
let b:vimcmdline_send_empty = 0

nmap <buffer><silent> <LocalLeader>s :call VimCmdLineStartApp()<CR>

exe 'autocmd VimLeave * call delete("' . g:vimcmdline_tmp_dir . '/lines.sh")'
