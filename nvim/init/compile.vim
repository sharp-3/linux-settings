
nnoremap <F5> :w<CR>:!make<CR>
inoremap <F5> <Esc>:w<CR>:!make<CR>
"nnoremap <F6> :w<CR>:make run<CR>
"inoremap <F6> <Esc>:w<CR>:make run<CR>
"au QuickfixCmdPost make copen
nnoremap <F2> :w<CR>:!platex -shell-escape %:p && dvipdfmx %:p:r.dvi<CR>
inoremap <F2> <Esc>:w<CR>:!platex -shell-escape %:p && dvipdfmx %:p:r.dvi<CR>

