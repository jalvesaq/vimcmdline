" Ensure that plugin/vimcmdline.vim was sourced
if !exists("g:cmdline_job")
    runtime plugin/vimcmdline.vim
endif

function! JavaScriptSourceLines(lines)
    call writefile(a:lines, g:cmdline_tmp_dir . "/lines.js")
    call VimCmdLineSendCmd("require('" . g:cmdline_tmp_dir . "/lines.js')")
endfunction

let b:cmdline_nl = "\n"
let b:cmdline_app = "node"
let b:cmdline_quit_cmd = "quit"
let b:cmdline_source_fun = function("JavaScriptSourceLines")
let b:cmdline_send_empty = 0
let b:cmdline_filetype = "javascript"

exe 'nmap <buffer><silent> ' . g:cmdline_map_start . ' :call VimCmdLineStartApp()<CR>'

exe 'autocmd VimLeave * call delete(g:cmdline_tmp_dir . "/lines.js")'

call VimCmdLineSetApp("javascript")
