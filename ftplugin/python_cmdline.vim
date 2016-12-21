function! PythonSourceLines(lines)
    call VimCmdLineSendCmd(join(add(a:lines, ''), b:cmdline_nl))
endfunction

let b:cmdline_nl = "\n"
if !exists('g:cmdline_use_python_3')
    let g:cmdline_use_python_3 = 0
endif

if g:cmdline_use_python_3
    if executable('ptipython3')
        let b:cmdline_app = 'ptipython3'
    elseif executable('ipython3')
        let b:cmdline_app = 'ipython3'
    elseif executable('ptpython3')
        let b:cmdline_app = 'ptpython3'
    elseif executable('python3')
        let b:cmdline_app = 'python3'
    endif
else
    if executable('ptipython2')
        let b:cmdline_app = 'ptipython2'
    elseif executable('ipython2')
        let b:cmdline_app = 'ptipython2'
    elseif executable('ptpython2')
        let b:cmdline_app = 'ptpython2'
    elseif executable('python')
        let b:cmdline_app = 'python'
    endif
endif

let b:cmdline_source_fun = function('PythonSourceLines')
let b:cmdline_send_empty = 1

nmap <buffer><silent> <LocalLeader>s :call VimCmdLineStartApp()<CR>

