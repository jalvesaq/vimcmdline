"  This program is free software; you can redistribute it and/or modify
"  it under the terms of the GNU General Public License as published by
"  the Free Software Foundation; either version 2 of the License, or
"  (at your option) any later version.
"
"  This program is distributed in the hope that it will be useful,
"  but WITHOUT ANY WARRANTY; without even the implied warranty of
"  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
"  GNU General Public License for more details.
"
"  A copy of the GNU General Public License is available at
"  http://www.r-project.org/Licenses/

"==========================================================================
" Author: Jakson Alves de Aquino <jalvesaq@gmail.com>
"==========================================================================

if exists("g:did_vimcmdline")
    finish
endif
let g:did_vimcmdline = 1

" Set option
if has("nvim")
    if !exists("g:vimcmdline_in_buffer")
        let g:vimcmdline_in_buffer = 1
    endif
else
    let g:vimcmdline_in_buffer = 0
endif

" Check if Tmux is running
if !g:vimcmdline_in_buffer
    if $TMUX == ""
        finish
    endif
endif

" Set other options
if !exists("g:vimcmdline_vsplit")
    let g:vimcmdline_vsplit = 0
endif
if !exists("g:vimcmdline_esc_term")
    let g:vimcmdline_esc_term = 1
endif
if !exists("g:vimcmdline_term_width")
    let g:vimcmdline_term_width = 40
endif
if !exists("g:vimcmdline_term_height")
    let g:vimcmdline_term_height = 15
endif
if !exists("g;vimcmdline_tmp_dir")
    let g:vimcmdline_tmp_dir = "/tmp/vimcmdline_" . $USER
endif
if !exists("g:vimcmdline_outhl")
    let g:vimcmdline_outhl = 1
endif

" Internal variable
let s:vimcmdline_job = 0

" Skip empty lines
function s:GoLineDown()
    let i = line(".") + 1
    call cursor(i, 1)
    let curline = substitute(getline("."), '^\s*', "", "")
    let fc = curline[0]
    let lastLine = line("$")
    while i < lastLine && strlen(curline) == 0
        let i = i + 1
        call cursor(i, 1)
        let curline = substitute(getline("."), '^\s*', "", "")
        let fc = curline[0]
    endwhile
endfunction

" Run the interpreter in a Tmux panel
function VimCmdLineStart_Tmux(app)
    echomsg "Support for Tmux not implemented yet"
endfunction

" Run the interpreter in a Neovim terminal buffer
function VimCmdLineStart_Nvim(app)
    let edbuf = bufname("%")
    set switchbuf=useopen
    if g:vimcmdline_vsplit
        if g:vimcmdline_term_width > 16 && g:vimcmdline_term_width < (winwidth(0) - 16)
            silent exe "belowright " . g:vimcmdline_term_width . "vnew"
        else
            silent belowright vnew
        endif
    else
        if g:vimcmdline_term_height > 6 && g:vimcmdline_term_height < (winheight(0) - 6)
            silent exe "belowright " . g:vimcmdline_term_height . "new"
        else
            silent belowright new
        endif
    endif
    let s:vimcmdline_job = termopen(a:app, {'on_exit': function('s:VimCmdLineJobExit')})
    let s:vimcmdline_bufname = bufname("%")
    let b:script_buffer = edbuf
    if g:vimcmdline_esc_term
        tnoremap <buffer> <Esc> <C-\><C-n>
    endif
    if g:vimcmdline_outhl
        exe 'runtime syntax/cmdlineoutput_' . a:app . '.vim'
    endif
    exe "sbuffer " . edbuf
    stopinsert
endfunction

" Common procedure to start the interpreter
function VimCmdLineStartApp()
    if !exists("b:vimcmdline_app")
        echomsg 'There is no application defined to be executed for file of type "' . &filetype . '".'
        return
    endif
    nmap <silent><buffer> <Space> :call VimCmdLineSendLine()<CR>
    if exists("b:vimcmdline_source_fun")
        vmap <silent><buffer> <Space> <Esc>:call b:vimcmdline_source_fun(getline("'<", "'>"))<CR>
        nmap <silent><buffer> <LocalLeader>f :call b:vimcmdline_source_fun(getline(1, "$"))<CR>
    endif
    if exists("b:vimcmdline_quit_cmd")
        nmap <silent><buffer> <LocalLeader>q :call VimCmdLineQuit()<CR>
    endif
    if g:vimcmdline_in_buffer
        call VimCmdLineStart_Nvim(b:vimcmdline_app)
    else
        call VimCmdLineStart_Tmux(b:vimcmdline_app)
    endif
endfunction

" Send a single line to the interpreter
function VimCmdLineSendCmd(...)
    if s:vimcmdline_job
        call jobsend(s:vimcmdline_job, a:1 . b:vimcmdline_nl)
    endif
endfunction

" Send current line to the interpreter and go down to the next non empty line
function VimCmdLineSendLine()
    let line = getline(".")
    if strlen(line) == 0 && b:vimcmdline_send_empty == 0
        call s:GoLineDown()
        return
    endif
    call VimCmdLineSendCmd(line)
    call s:GoLineDown()
endfunction

" Quit the interpreter
function VimCmdLineQuit()
    if exists("b:vimcmdline_quit_cmd")
        call VimCmdLineSendCmd(b:vimcmdline_quit_cmd)
        exe "sb " . s:vimcmdline_bufname
        startinsert
    else
        echomsg 'Quit command not defined for file of type "' . &filetype . '".'
    endif
endfunction

" Register that the job no longer exists
function s:VimCmdLineJobExit(job_id, data)
    if a:job_id == s:vimcmdline_job
        let s:vimcmdline_job = 0
    endif
endfunction

if !isdirectory(g:vimcmdline_tmp_dir)
    call mkdir(g:vimcmdline_tmp_dir)
endif

