" Ensure that plugin/vimcmdline.vim was sourced
if !exists("g:cmdline_job")
    runtime plugin/vimcmdline.vim
endif

function! TypeScriptSourceLines(lines)
    call writefile(a:lines, g:cmdline_tmp_dir . "/lines.js")
    " Need to delete the cache for this tmp file if it exists, otherwise the
    " file won't be loaded again.
    let clear_cache_command = "delete require.cache[require.resolve('" . g:cmdline_tmp_dir . "/lines.js')]; "
    let source_file_command = "require('" . g:cmdline_tmp_dir . "/lines.js');"
    call VimCmdLineSendCmd(clear_cache_command . source_file_command)
endfunction

let b:cmdline_nl = "\n"
let b:cmdline_app = "ts-node"
let b:cmdline_quit_cmd = ".exit"
let b:cmdline_source_fun = function("TypeScriptSourceLines")
let b:cmdline_send_empty = 0
let b:cmdline_filetype = "typescript"

exe 'nmap <buffer><silent> ' . g:cmdline_map_start . ' :call VimCmdLineStartApp()<CR>'

exe 'autocmd VimLeave * call delete(g:cmdline_tmp_dir . "/lines.js")'

call VimCmdLineSetApp("typescript")
