set background=dark
if !exists("g:syntax_on")
  syntax enable
endif
colorscheme dues

set cursorline
" Default Colors for CursorLine
highlight CursorLine term=none cterm=none ctermbg=Black guibg=Grey20

" Disable CursorLine for Insert mode 
autocmd InsertEnter * set nocursorline

" turn CursorLine highlight back on for all other modes
autocmd InsertLeave * set cursorline

if has("gui_macvim") || exists('strong')
  filetype off                  " required
  if &compatible
    set nocompatible
  endif
  highlight Normal ctermbg=none
  highlight Cursor guifg=white guibg=pink
  highlight iCursor guifg=white guibg=steelblue
  "set guicursor=n-v-c:block-Cursor
  "set guicursor+=i:ver10-iCursor
  "set guicursor+=n-v-c:blinkon0
  "set guicursor+=i:blinkwait10

	" set the runtime path to include Vundle and initialize
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()
	" alternatively, pass a path where Vundle should install plugins
	"call vundle#begin('~/some/path/here')

	" let Vundle manage Vundle, required
	Plugin 'VundleVim/Vundle.vim'

	"
	" ma pluggins
	"
	"
	Plugin 'Valloric/YouCompleteMe'
  Plugin 'rust-lang/rust.vim'
  Bundle 'cespare/vim-toml'

	" All of your Plugins must be added before the following line
	call vundle#end()            " required
	filetype plugin indent on    " required
	" To ignore plugin indent changes, instead use:
	"filetype plugin on
	"
	" Brief help
	" :PluginList       - lists configured plugins
	" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
	" :PluginSearch foo - searches for foo; append `!` to refresh local cache
	" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
	"
	" see :h vundle for more details or wiki for FAQ
	" Put your non-Plugin stuff after this line
  let g:ycm_rust_src_path = '$HOME/.cargo/registry/src/github.com-1ecc6299db9ec823'
endif

" up/down on wrarped lines
map j gj
map k gk

if &compatible                " vim not vi, if not already set 
  set nocompatible
endif
filetype on                   " Enable filetype detection
filetype indent on            " Enable filetype-specific indenting
filetype plugin on            " Enable filetype-specific plugins
set spell spelllang=en         " most stuff is english
set expandtab			            " make tabs spaces
set smarttab                  " tab and backspace are smart
set shiftwidth=2
set noeb vb t_vb=							" turn off the annoying bell
set ruler                     " show the line number on the bar
set more                      " use more prompt
set autoread                  " watch for file changes
set number                    " line numbers
set noautowrite               " don't automagically write on :next
set lazyredraw                " don't redraw when don't have to
set showmode
set showcmd
set autoindent smartindent    " auto/smart indent
set scrolloff=10              " keep at least 5 lines above/below
set sidescrolloff=5           " keep at least 5 lines left/right
set history=200
set backspace=indent,eol,start
set linebreak
set cmdheight=2               " command line two lines high
set undolevels=1000           " 1000 undos
set updatecount=100           " switch every 100 chars
set complete=.,w,b,u,U,t,i,d  " do lots of scanning on tab completion
set ttyfast                   " we have a fast terminal
set noerrorbells              " No error bells please
set shell=zsh
set fileformats=unix
set ff=unix
set wildmode=longest:full
set wildmenu                  " menu has tab completion
let maplocalleader=','        " all my macros start with ,
set laststatus=2
set colorcolumn=80

"don't set tabstop, use softtabstop and shiftwidth instead
"set tabstop=2                 " 6 spaces
"set hidden

"  searching
set incsearch                 " incremental search
set ignorecase                " search ignoring case
set hlsearch                  " highlight the search
set showmatch                 " show matching bracket
set diffopt=filler,iwhite     " ignore all whitespace and sync

" for spin file type
au BufRead,BufNewFile *.spin set filetype=spin 
" for waterslide
au BufRead,BufNewFile *.ws set filetype=sh 
au! Syntax spin source $HOME/.vim/syntax/spin.vim

"  backup
"  set backup
"  set backupdir=~/.vim_backup
"  set viminfo=%100,'100,/100,h,\"500,:100,n~/.viminfo
"set viminfo='100,f1

"" spelling
"if v:version >= 700
"  " Enable spell check for text files
"  autocmd Filetype text,c,cpp,md,markdown,bash,rust,python setlocal spell spelllang=en
"endif

" mappings
" toggle list mode
nmap <LocalLeader>tl :set list!<cr>
" toggle paste mode
nmap <LocalLeader>pp :set paste!<cr>

set rtp+=/usr/local/opt/fzf
