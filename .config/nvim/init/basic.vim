""" vi compatible
"set compatible=off
""" character code
set fenc=utf-8
set fileencodings=utf-8,cp932,sjis,cp51932,euc-jp
set ambiwidth=double
""" bak,undo,swap files
set backup
set writebackup
set backupext=.bak """extention
set swapfile
set updatetime=300000
set noundofile
execute 'set directory='.g:vim_dir.'/swp'
execute 'set backupdir='.g:vim_dir.'/bak'
execute 'set undodir='.g:vim_dir.'/undo'
""" viminfo
set viminfo=
""" line number
set number
set numberwidth=6
""" bracket matching
set showmatch
""" status line
set laststatus=2
let ff_table = {'dos' : 'CR+LF', 'unix' : 'LF', 'mac' : 'CR' }
set statusline=%F[%R%M]\ %=\ %4l,%4c\ 0x%04B\ %{&fenc}\ %{ff_table[&ff]}\ [%Y]
set showcmd
set showmode
""" title settings
set title
set titlestring=%f
""" cursor highlight
set virtualedit=onemore
set cursorline
"se cursorcolumn
""" tab settings
set tabline=
set showtabline=1
""" save check
set confirm 
""" visual
set list
set listchars=tab:@-,eol:$,extends:~,trail:␣
set nowrap
""" tab char
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab
set autoindent
set smartindent
set cindent
set smarttab
""" mouse
set mouse=a
""" search
set ignorecase
set smartcase
set wrapscan
set incsearch
set hlsearch
set wildmode=list:longest


""" clipboard
if has('win32') || has('win64') || has('mac')
	set clipboard=unnamed
else
	set clipboard=unnamedplus
endif

""" key map
nm <Esc><Esc> :nohlsearch<CR><Esc>
nm j gj
nm k gk
nn == gg=G''
nn <F12> :set relativenumber!<CR>

""" options
syntax enable
lan C.utf8
