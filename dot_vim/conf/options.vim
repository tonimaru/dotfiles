scriptencoding utf-8

set nocompatible
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,cp932
set ambiwidth=double
set maxmempattern=2000
set swapfile
set backup
set undofile
set number
set nowrap
set hidden
set keywordprg=
set list
set listchars=eol:↴,tab:>-,trail:_,extends:>,precedes:>
set tabstop=4 shiftwidth=4 softtabstop=4
set expandtab smarttab
set autoindent
set ignorecase smartcase
set laststatus=2
set backspace=indent,eol,start
set nofoldenable
set mouse=
set incsearch
set smartindent
if exists("+imdisable")
  set imdisable
endif
set helplang=ja,en
set clipboard=unnamed,unnamedplus
set nofixendofline
set synmaxcol=2000
set conceallevel=0
set background=dark

set diffopt+=vertical,algorithm:histogram,indent-heuristic
set cinoptions+=t0

set completeopt-=preview,longest,noselect,noinsert
set formatoptions-=o
set iskeyword-=.
set iskeyword-=#
set iskeyword-=-

if has('vim_starting')
  set hlsearch
endif

if !has('gui_running')
  if $COLORTERM ==# 'gnome-terminal'
    set t_Co=256
  endif
  if (has('nvim') || has('termguicolors')) && $COLORTERM ==# 'truecolor'
    set termguicolors
  endif
endif

if has("nvim")
  set backupdir-=.
  set inccommand=split
else
  execute "set directory=" .. fnamemodify($MYVIMRC, ":p:h") .. "/swap"
  execute "set backupdir=" .. fnamemodify($MYVIMRC, ":p:h") .. "/backup"
  execute "set undodir=" .. fnamemodify($MYVIMRC, ":p:h") .. "/undo"
  if has('vim_starting')
    let &t_SI .= "\e[6 q"
    let &t_EI .= "\e[2 q"
    let &t_SR .= "\e[4 q"
  endif
endif
