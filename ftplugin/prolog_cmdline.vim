
function! PrologSourceLines(lines)
    call writefile(a:lines, g:cmdline_tmp_dir . "/lines.pl")
    call VimCmdLineSendCmd("consult('" . g:cmdline_tmp_dir . "/lines.pl').")
endfunction

let b:cmdline_nl = "\n"
let b:cmdline_app = "swipl"
let b:cmdline_quit_cmd = "halt."
let b:cmdline_source_fun = function("PrologSourceLines")
let b:cmdline_send_empty = 0

nmap <buffer><silent> <LocalLeader>s :call VimCmdLineStartApp()<CR>

execute 'autocmd VimLeave * call delete(g:cmdline_tmp_dir . "/lines.pl")'
