if has('vim_starting')
  if isdirectory(expand('~/.vim/bundle/repos/github.com/Shougo/dein.vim'))
    set runtimepath^=~/.vim/bundle/repos/github.com/Shougo/dein.vim
  elseif executable('git')
    call system('git clone https://github.com/Shougo/dein.vim.git')
    if v:shell_error
      finish
    endif
  else
    finish
  endif
endif

if has('autocmd')
  augroup my_vimrc_dein
    autocmd!
  augroup END
  command! -bang -nargs=* AuDein autocmd<bang> my_vimrc_dein <args>
else
  command! -bang -nargs=* AuDein
endif
AuDein VimEnter * call dein#call_hook('post_source')

call dein#begin(expand('~/.vim/bundle'), [expand("%"), expand("~/.vim/local_plugins.vim")])
call dein#add('Shougo/dein.vim')

call dein#add('airblade/vim-gitgutter')
call dein#add('altercation/vim-colors-solarized')
call dein#add('basyura/J6uil.vim', {'lazy': 1})
call dein#add('cohama/agit.vim')
call dein#add('cohama/lexima.vim', {'on_i': 1})
call dein#add('cohama/vim-hier', {'on_source': ['vim-watchdogs']})
call dein#add('dag/vim2hs', {'on_ft': ['haskell']})
call dein#add('daisuzu/translategoogle.vim')
call dein#add('deris/vim-rengbang')
call dein#add('digitaltoad/vim-jade', {'on_ft': ['jade']})
call dein#add('eagletmt/neco-ghc', {'on_ft': ['haskell'], 'if': executable('cabal') && executable('ghc-mod')})
call dein#add('easymotion/vim-easymotion')
call dein#add('elzr/vim-json', {'on_ft': ['json']})
call dein#add('h1mesuke/vim-alignta')
call dein#add('hail2u/vim-css3-syntax', {'on_ft': ['css']})
call dein#add('haya14busa/incsearch-easymotion.vim', {'on_source': ['incsearch.vim']})
call dein#add('haya14busa/incsearch.vim', {'on_map': '<Plug>'})
call dein#add('haya14busa/vim-asterisk', {'on_map': '<Plug>'})
call dein#add('ingydotnet/yaml-vim', {'on_ft': ['yaml']})
call dein#add('itchyny/lightline.vim')
call dein#add('jelera/vim-javascript-syntax', {'on_ft': ['javascript']})
call dein#add('kana/vim-niceblock')
call dein#add('kana/vim-operator-user')
call dein#add('kana/vim-repeat')
call dein#add('kana/vim-smartword', {'on_map': '<Plug>'})
call dein#add('kana/vim-textobj-entire', {'depends': 'vim-textobj-user'})
call dein#add('kana/vim-textobj-line', {'depends': 'vim-textobj-user'})
call dein#add('kana/vim-textobj-user')
call dein#add('kannokanno/previm')
call dein#add('kannokanno/vim-helpnew')
call dein#add('katono/rogue.vim')
call dein#add('KazuakiM/vim-qfsigns', {'on_source': ['vim-watchdogs']})
call dein#add('kchmck/vim-coffee-script', {'on_ft': ['coffee']})
call dein#add('lambdalisue/vim-gista')
call dein#add('lambdalisue/vim-gita')
call dein#add('lambdalisue/vim-unified-diff')
call dein#add('leafgarland/typescript-vim', {'on_ft': ['typescript']})
call dein#add('machakann/vim-sandwich', {'on_map': '<Plug>(operator-sandwich'})
call dein#add('machakann/vim-swap', {'on_map': '<Plug>'})
call dein#add('marijnh/tern_for_vim', {'build': {'others': 'npm install && npm install tern-coffee'}, 'on_ft': ['javascript', 'coffee'], 'if': executable('npm')})
call dein#add('mattn/emmet-vim', {'on_i': 1})
call dein#add('mattn/webapi-vim')
call dein#add('osyo-manga/quickrun-outputter-replace_region')
call dein#add('osyo-manga/shabadou.vim', {'depends': ['vim-quickrun']})
call dein#add('osyo-manga/unite-quickfix')
call dein#add('osyo-manga/unite-quickrun_config', {'depends': ['vim-quickrun']})
call dein#add('osyo-manga/vim-anzu', {'on_map': '<Plug>'})
call dein#add('osyo-manga/vim-brightest')
call dein#add('osyo-manga/vim-hopping')
call dein#add('osyo-manga/vim-marching', {'on_ft': ['cpp']})
call dein#add('osyo-manga/vim-precious', {'depends': ['context_filetype.vim'], 'on_ft': ['vim', 'markdown']})
call dein#add('osyo-manga/vim-snowdrop', {'on_ft': ['c', 'cpp']})
call dein#add('osyo-manga/vim-textobj-multiblock')
call dein#add('osyo-manga/vim-watchdogs', {'depends': ['vim-quickrun', 'shabadou.vim', 'vimproc.vim'], 'if': 0}) " on_ft all?
call dein#add('othree/html5.vim', {'on_ft': ['html']})
call dein#add('othree/javascript-libraries-syntax.vim', {'on_ft': ['javascript', 'coffee', 'typescript']})
call dein#add('othree/tern_for_vim_coffee', {'on_source': ['tern_for_vim'], 'if': executable('npm')})
call dein#add('pangloss/vim-javascript', {'on_source': ['vim-javascript-syntax']})
call dein#add('rust-lang/rust.vim')
call dein#add('Shougo/context_filetype.vim')
call dein#add('Shougo/deoplete.nvim', {'on_i': 1, 'if': has('nvim')})
call dein#add('Shougo/junkfile.vim')
call dein#add('Shougo/neco-syntax', {'on_source': ['neocomplete.vim', 'deoplete.nvim']})
call dein#add('Shougo/neco-vim', {'on_source': ['neocomplete.vim', 'deoplete.nvim']})
call dein#add('Shougo/neocomplete.vim', {'on_i': 1, 'if': !has('nvim') && has('lua')})
call dein#add('Shougo/neoinclude.vim', {'on_source': ['neocomplete.vim', 'deoplete.nvim']})
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/vimfiler.vim', {'depends': ['unite.vim']})
call dein#add('Shougo/vimproc.vim', {'build': {'others': 'make'}})
call dein#add('Shougo/vimshell.vim', {'depends': ['vimproc.vim', 'unite.vim']})
call dein#add('Shougo/vinarise.vim')
call dein#add('t9md/vim-textmanip', {'on_map': '<Plug>'})
call dein#add('thinca/vim-prettyprint')
call dein#add('thinca/vim-qfreplace')
call dein#add('thinca/vim-quickrun')
call dein#add('thinca/vim-ref')
call dein#add('thinca/vim-scouter')
call dein#add('thinca/vim-template')
call dein#add('tonimaru/vim-qfecho', {'on_source': ['vim-watchdogs']})
call dein#add('tpope/vim-fugitive', {'lazy': 0})
call dein#add('tyru/capture.vim')
call dein#add('tyru/caw.vim')
call dein#add('tyru/eskk.vim', {'on_i': 1, 'if': 0})
call dein#add('tyru/open-browser.vim')
call dein#add('tyru/restart.vim', {'if': has('gui_running')})
call dein#add('ujihisa/ref-hoogle', {'on_source': ['vim-ref'], 'if': executable('cabal') && executable('hoogle')})
call dein#add('vim-jp/cpp-vim', {'on_ft': ['cpp']})
call dein#add('vim-jp/vimdoc-ja')
call dein#add('vim-jp/vital.vim')
call dein#add('wavded/vim-stylus')
call dein#add('Yggdroot/indentLine')

