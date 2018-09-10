" Ensure that plugin/vimcmdline.vim was sourced
if !exists("g:cmdline_job")
    runtime plugin/vimcmdline.vim
endif

function! JuliaSourceLines(lines)
    call writefile(a:lines, g:cmdline_tmp_dir . "/lines.jl")
    call VimCmdLineSendCmd('include("' . g:cmdline_tmp_dir . '/lines.jl")')
endfunction

let b:cmdline_nl = "\n"
let b:cmdline_app = "julia"
let b:cmdline_quit_cmd = "exit()"
let b:cmdline_source_fun = function("JuliaSourceLines")
let b:cmdline_send_empty = 0
let b:cmdline_filetype = "julia"

exe 'nmap <buffer><silent> ' . g:cmdline_map_start . ' :call VimCmdLineStartApp()<CR>'

exe 'autocmd VimLeave * call delete(g:cmdline_tmp_dir . "/lines.jl")'

call VimCmdLineSetApp("julia")
