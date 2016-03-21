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

if exists("g:did_cmdline")
    finish
endif
let g:did_cmdline = 1

" Set option
if has("nvim")
    if !exists("g:cmdline_in_buffer")
        let g:cmdline_in_buffer = 1
    endif
else
    let g:cmdline_in_buffer = 0
endif

" Check if Tmux is running
if !g:cmdline_in_buffer
    if $TMUX == ""
        finish
    endif
endif

" Set other options
if !exists("g:cmdline_vsplit")
    let g:cmdline_vsplit = 0
endif
if !exists("g:cmdline_esc_term")
    let g:cmdline_esc_term = 1
endif
if !exists("g:cmdline_term_width")
    let g:cmdline_term_width = 40
endif
if !exists("g:cmdline_term_height")
    let g:cmdline_term_height = 15
endif
if !exists("g:cmdline_tmp_dir")
    let g:cmdline_tmp_dir = "/tmp/cmdline_" . $USER
endif
if !exists("g:cmdline_outhl")
    let g:cmdline_outhl = 1
endif

if !exists("g:cmdline_send_line_mapping")
  let g:cmdline_send_line_mapping = '<space>'
endif

if !exists("g:cmdline_visual_send_line_mapping")
  let g:cmdline_visual_send_line_mapping = '<space>'
endif

if !exists("g:cmdline_send_file_mapping")
  let g:cmdline_send_file_mapping = '<LocalLeader>f'
endif

if !exists("g:cmdline_send_paragraph_mapping")
  let g:cmdline_send_paragraph_mapping = '<LocalLeader>p'
endif

if !exists("g:cmdline_send_marked_block_mapping")
  let g:cmdline_send_marked_block_mapping = '<LocalLeader>b'
endif

if !exists("g:cmdline_quit_mapping")
  let g:cmdline_quit_mapping = '<LocalLeader>q'
endif


" Internal variables
let s:cmdline_job = 0
let s:cmdline_app_pane = ''

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

" Adapted from screen plugin:
function GetTmuxActivePane()
  let line = system("tmux list-panes | grep \'(active)$'")
  let paneid = matchstr(line, '\v\%\d+ \(active\)')
  if !empty(paneid)
    return matchstr(paneid, '\v^\%\d+')
  else
    return matchstr(line, '\v^\d+')
  endif
endfunction

" Run the interpreter in a Tmux panel
function VimCmdLineStart_Tmux(app)
    let g:cmdline_vim_pane = GetTmuxActivePane()
    let tcmd = "tmux split-window "
    if g:cmdline_vsplit
        if g:cmdline_term_width == -1
            let tcmd .= "-h"
        else
            let tcmd .= "-h -l " . g:cmdline_term_width
        endif
    else
        let tcmd .= "-l " . g:cmdline_term_height
    endif
    let tcmd .= " " . a:app
    let slog = system(tcmd)
    if v:shell_error
        execute 'echoerr ' . slog
        return
    endif
    let s:cmdline_app_pane = GetTmuxActivePane()
    let slog = system("tmux select-pane -t " . g:cmdline_vim_pane)
    if v:shell_error
        execute 'echoerr ' . slog
        return
    endif
    " call VimCmdLineSendCmd(a:app)
endfunction

" Run the interpreter in a Neovim terminal buffer
function VimCmdLineStart_Nvim(app)
    let edbuf = bufname("%")
    set switchbuf=useopen
    if g:cmdline_vsplit
        if g:cmdline_term_width > 16 && g:cmdline_term_width < (winwidth(0) - 16)
            silent execute "belowright " . g:cmdline_term_width . "vnew"
        else
            silent belowright vnew
        endif
    else
        if g:cmdline_term_height > 6 && g:cmdline_term_height < (winheight(0) - 6)
            silent execute "belowright " . g:cmdline_term_height . "new"
        else
            silent belowright new
        endif
    endif
    let s:cmdline_job = termopen(a:app, {'on_exit': function('s:VimCmdLineJobExit')})
    let s:cmdline_bufname = bufname("%")
    let b:script_buffer = edbuf
    if g:cmdline_esc_term
        tnoremap <buffer> <Esc> <C-\><C-n>
    endif
    if g:cmdline_outhl
        execute 'runtime syntax/cmdlineoutput_' . a:app . '.vim'
    endif
    execute "sbuffer " . edbuf
    stopinsert