function! s:dein_normalized_name(name) abort
  return substitute(a:name, '\W', '_', 'g')
endfunction

function! s:call_if_exists(fname)
  if exists('*s:' . a:fname)
    execute 'call' 's:' . a:fname . '()'
  endif
endfunction

function! s:def_hooks(event, name)
  let norm_name = s:dein_normalized_name(a:name)
  let s:on_{a:event} = norm_name . 'on_' . a:event
  let fmt = 'AuDein User dein#%s#%s call s:call_if_exists("%s")"'
  execute printf(fmt, a:event, a:name, s:on_{a:event})
endfunction

function! s:tap(name) abort
  if dein#tap(a:name)
    call s:def_hooks('source', g:dein#name)
    call s:def_hooks('post_source', g:dein#name)
    return 1
  endif
  return 0
endfunction

nmap [prefix]u [unite]
nnoremap [unite] <Nop>
if s:tap('unite.vim')
  let g:unite_source_grep_max_candidates = 10000

  if executable('hw')
    let g:unite_source_grep_command = 'hw'
    let g:unite_source_grep_default_opts = '-a -e -n --no-color --no-group'
    let g:unite_source_grep_recursive_opt = ''
  elseif executable('pt')
    let g:unite_source_grep_command = 'pt'
    let g:unite_source_grep_default_opts = '--nocolor --nogroup --hidden'
    let g:unite_source_grep_recursive_opt = ''
    let g:unite_source_grep_encoding = 'utf-8'
  elseif executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = ''
    let g:unite_source_grep_default_opts .= ' --vimgrep'
    let g:unite_source_grep_default_opts .= ' --all-types'
    let g:unite_source_grep_default_opts .= ' --hidden'
    let g:unite_source_grep_default_opts .= ' --ignore-case'
    let g:unite_source_grep_default_opts .= ' --ignore ".git"'
    let g:unite_source_grep_default_opts .= ' --ignore ".hg"'
    let g:unite_source_grep_default_opts .= ' --ignore ".svn"'
    let g:unite_source_grep_recursive_opt = ''
  endif

  let g:unite_source_find_max_candidates = 2000

  nnoremap <silent> [unite]bf :<C-u>Unite buffer<CR>
  nnoremap <silent> [unite]bu :<C-u>Unite neobundle/update:all<CR>
  nnoremap <silent> [unite]c :<C-u>Unite quickfix<CR>
  nnoremap <silent> [unite]fm :<C-u>Unite neomru/file<CR>
  nnoremap <silent> [unite]ga :<C-u>Unite grep -create -auto-preview -tab<CR>
  nnoremap <silent> [unite]gr :<C-u>Unite grep -create<CR>
  nnoremap <silent> [unite]l :<C-u>Unite line<CR>
  nnoremap <silent> [unite]j :<C-u>Unite junkfile/new junkfile<CR>
  nnoremap <silent> [unite]q :<C-u>Unite quickrun_config<CR>

  AuDein FileType unite call s:ft_unite()
  function! s:ft_unite()
    map <buffer><nowait> q <Plug>(unite_exit)
    map <buffer><nowait> <C-g> <Plug>(unite_exit)

    map <buffer><nowait> Q <Plug>(unite_all_exit)|
    map <buffer><nowait> g<C-g> <Plug>(unite_all_exit)|
  endfunction

  function! s:{s:on_source}()
    call unite#custom#profile('default', 'context', { 'start_insert': 1, 'direction': 'botright' })
    call unite#custom#profile('source/line', 'context', { 'direction': 'topleft' })
    call unite#custom#profile('source/grep', 'context', { 'no_quit' : 1, 'no_empty': 1 })
    call unite#custom#profile('source/neobundle/update', 'context', { 'start_insert': 0, 'log': 1, ' multi_line': 1, })
  endfunction
endif

nmap [prefix]vf [vimfiler]
nnoremap [vimfiler] <Nop>
if s:tap('vimfiler.vim')
  let g:vimfiler_safe_mode_by_default = 0
  let g:vimfiler_enable_auto_cd       = 1

  nnoremap <silent> [vimfiler]; :<C-u>VimFiler<CR>
  nnoremap <silent> [vimfiler]+ :<C-u>VimFiler -create<CR>
  nnoremap <silent> [vimfiler]p :<C-u>VimFiler -split<CR>
  nnoremap <silent> [vimfiler]P :<C-u>VimFiler -create -split<CR>
  nnoremap <silent> [vimfiler]j :<C-u>VimFilerExplorer<CR>

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

  function! s:{s:on_source}()
    call dein#source('vimshell.vim')
  endfunction
endif

nmap [prefix]vs [vimshell]
nnoremap [vimshell] <Nop>
if s:tap('vimshell.vim')
  nnoremap <silent> [vimshell]; :<C-u>VimShell<CR>
  nnoremap <silent> [vimshell]+ :<C-u>VimShell -create<CR>
endif

map [prefix]g [fugitive]
nnoremap [fugitive] <Nop>
if s:tap('vim-fugitive')
  nnoremap [fugitive]b :<C-u>Gblame<CR>
  nnoremap [fugitive]cd :<C-u>Gcd<CR>
  nnoremap [fugitive]d :<C-u>Gvdiff<CR>
  nnoremap [fugitive]p :<C-u>Gpush origin master
  nnoremap [fugitive]s :<C-u>Gstatus<CR>
  vnoremap [fugitive]b :Gblame<CR>
endif

map [prefix]q [quickrun]
noremap [quickrun] <Nop>
if s:tap('vim-quickrun')
  nmap [quickrun] <Plug>(quickrun)
  function! s:{s:on_post_source}
    silent! execute 'source' expand('~/.vim/quickrun_config.vim')
    silent! execute 'source' expand('~/.vim/local_quickrun_config.vim')
  endfunction
endif

if s:tap('vim-watchdogs')
  let g:watchdogs_check_BufWritePost_enable = 1
  let g:watchdogs_check_BufWritePost_enable_on_wq = 0

  function! s:{s:on_post_source}
    silent! execute 'source' expand('~/.vim/watchdogs_config.vim')
    silent! execute 'source' expand('~/.vim/local_watchdogs_config.vim')
    if has_key(g:, 'quickrun_config')
      call watchdogs#setup(g:quickrun_config)
    endif
  endfunction
endif

map [prefix]res [restart]
noremap [restart] <Nop>
if s:tap('restart.vim')
  noremap <silent> [restart] :<C-u>Restart<CR>
endif

nmap [prefix]ref [ref]
nnoremap [ref] <Nop>
if s:tap('vim-ref')
  let g:ref_open = 'tabnew'
  nnoremap [ref]m :<C-u>Ref man<Space>
  nnoremap [ref]h :<C-u>Ref hoogle<Space>
endif

if s:tap('neocomplete.vim')
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_auto_select = 0

  let g:neocomplete#enable_refresh_always = 1

  let g:neocomplete#force_omni_input_patterns = get(g:, 'neocomplete#force_omni_input_patterns', {})
  let g:neocomplete#force_omni_input_patterns['c'] = '\v\C%(<\h\w*>|]|\)|^)\zs\s*%(\.|-\>)'
  let g:neocomplete#force_omni_input_patterns['cpp'] = '\v%(<\h\w*>|^|[;,()<>])\s*((::|\.|-\>)(<\h\w*>)?)+|^\s*<\h\w*>'

  if executable('npm')
    let g:neocomplete#force_omni_input_patterns['javascript'] = '[^. \t]\.\w*'
    let g:neocomplete#force_omni_input_patterns['coffee'] = '[^. \t]\.\w*'
  endif

  inoremap <expr> <C-L> neocomplete#complete_common_string()
endif

if s:tap('lexima.vim')
  let g:lexima_no_default_rules = 1
  function! s:{s:on_source}()
    call lexima#set_default_rules()
    let n = dein#get('neocomplete.vim')
    if !empty(n) && n['if'] && isdirectory(n['rtp'])
      call lexima#insmode#map_hook('before', '<CR>', "\<C-r>=neocomplete#close_popup()\<CR>")
    endif
  endfunction
endif

if s:tap('vim2hs')
  let g:haskell_conceal = 0
endif

if s:tap('vim-brightest')
  let g:brightest#pattern = '\w\+'
  let g:brightest#highlight = {}
  let g:brightest#highlight['group'] = 'VimrcKeywordHighlightBold'
  let g:brightest#highlight['format'] = '\v\C(^|\W\zs)%s(\ze\W|$)'
  let g:brightest#enable_highlight_all_window = 1
endif

if s:tap('vim-marching')
  let g:marching_clang_command_option = '-std=c++1y'
  let g:marching_enable_neocomplete = 1
  if !executable('clang')
    let g:marching_backend = 'sywnc_wandbox'
  endif
endif

if s:tap('vim-snowdrop')
  " TODO path
  " if !filereadable('libclang.so') && filereadable(expand($HOME.'/local/llvm/lib/libclang.so'))
  "   let g:snowdrop#libclang_directory = expand($HOME.'/local/llvm/lib')
  " endif
endif

if s:tap('rogue.vim')
  let g:rogue#japanese = 1
endif

if s:tap('vim-json')
  let g:vim_json_syntax_conceal = 0
endif

if s:tap('vim-asterisk')
  let g:asterisk#keeppos = 1
endif

if s:tap('vim-anzu')
  let g:anzu_status_format = '%p(%i/%l)'
  let g:anzu_enable_CursorMoved_AnzuUpdateSearchStatus = 1
endif

if s:tap('incsearch.vim')
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)

  nmap [prefix]/ [incsearch_/]
  nmap [prefix]? [incsearch_?]
  nmap [prefix]g/ [incsearch_g/]

  function! s:incsearch_config(...) abort
    return incsearch#util#deepextend(deepcopy({
          \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
          \   'keymap': {
          \     "\<CR>": '<Over>(easymotion)'
          \   },
          \   'is_expr': 0
          \ }), get(a:, 1, {}))
  endfunction

  noremap <silent><expr> [incsearch_/] incsearch#go(<SID>incsearch_config())
  noremap <silent><expr> [incsearch_?] incsearch#go(<SID>incsearch_config({'command': '?'}))
  noremap <silent><expr> [incsearch_g/] incsearch#go(<SID>incsearch_config({'is_stay': 1}))
