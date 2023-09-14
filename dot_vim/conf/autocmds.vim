augroup my_vimrc
  autocmd!
augroup END

autocmd my_vimrc CmdwinEnter * call s:init_cmdwin()
function! s:init_cmdwin() abort
  nnoremap <buffer><silent><nowait> <ESC> <C-w>c
  vnoremap <buffer><silent><nowait> <ESC> <C-w>c
  nnoremap <buffer><silent><nowait> q <C-w>c
  vnoremap <buffer><silent><nowait> q <C-w>c
  startinsert!
endfunction

autocmd my_vimrc FileType help noremap <buffer><nowait> q <C-w>c

function! s:ft_go() abort
  setlocal noexpandtab
endfunction
autocmd my_vimrc FileType go call s:ft_go()

function! s:indent2() abort
  setlocal tabstop=2 shiftwidth=2 softtabstop=2
endfunction
autocmd my_vimrc FileType vim,proto,sql,go call s:indent2()

autocmd my_vimrc WinEnter * checktime

autocmd my_vimrc BufNewFile,BufRead *.tmpl call s:ft_gotmpl()
function! s:ft_gotmpl() abort
  if search('{{.\+}}', 'nw') || filereadable(findfile('go.mod', ".;"))
    setlocal filetype=gotmpl
  endif
endfunction

if has('nvim')
  autocmd my_vimrc TermOpen * startinsert
  autocmd my_vimrc TermOpen * ++once call s:term_init()
  function! s:term_init() abort
    tnoremap <silent> <ESC> <C-\><C-n>
    tnoremap <silent> <M-Left> <Esc>b
    tnoremap <silent> <M-Right> <Esc>f
  endfunction
endif

function! s:lazy_init() abort
  autocmd my_vimrc BufEnter * silent! if isdirectory(expand('%:p:h')) | silent! lcd %:p:h | endif

  autocmd my_vimrc CursorHold * call s:clean_no_name_empty_buffers()
  function! s:clean_no_name_empty_buffers() abort
      let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val) < 0 && (getbufline(v:val, 1, "$") == [""]) && getbufinfo(v:val)[0].changed == 0 && &buftype != "terminal"')
      if !empty(buffers)
          silent exe 'bd '.join(buffers, ' ')
      endif
  endfunction

  if executable('chezmoi')
    function! s:chezmoi_apply(file) abort
      let cmd = ['chezmoi', 'apply', '--source-path', a:file]
      if has('nvim')
        call jobstart(cmd)
      else
        call job_start(cmd)
      endif
    endfunction
    function! s:chezmoi_autocmd(source_path) abort
      if a:source_path == ''
        return
      endif
      execute 'autocmd my_vimrc BufWritePost ' . a:source_path . '/* call s:chezmoi_apply(expand("<afile>:p"))'
    endfunction
    if has('nvim')
      call jobstart(['chezmoi', 'source-path'], #{on_stdout: {ch, data, name -> s:chezmoi_autocmd(trim(join(data)))}})
    else
      call job_start(['chezmoi', 'source-path'], #{out_cb: {ch, msg -> s:chezmoi_autocmd(trim(msg))}})
    endif
  endif
endfunction

au BufReadPost * ++once call s:lazy_init()
