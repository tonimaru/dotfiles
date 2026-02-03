" hook_add {{{

function! StartFilerTab()
  call ddu#start(#{
        \   name: 'filer-tab-'..tabpagenr(),
        \   sources: [#{
        \       name: 'file',
        \       options: #{path: t:->get('ddu_ui_filer_path', getcwd())},
        \   }],
        \   ui: 'filer',
        \   resume: v:true,
        \ })
endfunction
nnoremap [prefix]f <Cmd>call StartFilerTab()<CR>

function! StartFilerBuf()
  call ddu#start(#{
        \   name: 'filer-buf-'..bufnr(),
        \   sources: [#{
        \       name: 'file',
        \       options: #{path: getcwd()},
        \   }],
        \   ui: 'filer',
        \ })
endfunction
nnoremap [prefix]F <Cmd>call StartFilerBuf()<CR>

function! ToggleMatcherHidden()
  const matchers = ddu#custom#get_current(b:ddu_ui_name)
        \ ->get('sourceOptions', {})
        \ ->get("file", {})
        \ ->get('matchers', [])
  let next = matchers[:]
  const idx = next->index('matcher_hidden')
  if idx >= 0
    call remove(next, idx)
  else
    call add(next, 'matcher_hidden')
  endif
  return next
endfunction

function! ToggleHidden(name)
  const matchers = ddu#custom#get_current(b:ddu_ui_name)
        \ ->get('sourceOptions', {})
        \ ->get(a:name, {})
        \ ->get('matchers', [])
  let next = matchers[:]
  const idx = next->index('matcher_hidden')
  if idx >= 0
    call remove(next, idx)
  else
    call add(next, 'matcher_hidden')
  endif
  call ddu#ui#multi_actions([
  \   [
  \     'updateOptions', #{
  \       sourceOptions: #{file: #{ matchers: next }},
  \     },
  \   ],
  \   [
  \      'redraw', #{ method: 'refreshItems' },
  \   ],
  \ ])
endfunction

" }}}

" hook_source {{{

autocmd my_vimrc TabEnter,WinEnter,CursorHold,FocusGained ddu-filer-* call ddu#ui#do_action('checkItems')

" }}}

" ddu-filer {{{

nnoremap <buffer> . <Cmd>call ToggleHidden('file')<CR>
nnoremap <buffer> c <Cmd>call ddu#ui#do_action('itemAction', #{name: 'copy'})<CR>
nnoremap <buffer> m <Cmd>call ddu#ui#do_action('itemAction', #{name: 'move'})<CR>
nnoremap <buffer> p <Cmd>call ddu#ui#do_action('itemAction', #{name: 'paste'})<CR>

" Cursor
nnoremap <buffer> j <Cmd>call ddu#ui#do_action('cursorNext', #{loop: v:true})<CR>
nnoremap <buffer> k <Cmd>call ddu#ui#do_action('cursorPrevious', #{loop: v:true})<CR>

" Narrow
function! GetParentPath()
  const name = b:->get('ddu_ui_name', '')
  if name =~# '^filer-tab-'
    const current = t:->get('ddu_ui_filer_path', getcwd())
  elseif name =~# '^filer-buf-'
    const current = b:->get('ddu_ui_filer_path', getcwd())
  else
    const current = getcwd()
  endif
  const path = fnamemodify(current, ':p:h:h')
  return path == '/' ? '//' : path
endfunction
function! Narrow(path = '')
  call ddu#ui#do_action('itemAction', #{name: 'narrow', params: #{ path: a:path }})
  let new_path = ddu#custom#get_current()
        \ ->get('sourceOptions', {})
        \ ->get('file', {})
        \ ->get('path', '')
  if !empty(new_path)
    execute 'lcd' new_path
  endif
endfunction
nnoremap <buffer> h <Cmd>call Narrow(GetParentPath())<CR>
nnoremap <buffer><expr> l
      \ ddu#ui#get_item()->get('isTree', v:false) ?
      \   "<Cmd>call Narrow()<CR>" :
      \   empty(ddu#ui#get_item()->get('status', {})) ?
      \     "" :
      \     "<Cmd>call ddu#ui#do_action('itemAction', #{name: 'open'})<CR>"
nnoremap <buffer><expr> <CR>
      \ ddu#ui#get_item()->get('isTree', v:false) ?
      \   "<Cmd>call Narrow()<CR>" :
      \   empty(ddu#ui#get_item()->get('status', {})) ?
      \     "" :
      \     "<Cmd>call ddu#ui#do_action('itemAction', #{name: 'open'})<CR>"
nnoremap <buffer> ~ <Cmd>call Narrow($HOME)<CR>
nnoremap <buffer> \ <Cmd>call Narrow("//")<CR>

nnoremap <silent><buffer><expr> W
      \ ddu#ui#get_item()->get('action', {})->get('isDirectory', v:false) ?
      \   "" :
      \   "<Cmd>call ddu#ui#do_action('itemAction', #{name: 'open', params: #{ command: 'split' }})<CR>"
nnoremap <silent><buffer><expr> T
      \ ddu#ui#get_item()->get('action', {})->get('isDirectory', v:false) ?
      \   "" :
      \   "<Cmd>call ddu#ui#do_action('itemAction', #{name: 'open', params: #{ command: 'tabnew' }})<CR>"

nnoremap <nowait><silent><buffer> d <Cmd>call ddu#ui#multi_actions([
      \   ['itemAction', #{name: 'trash' }],
      \   ['redraw', #{ method: 'refreshItems' }],
      \ ])<CR>

nnoremap <silent><buffer> D <Cmd>call ddu#ui#do_action('itemAction', #{name: 'newDirectory'})<CR>
nnoremap <silent><buffer> F <Cmd>call ddu#ui#do_action('itemAction', #{name: 'newFile'})<CR>
nnoremap <silent><buffer> r <Cmd>call ddu#ui#do_action('itemAction', #{name: 'rename'})<CR>
nnoremap <silent><buffer> o <Cmd>call ddu#ui#do_action('expandItem', #{mode: 'toggle'})<CR>
nnoremap <silent><buffer> q <Cmd>call ddu#ui#do_action('quit')<CR>
nnoremap <silent><buffer> * <Cmd>call ddu#ui#do_action('toggleAllItems')<CR>
nnoremap <silent><buffer> ; <Cmd>call ddu#ui#do_action('toggleSelectItem')<CR>
nnoremap <silent><buffer> <C-l> <Cmd>call ddu#ui#do_action('redraw')<CR>
nnoremap <silent><buffer> y <Cmd>call ddu#ui#do_action('itemAction', #{name: 'yank'})<CR>
nnoremap <silent><buffer> a <Cmd>call ddu#ui#do_action('chooseAction')<CR>
nnoremap <silent><buffer> i <Cmd>call ddu#ui#do_action('openFilterWindow')<CR>

" }}}
