nnoremap j gj
nnoremap gj j
nnoremap k gk
nnoremap gk k

nnoremap <silent> <Esc><Esc> :nohlsearch<CR>

nmap <Space> [prefix]
nnoremap [prefix] <Nop>

nnoremap <silent> [prefix]ee <Cmd>e $MYVIMRC<CR>
nnoremap <silent> [prefix]er <Cmd>so $MYVIMRC<CR>
nnoremap <silent> [prefix]eo <Cmd>execute 'e' fnamemodify($MYVIMRC, ":p:h").'/'.'conf/options.vim'<CR>
nnoremap <silent> [prefix]em <Cmd>execute 'e' fnamemodify($MYVIMRC, ":p:h").'/'.'conf/maps.vim'<CR>
nnoremap <silent> [prefix]ea <Cmd>execute 'e' fnamemodify($MYVIMRC, ":p:h").'/'.'conf/autocmds.vim'<CR>
nnoremap <silent> [prefix]ep <Cmd>execute 'e' fnamemodify($MYVIMRC, ":p:h").'/'.'conf/plugins/init.vim'<CR>

nnoremap <silent> <C-t> <C-w>n<Cmd>ter<CR>
inoremap <expr> <C-g> pumvisible() ? "\<C-n>" : "\<C-g>"
inoremap <expr> <C-t> pumvisible() ? "\<C-p>" : "\<C-t>"

nnoremap [prefix]id a<C-r>=strftime('%F')<CR>
nnoremap [prefix]iD a<C-r>=strftime('%F %T')<CR>
nnoremap [prefix]iu <Cmd>call <SID>uuid()<CR>
nnoremap [prefix]il <Cmd>call <SID>ulid()<CR>

nnoremap [prefix]h <Cmd>call <SID>help()<CR>

function! s:uuid()
  let uuid = system('uuidgen | tr "[A-Z]" "[a-z]" | tr -d "\n"')
  exe "normal! i" . uuid . "\<Esc>"
  silent! call repeat#set("\<Cmd>UUID\<CR>")
endfunction

function! s:ulid()
  let ulid = system('ulid | tr -d "\n"')
  exe "normal! i" . ulid . "\<Esc>"
  silent! call repeat#set("\<Cmd>ULID\<CR>")
endfunction

function! s:help() abort
  let l:ret = split(execute('nmap'), "\n")
  let l:ret = filter(l:ret, {key, var -> var =~# "^n\\s\\+\\(\\[prefix\\]\\|\\<g\\w\\+\\>\\)"})
  let l:ret = sort(l:ret)
  echo join(l:ret, "\n")
endfunction

if has('nvim')
  tnoremap <silent> <ESC> <C-\><C-n>
  tnoremap <silent> <M-Left> <Esc>b
  tnoremap <silent> <M-Right> <Esc>f
endif
