
function! OctaveSourceLines(lines)
    call writefile(a:lines, g:vimcmdline_tmp_dir . "/lines.m")
    call VimCmdLineSendCmd('source ("' . g:vimcmdline_tmp_dir . '/lines.m");')
endfunction

let b:vimcmdline_nl = "\n"
let b:vimcmdline_app = "octave"
let b:vimcmdline_quit_cmd = "exit"
let b:vimcmdline_source_fun = function("OctaveSourceLines")
let b:vimcmdline_send_empty = 0

nmap <buffer><silent> <LocalLeader>s :call VimCmdLineStartApp()<CR>

exe 'autocmd VimLeave * call delete("' . g:vimcmdline_tmp_dir . '/lines.m")'
