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
    let g:cmdline_in_buffer = get(g:, 'cmdline_in_buffer', 1)
else
    let g:cmdline_in_buffer = 0
endif

" Set other options
let g:cmdline_vsplit = get(g:, 'cmdline_vsplit', 0)
let g:cmdline_esc_term = get(g:, 'cmdline_esc_term', 1)
let g:cmdline_term_width = get(g:, 'cmdline_term_width', 40)
let g:cmdline_term_height = get(g:, 'cmdline_term_height', 15)
let g:cmdline_tmp_dir = get(g:, 'cmdline_tmp_dir', '/tmp/cmdline_' . localtime() . '_' . $USER)
let g:cmdline_outhl = get(g:, 'cmdline_outhl', 1)
let g:cmdline_auto_scroll = get(g:, 'cmdline_auto_scroll', 1)

" Internal variables
let g:cmdline_job = {"haskell": 0, "julia": 0, "lisp": 0, "matlab": 0, "go": 0,
            \ "prolog": 0, "python": 0, "ruby": 0, "sh": 0, "javascript": 0,
            \ "sage": 0, "Macaulay2": 0, "kdb": 0, "clojure": 0, "scala": 0}
let g:cmdline_termbuf = {"haskell": "", "julia": "", "lisp": "", "matlab": "", "go": "",
            \ "prolog": "", "python": "", "ruby": "", "sh": "", "javascript": "",
            \ "sage": "", "Macaulay2": "", "kdb": "", "clojure": "", "scala": ""}
let s:cmdline_app_pane = ''
let g:cmdline_tmuxsname = {"haskell": "", "julia": "", "lisp": "", "matlab": "", "go": "",
            \ "prolog": "", "python": "", "ruby": "", "sh": "", "javascript": "",
            \ "sage": "", "Macaulay2": "", "kdb": "", "clojure": "", "scala": ""}

" Skip empty lines
function VimCmdLineDown()
    let i = line(".") + 1
    call cursor(i, 1)
    if b:cmdline_send_empty
        return
    endif
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

function VimCmdLineStart_ExTerm(app)
    " Check if the REPL application is already running
    if g:cmdline_tmuxsname[b:cmdline_filetype] != ""
        let tout = system("tmux -L VimCmdLine has-session -t " . g:cmdline_tmuxsname[b:cmdline_filetype])
        if tout =~ "VimCmdLine" || tout =~ g:cmdline_tmuxsname[b:cmdline_filetype]
            unlet g:cmdline_tmuxsname[b:cmdline_filetype]
        else
            echohl WarningMsg
            echo 'Tmux session with "' . b:cmdline_app . '" is already running.'
            echohl Normal
            return
        endif
    endif

    let g:cmdline_tmuxsname[b:cmdline_filetype] = "vcl" . localtime()

    let cnflines = ['set-option -g prefix C-a',
                \ 'unbind-key C-b',
                \ 'bind-key C-a send-prefix',
                \ 'set-window-option -g mode-keys vi',
                \ 'set -g status off',
                \ 'set -g default-terminal "screen-256color"',
                \ "set -g terminal-overrides 'xterm*:smcup@:rmcup@'" ]
    if g:cmdline_external_term_cmd =~ "rxvt" || g:cmdline_external_term_cmd =~ "urxvt"
        let cnflines = cnflines + [
                    \ "set terminal-overrides 'rxvt*:smcup@:rmcup@'" ]
    endif
    call writefile(cnflines, g:cmdline_tmp_dir . "/tmux.conf")


    let cmd = printf(g:cmdline_external_term_cmd,
                \ 'tmux -2 -f "' . g:cmdline_tmp_dir . '/tmux.conf' .
                \ '" -L VimCmdLine new-session -s ' . g:cmdline_tmuxsname[b:cmdline_filetype] . ' ' . a:app)
    call system(cmd)
endfunction

" Run the interpreter in a Tmux panel
function VimCmdLineStart_Tmux(app)
    " Check if Tmux is running
    if $TMUX == ""
        echohl WarningMsg
        echomsg "Cannot start interpreter because not inside a Tmux session."
        echohl Normal
        return
    endif

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
        exe 'echoerr ' . slog
        return
    endif
    let s:cmdline_app_pane = GetTmuxActivePane()
    let slog = system("tmux select-pane -t " . g:cmdline_vim_pane)
    if v:shell_error
        exe 'echoerr ' . slog
        return
    endif
