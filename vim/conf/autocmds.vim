augroup my_vimrc
  autocmd!
augroup END

autocmd my_vimrc CmdwinEnter * call s:init_cmdwin()
function! s:init_cmdwin()
  nnoremap <buffer><silent><nowait> <ESC> <C-w>c
  vnoremap <buffer><silent><nowait> <ESC> <C-w>c
  nnoremap <buffer><silent><nowait> q <C-w>c
  vnoremap <buffer><silent><nowait> q <C-w>c
  startinsert!
endfunction

autocmd my_vimrc FileType help noremap <buffer><nowait> q <C-w>c

autocmd my_vimrc WinEnter * checktime

autocmd my_vimrc BufNewFile,BufRead *.tmpl call s:ft_gotmpl()
function! s:ft_gotmpl()
  if search('{{.\+}}', 'nw') || filereadable(findfile('go.mod', ".;"))
    setlocal filetype=gotmpl
  endif
endfunction

autocmd my_vimrc BufEnter * silent! if isdirectory(expand('%:p:h')) | silent! lcd %:p:h | endif

autocmd my_vimrc CursorHold * call s:clean_no_name_empty_buffers()
function! s:clean_no_name_empty_buffers()
    let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val) < 0 && (getbufline(v:val, 1, "$") == [""]) && getbufinfo(v:val)[0].changed == 0')
    if !empty(buffers)
        silent exe 'bd '.join(buffers, ' ')
    endif
endfunction

if has('nvim')
  autocmd my_vimrc BufEnter * call timer_start(10, function("s:set_updatetime"))
  function! s:set_updatetime(id)
    if get(b:, "is_nivm_lsp_attached", v:false)
      set updatetime=300
    else
      set updatetime=4000
    endif
  endfunction

  autocmd my_vimrc TermOpen * startinsert
end

command! -bang -nargs=* Au autocmd<bang> my_vimrc <args>
