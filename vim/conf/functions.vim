function! Root_dir()
  let l:gitroot = system('git rev-parse --show-toplevel')
  if v:shell_error == 0
    return l:gitroot
  endif
  return expand('%:p:h')
endfunction

function! Terminal_exec(cmd, ...) abort
  silent! write
  let l:args = substitute(join(a:000), '\s\+$', '', '')
  if has('nvim')
      let l:cmd = 'terminal'
  elseif has('terminal')
      let l:cmd = 'terminal ++curwin'
  else
      let l:cmd = '!'
  endif
  noautocmd new
  execute l:cmd 'set' '-x' '&&' a:cmd l:args
endfunction
