" Ensure that plugin/vimcmdline.vim was sourced
if !exists("g:cmdline_job")
    runtime plugin/vimcmdline.vim
endif

function! OCamlSourceLines(lines)
    for line in a:lines
        call VimCmdLineSendCmd(substitute(line, ";;$", "", "g"))
    endfor
    call VimCmdLineSendCmd(";;\<CR>")
endfunction

function! OCamlSendLine()
    let line = getline(".")
    call VimCmdLineSendCmd(line . ";;\<CR>")
    call VimCmdLineDown()
endfunction

let b:cmdline_nl = "\<CR>"
let b:cmdline_app = "utop"
let b:cmdline_quit_cmd = "#quit;;"
let b:cmdline_send = function("OCamlSendLine")
let b:cmdline_source_fun = function("OCamlSourceLines")
let b:cmdline_send_empty = 1
let b:cmdline_filetype = "ocaml"

exe 'nmap <buffer><silent> ' . g:cmdline_map_start . ' :call VimCmdLineStartApp()<CR>'

exe 'autocmd VimLeave * call delete(g:cmdline_tmp_dir . "/lines.ml")'

call VimCmdLineSetApp("ocaml")
