
function! LispSourceLines(lines)
    call writefile(a:lines, g:cmdline_tmp_dir . "/lines.lsp")
    call VimCmdLineSendCmd('(load "' . g:cmdline_tmp_dir . '/lines.lsp")')
endfunction

let b:cmdline_nl = "\n"
let b:cmdline_app = "clisp"
let b:cmdline_quit_cmd = "(quit)"
let b:cmdline_source_fun = function("LispSourceLines")
let b:cmdline_send_empty = 0

nmap <buffer><silent> <LocalLeader>s :call VimCmdLineStartApp()<CR>

exe 'autocmd VimLeave * call delete(g:cmdline_tmp_dir . "/lines.lsp")'

call VimCmdLineSetApp("lisp")