endif

if s:tap('vim-asterisk') && s:tap('vim-anzu')
  map *   <Plug>(asterisk-z*)<Plug>(anzu-echo-search-status)
  map #   <Plug>(asterisk-z#)<Plug>(anzu-echo-search-status)
  map g*  <Plug>(asterisk-gz*)<Plug>(anzu-echo-search-status)
  map g#  <Plug>(asterisk-gz#)<Plug>(anzu-echo-search-status)
endif

if s:tap('vim-smartword')
  map w  <Plug>(smartword-w)
  map b  <Plug>(smartword-b)
  map e  <Plug>(smartword-e)
  map ge  <Plug>(smartword-ge)
endif

if s:tap('neosnippet.vim')
  let g:neosnippet#disable_runtime_snippets = { '_': 1, }
  let g:neosnippet#snippets_directory = s:vimdir('snippets')

  imap <C-K> <Plug>(neosnippet_expand_or_jump)
  smap <C-K> <Plug>(neosnippet_expand_or_jump)
  imap <C-J> <Plug>(neosnippet_jump_or_expand)
  smap <C-J> <Plug>(neosnippet_jump_or_expand)
endif

if s:tap('vim-textmanip')
  xmap <C-j> <Plug>(textmanip-move-down)
  xmap <C-k> <Plug>(textmanip-move-up)
  xmap <C-h> <Plug>(textmanip-move-left)
  xmap <C-l> <Plug>(textmanip-move-right)
