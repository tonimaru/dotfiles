let s:base_path = expand('~/.cache/dein')
let s:dein_path = expand(s:base_path . '/repos/github.com/Shougo/dein.vim')

if !isdirectory(s:dein_path)
  if executable('git')
    echo 'Install dein.'
    silent execute printf('!mkdir -p %s', s:dein_path)
    call system(printf('git clone https://github.com/Shougo/dein.vim.git %s', s:dein_path))
    if v:shell_error
      finish
    endif
  else
    finish
  endif
endif

if has('vim_starting')
  execute printf('set runtimepath+=%s', s:dein_path)
endif

let s:vimrcs = [
      \   '%',
      \   '~/.vim/plugins.toml',
      \   '~/.vim/plugins_settings.vim',
      \   '~/.vim/local_plugins.toml',
      \   '~/.vim/local_plugins_settings.vim'
      \ ]
call dein#begin(s:base_path, map(s:vimrcs, 'expand(v:val)'))
call dein#add('Shougo/dein.vim')

if filereadable(expand('~/.vim/plugins.toml'))
  call dein#load_toml(expand('~/.vim/plugins.toml'))
endif
silent! call dein#load_toml(expand('~/.vim/local_plugins.toml'))

silent! if dein#check_install()
  if has('vim_starting')
    echo 'Install plugins.'
    silent call dein#install()
  else
    call dein#install()
  endif
endif

execute 'source' expand('~/.vim/plugins_settings.vim')
silent! execute 'source' expand('~/.vim/local_plugins_settings.vim')

call dein#end()

filetype plugin indent on

unlet s:dein_path
unlet s:base_path
