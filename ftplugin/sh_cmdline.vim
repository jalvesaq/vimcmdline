if !exists("g:cmdline_start_mapping")
    let g:cmdline_start_mapping = '<LocalLeader>s'
endif

function! ShellSourceLines(lines)
    call writefile(a:lines, g:cmdline_tmp_dir . "/lines.sh")
    call VimCmdLineSendCmd(". " . g:cmdline_tmp_dir . "/lines.sh")
endfunction

let b:cmdline_nl = "\n"
let b:cmdline_app = "sh"
let b:cmdline_quit_cmd = "exit"
let b:cmdline_source_fun = function("ShellSourceLines")
let b:cmdline_send_empty = 0

" execute 'nnoremap <buffer>' g:cmdline_start_mapping ':call VimCmdLineStartApp()<CR>'
nnoremap <buffer> <LocalLeader>s :call VimCmdLineStartApp()<CR>

execute 'autocmd VimLeave * call delete(g:cmdline_tmp_dir . "/lines.sh")'
