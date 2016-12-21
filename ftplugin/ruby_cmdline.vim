
function! RubySourceLines(lines)
    call writefile(a:lines, g:cmdline_tmp_dir . "/lines.rb")
    call VimCmdLineSendCmd("load '" . g:cmdline_tmp_dir . "/lines.rb'")
endfunction

let b:cmdline_nl = "\n"
let b:cmdline_app = "irb"
let b:cmdline_quit_cmd = "quit"
let b:cmdline_source_fun = function("RubySourceLines")
let b:cmdline_send_empty = 0

nmap <buffer><silent> <LocalLeader>s :call VimCmdLineStartApp()<CR>

execute 'autocmd VimLeave * call delete(g:cmdline_tmp_dir . "/lines.rb")'
