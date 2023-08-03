nmap <Space> [prefix]
nnoremap [prefix] <Nop>

nnoremap j gj
nnoremap gj j
nnoremap k gk
nnoremap gk k

nnoremap <silent> <Esc><Esc> :nohlsearch<CR>

nnoremap <silent> [prefix]ee <Cmd>e $MYVIMRC<CR>
nnoremap <silent> [prefix]er <Cmd>so $MYVIMRC<CR>

nnoremap <silent> <C-t> <C-w>n<Cmd>ter<CR>
inoremap <expr> <C-g> pumvisible() ? "\<C-n>" : "\<C-g>"
inoremap <expr> <C-t> pumvisible() ? "\<C-p>" : "\<C-t>"

nnoremap [prefix]id a<C-r>=strftime('%F')<CR>
nnoremap [prefix]iD a<C-r>=strftime('%F %T')<CR>

nnoremap [prefix]iu <Cmd>call <SID>uuid()<CR>
function! s:uuid()
  let uuid = system('uuidgen | tr "[A-Z]" "[a-z]" | tr -d "\n"')
  exe "normal! i" . uuid . "\<Esc>"
  silent! call repeat#set("\<Cmd>UUID\<CR>")
endfunction

nnoremap [prefix]il <Cmd>call <SID>ulid()<CR>
function! s:ulid()
  let ulid = system('ulid | tr -d "\n"')
  exe "normal! i" . ulid . "\<Esc>"
  silent! call repeat#set("\<Cmd>ULID\<CR>")
endfunction

nnoremap [prefix]h <Cmd>call <SID>help()<CR>
function! s:help() abort
  let l:ret = split(execute('nmap'), "\n")
  let l:ret = filter(l:ret, {key, var -> var =~# "^n\\s\\+\\(\\[prefix\\]\\|\\<g\\w\\+\\>\\)"})
  let l:ret = sort(l:ret)
  echo join(l:ret, "\n")
endfunction
