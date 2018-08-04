set shell=/bin/sh

set encoding=utf-8
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'lervag/vimtex'
Plugin 'tmhedberg/SimpylFold'
"Plugin 'vim-syntastic/syntastic'
Plugin 'kien/ctrlp.vim'
"Plugin 'vimwiki/vimwiki'
"Plugin 'suan/vim-instant-markdown'
Bundle 'Rykka/riv.vim'
Plugin 'Rykka/InstantRst'
Plugin 'lyokha/vim-xkbswitch'

call vundle#end()

let g:XkbSwitchEnabled = 1

let proj1 = { 'path': '~/notes', }
let g:riv_projects = [proj1]
let g:riv_web_browser='chromium'

"let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
"let g:instant_markdown_autostart = 0 " disable autostart
"let g:instant_markdown_slow = 1
"map <leader>md :InstantMarkdownPreview<CR>

filetype plugin indent on

" Enable system clipboard
set clipboard=unnamedplus

"NERDtree settings
"NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"map a specific key or shortcut to open NERDTree
map <C-n> :NERDTreeToggle<CR>
"end

"Fix undo in insert mode
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" show a visual current line
set cursorline
hi CursorLine cterm=NONE term=bold cterm=bold ctermbg=17
"colors table: https://vignette.wikia.nocookie.net/vim/images/1/16/Xterm-color-table.png/revision/latest?cb=20110121055231
"from: http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
"Other good color for me
"hi CursorLine cterm=NONE term=bold cterm=bold ctermbg=53

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" NEW COMMANDS
set printencoding=koi8-r
command! Topdf hardcopy > %:t.ps | !ps2pdf %:t.ps && rm %:t.ps
"

command! -nargs=1 FromURL read !curl -s <q-args> 

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-@> :nohl<CR><C-l>

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Delete without cut
nnoremap <leader>d "_d

" Enable folding with the spacebar
nnoremap <space> zA

set foldenable
set foldmethod=syntax

"make find to subdirs
set path+=**

set backupdir=~/tmp
set directory=~/tmp

let NERDTreeShowHidden=1

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
"set list " включить подсветку нечитаемых символов
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


"Lets
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_view_method = "zathura"

if has('gui')
  set guioptions-=e
endif
if exists("+showtabline")
  function! MyTabLine()
    let s = ''
    let t = tabpagenr()
    let i = 1
    while i <= tabpagenr('$')
      let buflist = tabpagebuflist(i)
      let winnr = tabpagewinnr(i)
      let s .= '%' . i . 'T'
      let s .= (i == t ? '%1*' : '%2*')
      let s .= ' '
      let s .= i . ':'
      "let s .= winnr . '/' . tabpagewinnr(i,'$')
      let s .= ' %*'
      let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
      let bufnr = buflist[winnr - 1]
      let file = bufname(bufnr)
      let buftype = getbufvar(bufnr, 'buftype')
      if buftype == 'nofile'
        if file =~ '\/.'
          let file = substitute(file, '.*\/\ze.', '', '')
        endif
      else
        let file = fnamemodify(file, ':p:t')
      endif
      if file == ''
        let file = '[No Name]'
      endif
      let s .= file
      let i = i + 1
    endwhile
    let s .= '%T%#TabLineFill#%='
    let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
    return s
  endfunction
  set stal=1
  set tabline=%!MyTabLine()
endif

" Add format option 'w' to add trailing white space, indicating that paragraph
" continues on next line. This is to be used with mutt's 'text_flowed' option.
augroup mail_trailing_whitespace " {
    autocmd!
    autocmd FileType mail setlocal formatoptions+=w
augroup END " }

