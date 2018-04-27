set shell=/bin/fish

set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'davidhalter/jedi-vim'
Plugin 'lervag/vimtex'
 
call vundle#end()

filetype plugin indent on

"NERDtree settings
"NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"map a specific key or shortcut to open NERDTree
map <C-n> :NERDTreeToggle<CR>
"end

set backupdir=~/tmp
set directory=~/tmp

set incsearch
set ignorecase smartcase
set number
set relativenumber
set termencoding=utf8
set ruler
set showcmd
set foldenable
syntax enable
set scrolloff=3
set wrap
set autoread
set t_Co=256
autocmd! bufwritepost $MYVIMRC source $MYVIMRC
set statusline=%F%m%r%h%w\ [FF,FE,TE=%{&fileformat},%{&fileencoding},%{&encoding}\]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
hi StatusLine gui=reverse cterm=reverse
"Alvays show status bar
set laststatus=2
"set list " включить подсветку
"set listchars=tab:>-,trail:- " установить символы, которыми будет осуществляться подсветка
set nohlsearch
"НАСТРОЙКИ ОТСТУПА
set shiftwidth=4 " размер отступов (нажатие на << или >>)
set tabstop=4 " ширина табуляции
set softtabstop=4 " ширина 'мягкого' таба
set expandtab " преобразовать табуляцию в пробелы


function! SuperCleverTab()
	if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
		return "\<Tab>"
	else
		return "\<C-p>"
	endif
endfunction

inoremap <Tab> <C-R>=SuperCleverTab()<cr>
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2016 Jul 28
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
filetype plugin indent on

if version >= 700
	set history=64
	set undolevels=128
	set undodir=~/.vim/undodir/
	set undofile
	set undolevels=1000
	set undoreload=10000
endif

if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
if has('syntax') && has('eval')
  packadd matchit
endif
