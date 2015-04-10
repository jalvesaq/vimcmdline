
function JuliaSourceLines(lines)
    call writefile(a:lines, g:vimcmdline_tmp_dir . "/lines.jl")
    call VimCmdLineSendCmd('include("' . g:vimcmdline_tmp_dir . '/lines.jl")')
endfunction

let b:vimcmdline_nl = "\r\n"
let b:vimcmdline_app = "julia"
let b:vimcmdline_quit_cmd = "quit()"
let b:vimcmdline_source_fun = function("JuliaSourceLines")
nmap <buffer><silent> <LocalLeader>s :call VimCmdLineStartApp()<CR>

exe 'autocmd VimLeave * call delete("' . g:vimcmdline_tmp_dir . '/lines.jl")'
