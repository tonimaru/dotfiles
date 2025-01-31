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
else
  autocmd my_vimrc InsertEnter * set timeoutlen=50
  autocmd my_vimrc InsertLeave * set timeoutlen=1000
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
    func s:job(cmd, cb) abort
      if has('nvim')
        call jobstart(a:cmd, #{on_stdout: {ch, data, name -> a:cb(trim(join(data)))}})
      else
        call job_start(a:cmd, #{out_cb: {ch, msg -> a:cb(trim(msg))}})
      endif
    endfunc
    function! s:chezmoi_target_doautocmd(file)
      doautocmd "BufWritePost" a:file
    endfunction
    function! s:chezmoi_target_path(file)
      let cmd = ['chezmoi', 'target-path', a:file]
      call s:job(cmd, function("s:chezmoi_target_doautocmd"))
    endfunction
    function! s:chezmoi_apply(file) abort
      let cmd = ['chezmoi', 'apply', '--force', '--source-path', a:file]
      call s:job(cmd, function("s:chezmoi_target_path"))
    endfunction
    function! s:chezmoi_autocmd(source_path) abort
      if a:source_path == ''
        return
      endif
      execute 'autocmd my_vimrc BufWritePost ' . a:source_path . '/* call s:chezmoi_apply(expand("<afile>:p"))'
    endfunction
    call s:job(['chezmoi', 'source-path'], function("s:chezmoi_autocmd"))
  endif
endfunction

au BufReadPost * ++once call s:lazy_init()
