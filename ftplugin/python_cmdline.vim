" skip if filetype is sage.python
if match(&ft, '\v<sage>') != -1
    finish
endif

" Ensure that plugin/vimcmdline.vim was sourced
if !exists("g:cmdline_job")
    runtime plugin/vimcmdline.vim
endif

if exists("g:cmdline_app")
    for key in keys(g:cmdline_app)
        if key == "python"
	    if match(g:cmdline_app["python"], "ipython") != -1
	        let b:cmdline_ipython = 1
	    elseif match(g:cmdline_app["python"], "jupyter") != -1
	        let b:cmdline_jupyter = 1
	    endif
        endif
    endfor
endif

function! PythonSourceLines(lines)
    if exists("b:cmdline_ipython")
        call VimCmdLineSendCmd("%cpaste -q")
        sleep 100m " Wait for IPython to read stdin
        call VimCmdLineSendCmd(join(add(a:lines, '--'), b:cmdline_nl))
    elseif exists("b:cmdline_jupyter")
	" Use bracketed paste
	let a:block = join(a:lines, b:cmdline_nl)
python << endpython
# Allow inner blocks to be run without problem (cpaste-like)
import textwrap, json
block = vim.eval('a:block')
vim.command('let a:block = %s' % json.dumps(textwrap.dedent(block)))
endpython
	call VimCmdLineSendCmd("\e[200~")
        call VimCmdLineSendCmd(a:block)
        call VimCmdLineSendCmd("\e[201~")
	call VimCmdLineSendCmd(b:cmdline_nl)
    else
        call VimCmdLineSendCmd(join(add(a:lines, ''), b:cmdline_nl))
    endif
endfunction

if filereadable("vimcmdlinetmp.py")
    let s:tmppy = 0
    call VimCmdLineWarn('Please, delete the file "vimcmdlinetmp.py".')
else
    let s:tmppy = 1
    exe 'autocmd VimLeave * call delete("' . expand("%:p:h") . "/vimcmdlinetmp.py" . '")'
    " Folder in which script resides: (not safe for symlinks)
    let s:path = expand('<sfile>:p:h')
endif

function! PythonSourceLines(lines)
    if s:tmppy
        call writefile(a:lines, "vimcmdlinetmp.py")
        " Folder in which script resides: (not safe for symlinks)
        " Information from https://stackoverflow.com/questions/4976776/how-to-get-path-to-the-current-vimscript-being-executed/18734557

        " Load the py file
        call VimCmdLineSendCmd("import sys")
        call VimCmdLineSendCmd("sys.path.append('" . s:path . "')")
        call VimCmdLineSendCmd("import python_cmdline_import")
        " This doesn't work
        " call VimCmdLineSendCmd("importlib.import_module('" . s:path . "/python_cmdline_import')")

        call VimCmdLineSendCmd("python_cmdline_import.import_and_reload_if_necessary('vimcmdlinetmp')")
        call VimCmdLineSendCmd("from vimcmdlinetmp import *")
    endif
endfunction

function! PythonSendLine()
    let line = getline(".")
    if line =~ '^class ' || line =~ '^def '
        let lines = []
        let idx = line('.')
        while idx <= line('$')
            if line != ''
                let lines += [line]
            endif
            let idx += 1
            let line = getline(idx)
            if line =~ '^\S'
                break
            endif
        endwhile
        let lines += ['']
        call PythonSourceLines(lines)
        exe idx
        return
    endif
    if strlen(line) > 0 || b:cmdline_send_empty
        call VimCmdLineSendCmd(line)
    endif
    call VimCmdLineDown()
endfunction

if has("win32")
    let b:cmdline_nl = "\r\n"
else
    let b:cmdline_nl = "\n"
endif
if executable("python3")
    let b:cmdline_app = "python3"
else
    let b:cmdline_app = "python"
endif
let b:cmdline_quit_cmd = "quit()"
let b:cmdline_send = function('PythonSendLine')
let b:cmdline_source_fun = function("PythonSourceLines")
let b:cmdline_send_empty = 1
let b:cmdline_filetype = "python"

exe 'nmap <buffer><silent> ' . g:cmdline_map_start . ' :call VimCmdLineStartApp()<CR>'

call VimCmdLineSetApp("python")
