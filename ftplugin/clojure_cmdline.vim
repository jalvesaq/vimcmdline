function! ClojureSourceLines(lines)
    call writefile(a:lines, g:cmdline_tmp_dir . "/lines.clj")
    call cmdline#SendCmd('(load-file "' . g:cmdline_tmp_dir . '/lines.clj")')
endfunction

let b:cmdline_nl = "\n"
let b:cmdline_app = "lein repl"
let b:cmdline_quit_cmd = "(quit)"
let b:cmdline_source_fun = function("ClojureSourceLines")
let b:cmdline_send_empty = 0
let b:cmdline_filetype = "clojure"

if !exists("g:cmdline_map_start")
    let g:cmdline_map_start = "<LocalLeader>s"
endif
exe 'nmap <buffer><silent> ' . g:cmdline_map_start . ' :call cmdline#StartApp()<CR>'
