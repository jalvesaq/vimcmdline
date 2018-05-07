" Ensure that plugin/vimcmdline.vim was sourced
if !exists('g:cmdline_job')
    runtime plugin/vimcmdline.vim
endif

function! SageSourceLines(lines)
    call VimCmdLineSendCmd('%cpaste -q')
    sleep 100m " Wait for IPython to read stdin
    call VimCmdLineSendCmd(join(add(a:lines, '--'), b:cmdline_nl))
endfunction

let b:cmdline_nl = "\n"
let b:cmdline_app = 'sage'
let b:cmdline_quit_cmd = 'exit'
let b:cmdline_source_fun = function('SageSourceLines')
let b:cmdline_send_empty = 1
let b:cmdline_filetype = 'sage'

exe 'nmap <buffer><silent> ' . g:cmdline_map_start . ' :call VimCmdLineStartApp()<CR>'

call VimCmdLineSetApp('sage')
