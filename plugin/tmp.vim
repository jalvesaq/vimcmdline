execute 'nnoremap <silent><buffer>' . g:cmdline_visual_send_line_mapping . ':call VimCmdLineSendLine()'<CR>
nnoremap <silent><buffer> <Space> :call VimCmdLineSendLine()<CR>

execute 'vnoremap <silent><buffer>' . g:cmdline_visual_send_line_mapping . '<esc>:call ' . b:cmdline_source_fun(getline("'<", "'>"))<CR>

execute 'nnoremap <silent><buffer>' . g:cmdline_send_file_mapping . ':call ' . b:cmdline_source_fun(getline(1, "$"))<CR>
execute 'nnoremap <silent><buffer>' . g:cmdline_send_paragraph_mapping . ':call VimCmdLineSendParagraph()'<CR>
execute 'nnoremap <silent><buffer>' . g:cmdline_send_marked_block_mapping . ':call VimCmdLineSendMBlock()'<CR>
execute 'nnoremap <silent><buffer>' . g:cmdline_quit_mapping . ':call VimCmdLineQuit()'<CR>
execute 'nnoremap <silent><buffer>' . g:cmdline_start_mapping . 'call VimCmdLineStartApp()'

tnoremap <buffer> <Esc> <C-\><C-n>
nmap <silent><buffer> <Space> :call VimCmdLineSendLine()<CR>
vmap <silent><buffer> <Space> <Esc>:call b:cmdline_source_fun(getline("'<", "'>"))<CR>
nmap <silent><buffer> <LocalLeader>f :call b:cmdline_source_fun(getline(1, "$"))<CR>
nmap <silent><buffer> <LocalLeader>p :call VimCmdLineSendParagraph()<CR>
nmap <silent><buffer> <LocalLeader>b :call VimCmdLineSendMBlock()<CR>
nmap <silent><buffer> <LocalLeader>q :call VimCmdLineQuit()<CR>

let g:cmdline_send_line_mapping = '<space>'
let g:cmdline_visual_send_line_mapping = '<space>'
let g:cmdline_send_file_mapping = '<LocalLeader>f'
let g:cmdline_send_paragraph_mapping = '<LocalLeader>p'
let g:cmdline_send_marked_block_mapping = '<LocalLeader>b'
let g:cmdline_quit_mapping = '<LocalLeader>q'
