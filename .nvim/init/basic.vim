" code
set fenc=utf-8
set backup
set writebackup
set backupext=.bak
set swapfile
set updatetime=300000
set noundofile
execute 'set directory='.g:vim_dir.'/swp'
execute 'set backupdir='.g:vim_dir.'/bak'
execute 'set undodir='.g:vim_dir.'/undo'
set viminfo=
" visual
set number
set numberwidth=6
set showmatch
set virtualedit=onemore
set laststatus=2
let ff_table = {'dos' : 'CR+LF', 'unix' : 'LF', 'mac' : 'CR' }
set statusline=%F[%R%M]\ %=\ %4l,%4c\ 0x%04B\ %{&fenc}\ %{ff_table[&ff]}\ [%Y]
set title
set titlestring=%f
set cursorline
set ambiwidth=double
set showmode
set showcmd
set showtabline=1

set tabline=
set confirm
"se cursorcolumn
set list
set listchars=tab:@-,eol:$,extends:~
set nowrap
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set cindent
set smarttab
set mouse=a
" search
set ignorecase
set smartcase
set wrapscan
set incsearch
set hlsearch
set fileencodings=utf-8,cp932,sjis,cp51932,euc-jp
set wildmode=list:longest

if has('win32') || has('win64') || has('mac')
	set clipboard=unnamed
else
	set clipboard=unnamedplus
endif

nm <Esc><Esc> :nohlsearch<CR><Esc>
nm j gj
nm k gk
nn == gg=G''
nn <F12> :set relativenumber!<CR>

" options
syntax enable
lan C.utf8
