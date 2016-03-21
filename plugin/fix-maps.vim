tnoremap <buffer> <Esc> <C-\><C-n>
nmap <silent><buffer> <Space> :call VimCmdLineSendLine()<CR>
vmap <silent><buffer> <Space> <Esc>:call b:cmdline_source_fun(getline("'<", "'>"))<CR>
nmap <silent><buffer> <LocalLeader>f :call b:cmdline_source_fun(getline(1, "$"))<CR>
nmap <silent><buffer> <LocalLeader>p :call VimCmdLineSendParagraph()<CR>
nmap <silent><buffer> <LocalLeader>b :call VimCmdLineSendMBlock()<CR>
nmap <silent><buffer> <LocalLeader>q :call VimCmdLineQuit()<CR>

g:cmdline_send_line_mapping
g:cmdline_visual_send_line_mapping
g:cmdline_send_file_mapping
g:cmdline_send_paragraph_mapping
g:cmdline_send_marked_block_mapping
g:cmdline_quit_mapping
g:cmdline_start_mapping

if !exists("g:cmdline_send_line_mapping")
let g:cmdline_send_line_mapping = '<space>'
endif
execute 'nnoremap <silent><buffer>' . g:cmdline_visual_send_line_mapping . ':call VimCmdLineSendLine()'<CR>
nnoremap <silent><buffer> <Space> :call VimCmdLineSendLine()<CR>


if !exists("g:cmdline_visual_send_line_mapping")
let g:cmdline_visual_send_line_mapping = '<space>'
endif
execute 'vnoremap <silent><buffer>' . g:cmdline_visual_send_line_mapping . '<esc>:call ' . b:cmdline_source_fun(getline("'<", "'>"))<CR>

if !exists("g:cmdline_send_file_mapping")
let g:cmdline_send_file_mapping = '<LocalLeader>f'
endif
execute 'nnoremap <silent><buffer>' . g:cmdline_send_file_mapping . ':call ' . b:cmdline_source_fun(getline(1, "$"))<CR>

if !exists("g:cmdline_send_paragraph_mapping")
let g:cmdline_send_paragraph_mapping = '<LocalLeader>p'
endif
execute 'nnoremap <silent><buffer>' . g:cmdline_send_paragraph_mapping . ':call VimCmdLineSendParagraph()'<CR>
endif

if !exists("g:cmdline_send_marked_block_mapping")
let g:cmdline_send_marked_block_mapping = '<LocalLeader>b'
endif
execute 'nnoremap <silent><buffer>' . g:cmdline_send_marked_block_mapping . ':call VimCmdLineSendMBlock()'<CR>

if !exists("g:cmdline_quit_mapping")
let g:cmdline_quit_mapping = '<LocalLeader>q'
endif
execute 'nnoremap <silent><buffer>' . g:cmdline_quit_mapping . ':call VimCmdLineQuit()'<CR>

if !exists("g:cmdline_start_mapping")
let g:cmdline_start_mapping = '<LocalLeader>s'
endif
execute 'nnoremap <silent><buffer>' . g:cmdline_start_mapping . 'call VimCmdLineStartApp()'
