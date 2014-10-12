set nocompatible			" Use Vim defaults instead of 100% vi compatibility
set backspace=indent,eol,start		" delete the white space at start of the line, a line break and the character before Ins mode started
if has("vms")
	set nobackup			" do not keep a backup file, use versions instead
else
	set backup			" keep a backup file (restore to previous version)
	set undofile			" keep an undo file (undo changes after closing)
	set backupdir=~/.vim/backup
endif
" save swp files in /tmp/vim-swp
if isdirectory('/tmp/vim-swp') == 0
	:silent !mkdir -p /tmp/vim-swp > /dev/null 2>&1
endif
set directory=/tmp/vim-swp//
set history=100				" commands and search history size
set ruler				" show the current cursor position in the lower right corner
set showcmd				" display an incomplete command in lower right corner
set incsearch				" color search results while typing search query
" Don't use Ex mode, use Q for formatting
map Q gq
set number

if has('mouse')				" In many terminal emulators the mouse works just fine, thus enable it.
	set mouse=a
endif

if &t_Co > 2 || has("gui_running")	" if colors available
	syntax on			" switch on syntax highlighting
	set hlsearch			" highlight matches of the last used search pattern
endif

filetype plugin indent on		" indent by filetype

" This is used after reading any file. Checks if the '" mark is defined, and jumps to it if so.
autocmd BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") |
	\	exe "normal! g`\"" |
	\ endif

set whichwrap=b,s			" backspace and space to wrap between lines
set listchars=tab:>-,trail:-		" show tabs as >--- and trailing spaces as - with set list option

setlocal spelllang=ru_yo,en_us	" set spellchecking
" set keymap=russian-jcukenwin
" set iminsert=0
" set imsearch=0
" avoid switching between keyboards in normal mode
:set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчняэёжб;abcdefghijklmnopqrstuvwxyz'`\\\;\\\,
