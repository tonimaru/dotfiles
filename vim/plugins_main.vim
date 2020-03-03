let s:is_mswin = has('win95') || has('win16') || has('win32') || has('win64')
let s:vimfiles_name = s:is_mswin ? 'vimfiles' : '.vim'
let s:vimfiles = expand(printf('%s/%s', $HOME, s:vimfiles_name))
function! s:vimdir(dir)
  return expand(printf('%s/%s', s:vimfiles, a:dir))
endfunction

let s:base_path = expand('~/.local/share/dein')
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
      \   expand('%'),
      \   s:vimdir('plugins.vim'),
      \   s:vimdir('plugins_settings.vim'),
      \   s:vimdir('local_plugins.vim'),
      \   s:vimdir('local_plugins_settings.vim')
      \ ]
call dein#begin(s:base_path, s:vimrcs)
call dein#add('Shougo/dein.vim')

if filereadable(s:vimdir('plugins.vim'))
  execute 'source' s:vimdir('plugins.vim')
endif
if filereadable(s:vimdir('local_plugins.vim'))
  execute 'source' s:vimdir('local_plugins.vim')
endif
execute 'source' s:vimdir('plugins_settings.vim')
silent! execute 'source' s:vimdir('local_plugins_settings.vim')

silent! if dein#check_install()
  if has('vim_starting')
    echo 'Install plugins.'
    silent call dein#install()
  else
    call dein#install()
  endif
endif

call dein#end()

filetype plugin indent on

execute 'source' s:vimdir('plugins.vim')
execute 'nnoremap' '[prefix]en' ':e' s:vimdir('plugins.vim').'<CR>'

unlet s:dein_path
unlet s:base_path
unlet s:vimfiles
unlet s:vimfiles_name
unlet s:is_mswin

