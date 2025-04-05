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
  setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
endfunction
autocmd my_vimrc FileType go call s:ft_go()

function! s:indent2() abort
  setlocal tabstop=2 shiftwidth=2 softtabstop=2
endfunction
autocmd my_vimrc FileType vim,proto,sql call s:indent2()

autocmd my_vimrc WinEnter * checktime

if has('nvim')
  autocmd my_vimrc TermOpen * call s:term_open()
  function! s:term_open() abort
    if &previewwindow
      return
    endif
    startinsert
  endfunction
  autocmd my_vimrc TermOpen * ++once call s:term_init()
  function! s:term_init() abort
    tnoremap <silent> <ESC> <C-\><C-n>
    tnoremap <silent> <M-Left> <Esc>b
    tnoremap <silent> <M-Right> <Esc>f
  endfunction
  hi DimNormal guibg=#202020
  autocmd my_vimrc WinEnter * setlocal winhighlight=
  autocmd my_vimrc WinLeave * setlocal winhighlight=Normal:DimNormal
else
  autocmd my_vimrc InsertEnter * set timeoutlen=50
  autocmd my_vimrc InsertLeave * set timeoutlen=1000
endif

function! s:lazy_init() abort
  autocmd my_vimrc BufEnter * silent! call s:auto_lcd()
  function s:auto_lcd() abort
    if filereadable(expand('%:p'))
      silent! lcd %:p:h
    endif
  endfunction

  autocmd my_vimrc CursorHold * call s:clean_no_name_empty_buffers()
  function! s:clean_no_name_empty_buffers() abort
    if expand('%') =~# '^ddu-.*$'
      return
    endif
    let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val) < 0 && (getbufline(v:val, 1, "$") == [""]) && getbufinfo(v:val)[0].changed == 0 && &buftype != "terminal"')
    if !empty(buffers)
      silent exe 'bd '.join(buffers, ' ')
    endif
  endfunction

  autocmd my_vimrc BufNewFile,BufRead *.tmpl call s:ft_gotmpl()
  function! s:ft_gotmpl() abort
    if search('{{.\+}}', 'nw') || filereadable(findfile('go.mod', ".;"))
      setlocal filetype=gotmpl tabstop=4 shiftwidth=4 noexpandtab
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
    function! s:chezmoi_target_doautocmd(file) abort
      if a:file == ''
        return
      endif
      execute 'doautocmd' 'my_vimrc' 'BufWritePost' a:file
    endfunction
    function! s:chezmoi_target_path(file) abort
      if a:file == ''
        return
      endif
      let cmd = ['chezmoi', 'target-path', '--force', a:file]
      call s:job(cmd, function("s:chezmoi_target_doautocmd"))
    endfunction
    function! s:chezmoi_apply(file) abort
      let cmd = ['chezmoi', 'apply', '--force', '--source-path', a:file]
      call s:job(cmd, {d -> s:chezmoi_target_path(a:file)})
    endfunction
    function! s:chezmoi_autocmd(source_path) abort
      if a:source_path == ''
        return
      endif
      execute 'autocmd' 'my_vimrc' 'BufWritePost' a:source_path .. '/*' 'call s:chezmoi_apply(expand("<afile>:p"))'
    endfunction
    call s:job(['chezmoi', 'source-path'], function("s:chezmoi_autocmd"))
  endif
endfunction

au BufReadPost * ++once call s:lazy_init()
