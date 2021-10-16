" Ensure that plugin/vimcmdline.vim was sourced
if !exists("g:cmdline_job")
    runtime plugin/vimcmdline.vim
endif

function! LuaSourceLines(lines)
    call writefile(a:lines, g:cmdline_tmp_dir . '/lines.lua')
    call VimCmdLineSendCmd('dofile("' . g:cmdline_tmp_dir . '/lines.lua")')
endfunction

let b:cmdline_nl = "\n"
let b:cmdline_app = "lua"
let b:cmdline_quit_cmd = "os.exit()"
let b:cmdline_source_fun = function("LuaSourceLines")
let b:cmdline_send_empty = 0
let b:cmdline_filetype = "lua"

exe 'nmap <buffer><silent> ' . g:cmdline_map_start . ' :call VimCmdLineStartApp()<CR>'

call VimCmdLineSetApp("lua")
