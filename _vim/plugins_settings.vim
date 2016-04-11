if has('autocmd')
  augroup my_vimrc_dein
    autocmd!
  augroup END
  command! -bang -nargs=* AuDein autocmd<bang> my_vimrc_dein <args>
else
  command! -bang -nargs=* AuDein
endif
AuDein VimEnter * call dein#call_hook('post_source')

if dein#tap('unite.vim')
  AuDein FileType unite call s:ft_unite()
  function! s:ft_unite()
    map <buffer><nowait> q <Plug>(unite_exit)
    map <buffer><nowait> <C-g> <Plug>(unite_exit)

    map <buffer><nowait> Q <Plug>(unite_all_exit)|
    map <buffer><nowait> g<C-g> <Plug>(unite_all_exit)|
  endfunction
endif

if dein#tap('vimfiler.vim')
  AuDein FileType vimfiler call s:ft_vimfiler()
  function! s:vimfiler_key_wrap(plug)
    if empty(vimfiler#get_marked_files(b:vimfiler))
      call feedkeys("\<Plug>(vimfiler_toggle_mark_current_line)", 'm')
    endif
    call feedkeys(a:plug, 'm')
  endfunction

  function! s:ft_vimfiler()
    nmap <buffer><expr><nowait> c <SID>vimfiler_key_wrap("\<Plug>(vimfiler_copy_file)")
    nmap <buffer><expr><nowait> m <SID>vimfiler_key_wrap("\<Plug>(vimfiler_move_file)")
    nmap <buffer><expr><nowait> d <SID>vimfiler_key_wrap("\<Plug>(vimfiler_delete_file)")
    nmap <buffer><expr><nowait> r <SID>vimfiler_key_wrap("\<Plug>(vimfiler_rename_file)")

    map <buffer><nowait> q <Plug>(vimfiler_hide)
  endfunction
endif

if dein#tap('vim-asterisk') && dein#tap('vim-anzu')
  map *   <Plug>(asterisk-z*)<Plug>(anzu-echo-search-status)
  map #   <Plug>(asterisk-z#)<Plug>(anzu-echo-search-status)
  map g*  <Plug>(asterisk-gz*)<Plug>(anzu-echo-search-status)
  map g#  <Plug>(asterisk-gz#)<Plug>(anzu-echo-search-status)
endif

if dein#tap('vim-template')
  AuDein FileType * execute 'TemplateLoad /filetype/' . &l:filetype
endif