endif

if s:tap('eskk.vim')
  let g:eskk#no_default_mappings = 1
  let g:eskk#enable_completion = 1
  let g:eskk#max_candidates = 100
  let g:eskk#start_completion_length = 2
  let g:eskk#auto_save_dictionary_at_exit = 0

  if executable('google-ime-skk')
    let g:eskk#server = { 'host': 'localhost', 'port': 55100, }

    call system('ps ax | grep google-ime-skk | grep -v grep')
    if v:shell_error
      silent! !google-ime-skk &
    endif
  endif

  imap <C-X>j <Plug>(eskk:toggle)
  imap <C-X><C-J> <Plug>(eskk:toggle)
  cmap <C-X>j <Plug>(eskk:toggle)
  cmap <C-X><C-J> <Plug>(eskk:toggle)
endif

if s:tap('vim-textobj-multiblock')
  omap ab <Plug>(textobj-multiblock-a)
  omap ib <Plug>(textobj-multiblock-i)
endif

if s:tap('vim-sandwich')
  let g:operator_sandwich_no_default_key_mappings = 1

  nmap ys <Plug>(operator-sandwich-add)
  nmap ds <Plug>(operator-sandwich-delete)<Plug>(textobj-sandwich-query-a)
  nmap cs <Plug>(operator-sandwich-replace)<Plug>(textobj-sandwich-query-a)
  nmap dsb <Plug>(operator-sandwich-delete)<Plug>(textobj-sandwich-auto-a)
  nmap csb <Plug>(operator-sandwich-replace)<Plug>(textobj-sandwich-auto-a)
  xmap S <Plug>(operator-sandwich-add)
  xmap D <Plug>(operator-sandwich-delete)<Plug>(textobj-sandwich-query-a)
  xmap C <Plug>(operator-sandwich-replace)<Plug>(textobj-sandwich-query-a)
