let g:vim_dir = expand('<sfile>:p:h')

for f in split(glob(g:vim_dir.'/init/*.vim'),'\n')
	exe 'source' f
endfor
