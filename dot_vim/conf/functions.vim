function! Root_dir()
  let l:gitroot = system('git rev-parse --show-toplevel')
  if v:shell_error == 0
    return l:gitroot
  endif
  return expand('%:p:h')
endfunction

function! Terminal_exec(cmd, ...) abort
  silent! write

  if win_gotoid(s:term_winid) == 1
    close!
  endif

  let l:args = substitute(join(a:000), '\s\+$', '', '')
  if has('nvim')
    let l:cmd = 'terminal'
  elseif has('terminal')
    let l:cmd = 'terminal ++curwin'
  else
    let l:cmd = '!'
  endif
  noautocmd new
  let s:term_winid = win_getid()
  execute l:cmd 'set' '-x' '&&' a:cmd l:args
endfunction

if !exists("s:term_winid")
  let s:term_winid = 0
endif