endif

if s:tap('vim-hopping')
  let g:hopping#keymapping = {
        \   "\<C-n>" : '<Over>(hopping-next)',
        \   "\<C-p>" : '<Over>(hopping-prev)',
        \   "\<C-y>" : '<Over>(scroll-y)',
        \   "\<C-u>" : '<Over>(scroll-u)',
        \   "\<C-f>" : '<Over>(scroll-f)',
        \   "\<C-e>" : '<Over>(scroll-e)',
        \   "\<C-d>" : '<Over>(scroll-d)',
        \   "\<C-b>" : '<Over>(scroll-b)',
        \ }
endif

if s:tap('vim-template')
  AuDein FileType * execute 'TemplateLoad /filetype/' . &l:filetype
endif

if s:tap('deoplete.nvim')
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#enable_refresh_always = 1
endif

if s:tap('vim-qfecho')
  let g:qfecho_enable_at_startup = 1
endif

if s:tap('vim-unified-diff')
  set diffexpr=unified_diff#diffexpr()
endif

if s:tap('J6uil.vim')
  let g:J6uil_display_icon = 1
endif

if s:tap('vim-swap')
  let g:swap_no_default_key_mappings = 1
  nmap g< <Plug>(swap-prev)
  nmap g> <Plug>(swap-next)
  nmap gS <Plug>(swap-interactive)
endif

silent! execute 'source' expand('~/.vim/local_plugins.vim')

call dein#end()

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
