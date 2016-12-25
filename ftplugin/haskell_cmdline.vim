
function! HaskellSourceLines(lines)
    call writefile(a:lines, g:cmdline_tmp_dir . "/lines.hs")
    call VimCmdLineSendCmd(":load " . g:cmdline_tmp_dir . "/lines.hs")
endfunction

let b:cmdline_nl = "\n"
if executable("stack")
    let b:cmdline_app = "stack ghci"
else
    let b:cmdline_app = "ghci"
endif
let b:cmdline_quit_cmd = ":quit"
let b:cmdline_source_fun = function("HaskellSourceLines")
let b:cmdline_send_empty = 0

nmap <buffer><silent> <LocalLeader>s :call VimCmdLineStartApp()<CR>

exe 'autocmd VimLeave * call delete(g:cmdline_tmp_dir . "/lines.hs")'

call VimCmdLineSetApp("haskell")
