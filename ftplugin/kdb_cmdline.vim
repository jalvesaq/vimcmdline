" Ensure that plugin/vimcmdline.vim was sourced
if !exists("g:cmdline_job")
    runtime plugin/vimcmdline.vim
endif

" Function transform several lines into one, it removes end of lines starting with //
"function! Format(lines)
"	let lines = []
"	for line in a:lines
"		let new_line = substitute(line, '//.*', '', '')
"		call add(lines, new_line)
"	endfor
"	return join(lines)
"endfunction

" Send the reformated lines themselves
"function! KdbSourceLines(lines)
"    call VimCmdLineSendCmd(Format(a:lines))
"endfunction

" Write a temp file and source this temp file
function! KdbSourceLines(lines)
    call writefile(a:lines, g:cmdline_tmp_dir . "/lines.q")
    call VimCmdLineSendCmd("\l " . g:cmdline_tmp_dir . "/lines.q")
endfunction

let b:cmdline_nl = " "
let b:cmdline_app = "q"
let b:cmdline_quit_cmd = "\\\\"
let b:cmdline_source_fun = function("KdbSourceLines")
let b:cmdline_send_empty = 1
let b:cmdline_filetype = "kdb"

exe 'nmap <buffer><silent> ' . g:cmdline_map_start . ' :call VimCmdLineStartApp()<CR>'

exe 'autocmd VimLeave * call delete(g:cmdline_tmp_dir . "/lines.q")'

call VimCmdLineSetApp("q")
