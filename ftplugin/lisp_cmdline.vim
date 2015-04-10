
function! LispSourceLines(lines)
    call writefile(a:lines, g:vimcmdline_tmp_dir . "/lines.lsp")
    call VimCmdLineSendCmd('(load "' . g:vimcmdline_tmp_dir . '/lines.lsp")')
endfunction

let b:vimcmdline_nl = "\n"
let b:vimcmdline_app = "clisp"
let b:vimcmdline_quit_cmd = "(quit)"
let b:vimcmdline_source_fun = function("LispSourceLines")
nmap <buffer><silent> <LocalLeader>s :call VimCmdLineStartApp()<CR>

exe 'autocmd VimLeave * call delete("' . g:vimcmdline_tmp_dir . '/lines.lsp")'
