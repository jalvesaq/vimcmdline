
function JuliaSourceLines(lines)
    call writefile(a:lines, g:cmdline_tmp_dir . "/lines.jl")
    call VimCmdLineSendCmd('include("' . g:cmdline_tmp_dir . '/lines.jl")')
endfunction

let b:cmdline_nl = "\r\n"
let b:cmdline_app = "julia"
let b:cmdline_quit_cmd = "quit()"
let b:cmdline_source_fun = function("JuliaSourceLines")
let b:cmdline_send_empty = 0

nmap <buffer><silent> <LocalLeader>s :call VimCmdLineStartApp()<CR>

exe 'autocmd VimLeave * call delete(g:cmdline_tmp_dir . "/lines.jl")'

call VimCmdLineSetApp("julia")
