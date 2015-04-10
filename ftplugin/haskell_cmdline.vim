
function! HaskellSourceLines(lines)
    call writefile(a:lines, g:vimcmdline_tmp_dir . "/lines_for_vimcmdline.hs")
    call VimCmdLineSendCmd(":load " . g:vimcmdline_tmp_dir . "/lines_for_vimcmdline.hs")
endfunction

let b:vimcmdline_nl = "\n"
let b:vimcmdline_app = "ghci"
let b:vimcmdline_quit_cmd = ":quit"
let b:vimcmdline_source_fun = function("HaskellSourceLines")
nmap <buffer><silent> <LocalLeader>s :call VimCmdLineStartApp()<CR>

exe 'autocmd VimLeave * call delete("' . g:vimcmdline_tmp_dir . '/lines_for_vimcmdline.hs")'
