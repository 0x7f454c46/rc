" Use Vim defaults instead of 100% vi compatibility
set nocompatible
" delete the white space at start of the line,
" a line break and the character before Ins mode started
set backspace=indent,eol,start
if has("vms")
	" do not keep a backup file, use versions instead
	set nobackup
else
	" keep a backup file (restore to previous version)
	set backup
	if isdirectory('~/.vim/backup') == 0
		:silent !mkdir -p ~/.vim/backup > /dev/null 2>&1
	endif
	set backupdir=~/.vim/backup

	" keep an undo file (undo changes after closing)
	set undofile
	if isdirectory('~/.vim/undo') == 0
		:silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
	endif
	set undodir=~/.vim/undo//
endif

" save swp files in /tmp/vim-swp
if isdirectory('/tmp/vim-swp') == 0
	:silent !mkdir -p /tmp/vim-swp > /dev/null 2>&1
endif
set directory=/tmp/vim-swp//

" commands and search history size
set history=1000
" show the current cursor position in the lower right corner
set ruler
" display an incomplete command in lower right corner
set showcmd
" color search results while typing search query
set incsearch
" Don't use Ex mode, use Q for formatting
map Q gq
set number

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
	set mouse=a
endif

if &t_Co > 2 || has("gui_running")	" if colors available
	" switch on syntax highlighting
	syntax on
	" highlight matches of the last used search pattern
	set hlsearch
endif

filetype plugin indent on		" indent by filetype

" This is used after reading any file.
" Checks if the '" mark is defined, and jumps to it if so.
autocmd BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") |
	\	exe "normal! g`\"" |
	\ endif

" backspace and space to wrap between lines
set whichwrap=b,s
" show tabs as >--- and trailing spaces as - with set list option
set listchars=tab:>-,trail:-

setlocal spelllang=ru_yo,en_us	" set spellchecking
" set keymap=russian-jcukenwin
" set iminsert=0
" set imsearch=0
" avoid switching between keyboards in normal mode
:set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчняэёжб;abcdefghijklmnopqrstuvwxyz'`\\\;\\\,

set cc=81

" Vundle clone it with
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