endfunction

" Run the interpreter in a Neovim terminal buffer
function VimCmdLineStart_Nvim(app)
    let edbuf = bufname("%")
    let thisft = b:cmdline_filetype
    if g:cmdline_job[b:cmdline_filetype]
        return
    endif
    set switchbuf=useopen
    if g:cmdline_vsplit
        if g:cmdline_term_width > 16 && g:cmdline_term_width < (winwidth(0) - 16)
            silent exe "belowright " . g:cmdline_term_width . "vnew"
        else
            silent belowright vnew
        endif
    else
        if g:cmdline_term_height > 6 && g:cmdline_term_height < (winheight(0) - 6)
            silent exe "belowright " . g:cmdline_term_height . "new"
        else
            silent belowright new
        endif
    endif
    let g:cmdline_job[thisft] = termopen(a:app, {'on_exit': function('s:VimCmdLineJobExit')})
    let g:cmdline_termbuf[thisft] = bufname("%")
    if g:cmdline_esc_term
        tnoremap <buffer> <Esc> <C-\><C-n>
    endif
    if g:cmdline_outhl
        exe 'runtime syntax/cmdlineoutput_' . a:app . '.vim'
    endif
    normal! G
    exe "sbuffer " . edbuf
    stopinsert
endfunction

function VimCmdLineCreateMaps()
    exe 'nmap <silent><buffer> ' . g:cmdline_map_send . ' :call VimCmdLineSendLine()<CR>'
    exe 'nmap <silent><buffer> ' . g:cmdline_map_send_and_stay . ' :call VimCmdLineSendLineAndStay()<CR>'
    exe 'vmap <silent><buffer> ' . g:cmdline_map_send .
                \ ' <Esc>:call VimCmdLineSendSelection()<CR>'
    if exists("b:cmdline_source_fun")
        exe 'nmap <silent><buffer> ' . g:cmdline_map_source_fun .
                    \ ' :call b:cmdline_source_fun(getline(1, "$"))<CR>'
        exe 'nmap <silent><buffer> ' . g:cmdline_map_send_paragraph .
                    \ ' :call VimCmdLineSendParagraph()<CR>'
        exe 'nmap <silent><buffer> ' . g:cmdline_map_send_block .
                    \ ' :call VimCmdLineSendMBlock()<CR>'
    endif
    if exists("b:cmdline_quit_cmd")
        exe 'nmap <silent><buffer> ' . g:cmdline_map_quit . ' :call VimCmdLineQuit("' . b:cmdline_filetype . '")<CR>'
    endif
endfunction

" Common procedure to start the interpreter
function VimCmdLineStartApp()
    if !exists("b:cmdline_app")
        echomsg 'There is no application defined to be executed for file of type "' . b:cmdline_filetype . '".'
        return
    endif

    call VimCmdLineCreateMaps()

    if !isdirectory(g:cmdline_tmp_dir)
        call mkdir(g:cmdline_tmp_dir)
    endif

    if exists("g:cmdline_external_term_cmd")
        call VimCmdLineStart_ExTerm(b:cmdline_app)
    else
        if g:cmdline_in_buffer
            call VimCmdLineStart_Nvim(b:cmdline_app)
        else
            call VimCmdLineStart_Tmux(b:cmdline_app)
        endif
    endif
endfunction