endfunction

" Common procedure to start the interpreter
function VimCmdLineStartApp()
    if !exists("b:cmdline_app")
        echomsg 'There is no application defined to be executed for file of type "' . &filetype . '".'
        return
    endif
    nmap <silent><buffer> <a-s-l> :call VimCmdLineSendLine()<CR>
    if exists("b:cmdline_source_fun")
        vmap <silent><buffer> <c-c> <Esc>:call b:cmdline_source_fun(getline("'<", "'>"))<CR>
        nmap <silent><buffer> <a-s-f> :call b:cmdline_source_fun(getline(1, "$"))<CR>
        nmap <silent><buffer> <c-c><c-c> :call VimCmdLineSendParagraph()<CR>
        nmap <silent><buffer> <LocalLeader>b :call VimCmdLineSendMBlock()<CR>
    endif
    if exists("b:cmdline_quit_cmd")
        execute 'nnoremap <silent><buffer><space>' g:cmdline_quit_mapping ':call VimCmdLineQuit()<CR>'
    endif

    if !isdirectory(g:cmdline_tmp_dir)
        call mkdir(g:cmdline_tmp_dir)
    endif

    if g:cmdline_in_buffer
        call VimCmdLineStart_Nvim(b:cmdline_app)
    else
        call VimCmdLineStart_Tmux(b:cmdline_app)
    endif
endfunction

" Send a single line to the interpreter
function VimCmdLineSendCmd(...)
    if s:cmdline_job
        call jobsend(s:cmdline_job, a:1 . b:cmdline_nl)
    elseif s:cmdline_app_pane != ''
        let str = substitute(a:1, "'", "'\\\\''", "g")
        let scmd = "tmux set-buffer '" . str . "\<C-M>' && tmux paste-buffer -t " . s:cmdline_app_pane
        let slog = system(scmd)
        if v:shell_error
            let slog = substitute(rlog, "\n", " ", "g")
            let slog = substitute(rlog, "\r", " ", "g")
            execute 'echoerr ' . slog
            let s:cmdline_app_pane = ''
        endif
    endif
endfunction

" Send current line to the interpreter and go down to the next non empty line
function VimCmdLineSendLine()
    let line = getline(".")
    if strlen(line) == 0 && b:cmdline_send_empty == 0
        call s:GoLineDown()
        return
    endif
    call VimCmdLineSendCmd(line)
    call s:GoLineDown()
endfunction

function VimCmdLineSendParagraph()
    let i = line(".")
    let c = col(".")
    let max = line("$")
    let j = i
    let gotempty = 0
    while j < max
        let j += 1
        let line = getline(j)
        if line =~ '^\s*$'
            break
        endif
    endwhile
    let lines = getline(i, j)
    call b:cmdline_source_fun(lines)
    if j < max
        call cursor(j, 1)
    else
        call cursor(max, 1)
    endif
endfunction

let s:all_marks = "abcdefghijklmnopqrstuvwxyz"

function VimCmdLineSendMBlock()
    let curline = line(".")
    let lineA = 1
    let lineB = line("$")
    let maxmarks = strlen(s:all_marks)
    let n = 0
    while n < maxmarks
        let c = strpart(s:all_marks, n, 1)
        let lnum = line("'" . c)
        if lnum != 0
            if lnum <= curline && lnum > lineA
                let lineA = lnum
            elseif lnum > curline && lnum < lineB
                let lineB = lnum
            endif
        endif
        let n = n + 1
    endwhile
    if lineA == 1 && lineB == (line("$"))
        echo "The file has no mark!"
        return
    endif
    if lineB < line("$")
        let lineB -= 1
    endif
    let lines = getline(lineA, lineB)
    call b:cmdline_source_fun(lines)
endfunction

" Quit the interpreter
function VimCmdLineQuit()
    if exists("b:cmdline_quit_cmd")
        call VimCmdLineSendCmd(b:cmdline_quit_cmd)
        if exists("s:cmdline_bufname")
            execute "sb " . s:cmdline_bufname
            startinsert
        endif
    else
        echomsg 'Quit command not defined for file of type "' . &filetype . '".'
    endif
endfunction

" Register that the job no longer exists
function s:VimCmdLineJobExit(job_id, data)
    if a:job_id == s:cmdline_job
        let s:cmdline_job = 0
    endif
endfunction

