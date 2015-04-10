
function! RubySourceLines(lines)
    call writefile(a:lines, g:vimcmdline_tmp_dir . "/lines.rb")
    call VimCmdLineSendCmd("load '" . g:vimcmdline_tmp_dir . "/lines.rb'")
endfunction

let b:vimcmdline_nl = "\n"
let b:vimcmdline_app = "irb"
let b:vimcmdline_quit_cmd = "quit"
let b:vimcmdline_source_fun = function("RubySourceLines")
let b:vimcmdline_send_empty = 0

nmap <buffer><silent> <LocalLeader>s :call VimCmdLineStartApp()<CR>

exe 'autocmd VimLeave * call delete("' . g:vimcmdline_tmp_dir . '/lines.rb")'
