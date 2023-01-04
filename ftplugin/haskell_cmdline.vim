function! HaskellSourceLines(lines)
    call writefile(a:lines, g:cmdline_tmp_dir . "/lines.hs")
    call cmdline#SendCmd(":load " . g:cmdline_tmp_dir . "/lines.hs")
endfunction

let b:cmdline_nl = "\n"
if executable("stack")
    let b:cmdline_app = "stack ghci"
else
    let b:cmdline_app = "ghci"
endif
let b:cmdline_quit_cmd = ":quit"
let b:cmdline_source_fun = function("HaskellSourceLines")
let b:cmdline_send_empty = 0
let b:cmdline_filetype = "haskell"

if !exists("g:cmdline_map_start")
    let g:cmdline_map_start = "<LocalLeader>s"
endif
exe 'nmap <buffer><silent> ' . g:cmdline_map_start . ' :call cmdline#StartApp()<CR>'
