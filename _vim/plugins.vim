if !isdirectory(expand('~/.vim/bundle/repos/github.com/Shougo/dein.vim'))
  if executable('git')
    silent execute "!mkdir -p" expand('~/.vim/bundle/repos/github.com/Shougo/dein.vim')
    call system('git clone https://github.com/Shougo/dein.vim.git ' . expand('~/.vim/bundle/repos/github.com/Shougo/dein.vim'))
    if v:shell_error
      finish
    endif
  else
    finish
  endif
endif

if has('vim_starting')
  set runtimepath^=~/.vim/bundle/repos/github.com/Shougo/dein.vim
endif

let s:vimrcs = [
      \   '%',
      \   '~/.vim/plugins.toml',
      \   '~/.vim/plugins_settings.vim',
      \   '~/.vim/local_plugins.toml',
      \   '~/.vim/local_plugins_settings.vim'
      \ ]
call dein#begin(expand('~/.vim/bundle'), map(s:vimrcs, "expand(v:val)"))
call dein#add('Shougo/dein.vim')

if filereadable(expand('~/.vim/plugins.toml'))
  call dein#load_toml(expand('~/.vim/plugins.toml'))
endif
silent! call dein#load_toml(expand('~/.vim/local_plugins.toml'))

silent! if dein#check_install()
  if has('vim_starting')
    echo "Install plugins."
    silent call dein#install()
  else
    call dein#install()
  endif
endif

execute 'source' expand('~/.vim/plugins_settings.vim')
silent! execute 'source' expand('~/.vim/local_plugins_settings.vim')

call dein#end()

filetype plugin indent on

