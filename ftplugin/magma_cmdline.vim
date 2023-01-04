" Ensure that plugin/vimcmdline.vim was sourced
if !exists('g:cmdline_job')
    runtime plugin/vimcmdline.vim
endif

function! MagmaSourceLines(lines)
    call VimCmdLineSendCmd(join(a:lines, b:cmdline_nl))
endfunction

let b:cmdline_nl = "\n"
let b:cmdline_app = 'magma'
let b:cmdline_quit_cmd = 'quit;'
let b:cmdline_source_fun = function('MagmaSourceLines')
let b:cmdline_send_empty = 1
let b:cmdline_filetype = 'magma'

exe 'nmap <buffer><silent> ' . g:cmdline_map_start . ' :call VimCmdLineStartApp()<CR>'

call VimCmdLineSetApp('magma')