" Send a single line to the interpreter
function VimCmdLineSendCmd(...)
    if g:cmdline_job[b:cmdline_filetype]
        if g:cmdline_auto_scroll && (!exists('b:cmdline_quit_cmd') || a:1 != b:cmdline_quit_cmd)
            let isnormal = mode() ==# 'n'
            let curwin = winnr()
            exe "sb " . g:cmdline_termbuf[b:cmdline_filetype]
            call cursor('$', 1)
            exe curwin . 'wincmd w'
            if isnormal
                stopinsert
            endif
        endif
        if exists('*chansend')
            call chansend(g:cmdline_job[b:cmdline_filetype], a:1 . b:cmdline_nl)
        else
            call jobsend(g:cmdline_job[b:cmdline_filetype], a:1 . b:cmdline_nl)
        endif
    else
        let str = substitute(a:1, "'", "'\\\\''", "g")
        if str =~ '^-'
            let str = ' ' . str
        endif
        if exists("g:cmdline_external_term_cmd") && g:cmdline_tmuxsname[b:cmdline_filetype] != ""
            let scmd = "tmux -L VimCmdLine set-buffer '" . str .
                        \ "\<C-M>' && tmux -L VimCmdLine paste-buffer -t " . g:cmdline_tmuxsname[b:cmdline_filetype] . '.0'
            call system(scmd)
            if v:shell_error
                echohl WarningMsg
                echomsg 'Failed to send command. Is "' . b:cmdline_app . '" running?'
                echohl Normal
                unlet g:cmdline_tmuxsname[b:cmdline_filetype]
            endif
        elseif s:cmdline_app_pane != ''
            let scmd = "tmux set-buffer '" . str . "\<C-M>' && tmux paste-buffer -t " . s:cmdline_app_pane
            call system(scmd)
            if v:shell_error
                echohl WarningMsg
                echomsg 'Failed to send command. Is "' . b:cmdline_app . '" running?'
                echohl Normal
                let s:cmdline_app_pane = ''
            endif
        endif
    endif
endfunction

" Send current line to the interpreter and go down to the next non empty line
function VimCmdLineSendLine()
    if exists('*b:cmdline_send')
        call b:cmdline_send()
        return
    endif
    let line = getline(".")
    if strlen(line) > 0 || b:cmdline_send_empty
        call VimCmdLineSendCmd(line)
    endif
    call VimCmdLineDown()
endfunction

" Send current line to the interpreter and but keep cursor on current line
function VimCmdLineSendLineAndStay()
    let line = getline(".")
    if strlen(line) > 0 || b:cmdline_send_empty
        call VimCmdLineSendCmd(line)
    endif
endfunction

function VimCmdLineSendSelection()
    if line("'<") == line("'>")
        let i = col("'<") - 1
        let j = col("'>") - i
        let l = getline("'<")
        let line = strpart(l, i, j)
        call VimCmdLineSendCmd(line)
    elseif exists("b:cmdline_source_fun")
        call b:cmdline_source_fun(getline("'<", "'>"))
    endif
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
function VimCmdLineQuit(ftype)
    if exists("b:cmdline_quit_cmd")
        call VimCmdLineSendCmd(b:cmdline_quit_cmd)
        if g:cmdline_termbuf[a:ftype] != ""
            exe "sb " . g:cmdline_termbuf[a:ftype]
            startinsert
            let g:cmdline_termbuf[a:ftype] = ""
        endif
        let g:cmdline_tmuxsname[a:ftype] = ""
        let s:cmdline_app_pane = ''
    else
        echomsg 'Quit command not defined for file of type "' . a:ftype . '".'
    endif
endfunction

" Register that the job no longer exists
function s:VimCmdLineJobExit(job_id, data, etype)
    for ftype in keys(g:cmdline_job)
        if a:job_id == g:cmdline_job[ftype]
            let g:cmdline_job[ftype] = 0
        endif
    endfor
endfunction

" Replace default application with custom one
function VimCmdLineSetApp(ftype)
    if exists("g:cmdline_app")
        for key in keys(g:cmdline_app)
            if key == a:ftype
                let b:cmdline_app = g:cmdline_app[a:ftype]
            endif
        endfor
    endif
    if g:cmdline_job[b:cmdline_filetype] || g:cmdline_tmuxsname[b:cmdline_filetype] != "" || s:cmdline_app_pane != ''
        call VimCmdLineCreateMaps()
    endif
endfunction

" Default mappings
if !exists("g:cmdline_map_start")
    let g:cmdline_map_start = "<LocalLeader>s"
endif
if !exists("g:cmdline_map_send")
    let g:cmdline_map_send = "<Space>"
endif
if !exists("g:cmdline_map_send_and_stay")
    let g:cmdline_map_send_and_stay = "<LocalLeader><Space>"
endif
if !exists("g:cmdline_map_source_fun")
    let g:cmdline_map_source_fun = "<LocalLeader>f"
endif
if !exists("g:cmdline_map_send_paragraph")
    let g:cmdline_map_send_paragraph = "<LocalLeader>p"
endif
if !exists("g:cmdline_map_send_block")
    let g:cmdline_map_send_block = "<LocalLeader>b"
endif
if !exists("g:cmdline_map_quit")
    let g:cmdline_map_quit = "<LocalLeader>q"
endif
