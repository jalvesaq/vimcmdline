" Ensure that plugin/vimcmdline.vim was sourced
if !exists("g:cmdline_job")
    runtime plugin/vimcmdline.vim
endif

function! RacketSourceLines(lines)
    call writefile(a:lines, g:cmdline_tmp_dir . "/lines.rkt")
    call VimCmdLineSendCmd('(load "' . g:cmdline_tmp_dir . '/lines.rkt")')
endfunction

let b:cmdline_nl = "\n"
let b:cmdline_app = "racket"
let b:cmdline_quit_cmd = "(exit)"
let b:cmdline_source_fun = function("RacketSourceLines")
let b:cmdline_send_empty = 0
let b:cmdline_filetype = "racket"

exe 'nmap <buffer><silent> ' . g:cmdline_map_start . ' :call VimCmdLineStartApp()<CR>'

exe 'autocmd VimLeave * call delete(g:cmdline_tmp_dir . "/lines.rkt")'

call VimCmdLineSetApp("racket")
