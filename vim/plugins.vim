if has('autocmd')
  augroup my_vimrc_plugins
    autocmd!
  augroup END
  command! -bang -nargs=* AuPlug autocmd<bang> my_vimrc_plugins <args>
else
  command! -bang -nargs=* AuPlug
endif
AuPlug VimEnter * call dein#call_hook('post_source')

map [prefix]l [lang]
nnoremap [lang] <Nop>

function! s:lang_cmd(cmd, ...) abort
  silent! write
  let args = substitute(join(a:000), '\s\+$', '', '')
  if has('terminal')
      let cmd = 'terminal'
  elseif has('nvim')
      let cmd = 'noautocmd new | terminal'
  else
      let cmd = '!'
  endif
  execute cmd a:cmd args
endfunction

function! s:miniyank_hook_add()
  if has('nvim')
    map p <Plug>(miniyank-autoput)
    map P <Plug>(miniyank-autoPut)
  endif
endfunction
call dein#add('bfredl/nvim-miniyank', {'hook_add': function('s:miniyank_hook_add')})
call dein#add('buoto/gotests-vim')
call dein#add('cocopon/iceberg.vim')
function! s:easymotion_hook_add()
  let g:EasyMotion_do_mapping = 0
  nmap m <Plug>(easymotion-s)
endfunction
call dein#add('easymotion/vim-easymotion', {'hook_add': function('s:easymotion_hook_add')})
call dein#add('editorconfig/editorconfig-vim')
call dein#add('elzr/vim-json', {'hook_add': { -> execute('let g:vim_json_syntax_conceal = 0') }})
function! s:go_hook_add()
  let g:go_version_warning = 0
  let g:go_code_completion_enabled = 0
  let g:go_def_mapping_enabled = 0
  let g:go_fmt_autosave = 0
  let g:go_imports_autosave = 0
  let g:go_mod_fmt_autosave = 0
  let g:go_metalinter_autosave = 0
  let g:go_textobj_enabled = 0
  let g:go_doc_keywordprg_enabled = 0
  let g:go_gopls_enabled = 0

  let g:go_term_mode = "vsplit"
endfunction
function s:go_root_dir()
  let l:gomod = findfile('go.mod', ".;")
  if filereadable(l:gomod)
    return fnamemodify(l:gomod, ':h')
  endif

  let l:gitroot = system('git rev-parse --show-toplevel')
  if v:shell_error == 0
    return l:gitroot
  endif

  return expand('%:p')
endfunction
function! s:go_keymaps()
  nnoremap <silent><buffer> [lang]q :<C-u>call <SID>lang_cmd('go run', <SID>go_root_dir())<CR>
  nnoremap <silent><buffer> [lang]b :<C-u>call <SID>lang_cmd('go build -v -trimpath -p 4')<CR>
  nnoremap <silent><buffer> [lang]a :<C-u>GoFillStruct<CR>
  nnoremap <silent><buffer> [lang]s :<C-u>GoAlternate!<CR>
  nnoremap <silent><buffer> [lang]t :<C-u>call <SID>lang_cmd('go test ./... -v -parallel 4 -count=1')<CR>
  nnoremap <silent><buffer> [lang]f :<C-u>call <SID>lang_cmd('go test -v -run=' . expand("<cword>")))<CR>
  nnoremap <silent><buffer> [lang]c :<C-u>GoCoverage<CR>
endfunction
AuPlug FileType go call s:go_keymaps()
call dein#add('fatih/vim-go', {'hook_add': function('s:go_hook_add')})
call dein#add('griffinqiu/vim-coloresque')
call dein#add('hail2u/vim-css3-syntax')
function! s:asterisk_hook_add()
  map *  <Plug>(asterisk-z*)
  map #  <Plug>(asterisk-z#)
  map g* <Plug>(asterisk-gz*)
  map g# <Plug>(asterisk-gz#)
endfunction
call dein#add('haya14busa/vim-asterisk', {'on_map': '<Plug>', 'hook_add': function('s:asterisk_hook_add')})
call dein#add('iamcco/markdown-preview.nvim', {'on_ft': ['markdown', 'pandoc.markdown', 'rmd'], 'build': 'cd app & npm install' })
call dein#add('ingydotnet/yaml-vim')
call dein#add('itchyny/lightline.vim')
function! s:vim_lsp_cxx_highlight_hook_add()
  let g:lsp_cxx_hl_use_text_props = 1
endfunction
call dein#add('jackguo380/vim-lsp-cxx-highlight', {'hook_add': function('s:vim_lsp_cxx_highlight_hook_add')})
call dein#add('kana/vim-niceblock')
call dein#add('kana/vim-operator-user')
call dein#add('kana/vim-repeat')
function! s:smartword_hook_add()
  map w  <Plug>(smartword-w)
  map b  <Plug>(smartword-b)
  map e  <Plug>(smartword-e)
  map ge <Plug>(smartword-ge)
endfunction
call dein#add('kana/vim-smartword', {'hook_add': function('s:smartword_hook_add')})
call dein#add('kana/vim-textobj-entire', {'depends': 'vim-textobj-user'})
call dein#add('kana/vim-textobj-line', {'depends': 'vim-textobj-user'})
call dein#add('kana/vim-textobj-user')
function! s:previm_hook_add()
  let g:previm_enable_realtime = 1
  let g:previm_show_header = 0
endfunction
call dein#add('kannokanno/previm', {'hook_add': function('s:previm_hook_add')})
function! s:rogue_hook_add()
  let g:rogue#japanese = 1
endfunction
call dein#add('katono/rogue.vim', {'hook_add': function('s:rogue_hook_add')})
function! s:neodark_hook_add()
  let g:neodark#background = '#181818'
endfunction
call dein#add('KeitaNakamura/neodark.vim', {'hook_add': function('s:neodark_hook_add')})
function! s:dirmark_hook_add()
  nnoremap <silent> [denite]bl :<C-u>Denite -default-action=cd dirmark<CR>
  nnoremap <silent> [denite]ba :<C-u>Denite dirmark/add<CR>
endfunction
call dein#add('kmnk/denite-dirmark', {'depends': 'denite.nvim', 'hook_add': function('s:dirmark_hook_add')})
function! s:gina_hook_add()
  map [prefix]g [gina]
  nnoremap [gina] <Nop>
  nnoremap [gina]b :<C-u>Gina branch<CR>
  nnoremap [gina]l :<C-u>Gina log<CR>
  nnoremap [gina]: :<C-u>Gina blame :<CR>
  nnoremap [gina]d :<C-u>Gina diff<CR>
  nnoremap [gina]s :<C-u>Gina status<CR>
  nnoremap [gina]p :<C-u>Gina pull --rebase<CR>
endfunction
function! s:gina_hook_post_source()
  call gina#custom#mapping#nmap('branch', 'dd', '<Plug>(gina-branch-delete)')
  call gina#custom#mapping#nmap('branch', 'D', ':call gina#action#call("branch:delete:force")')
endfunction
call dein#add('lambdalisue/gina.vim', {'hook_add': function('s:gina_hook_add'), 'hook_post_source': function('s:gina_hook_post_source')})
call dein#add('lambdalisue/vim-gista')
function! s:unified_diff_hook_add()
  set diffexpr=unified_diff#diffexpr()
endfunction
call dein#add('lambdalisue/vim-unified-diff', {'hook_add': function('s:unified_diff_hook_add')})
call dein#add('leafgarland/typescript-vim')
function! s:sandwich_hook_add()
  let g:operator_sandwich_no_default_key_mappings = 1
  nmap ys  <Plug>(operator-sandwich-add)
  nmap ds  <Plug>(operator-sandwich-delete)<Plug>(textobj-sandwich-query-a)
  nmap cs  <Plug>(operator-sandwich-replace)<Plug>(textobj-sandwich-query-a)
  nmap dsb <Plug>(operator-sandwich-delete)<Plug>(textobj-sandwich-auto-a)
  nmap csb <Plug>(operator-sandwich-replace)<Plug>(textobj-sandwich-auto-a)
  xmap S   <Plug>(operator-sandwich-add)
  xmap D   <Plug>(operator-sandwich-delete)<Plug>(textobj-sandwich-query-a)
  xmap C   <Plug>(operator-sandwich-replace)<Plug>(textobj-sandwich-query-a)
endfunction
call dein#add('machakann/vim-sandwich', {'on_map': '<Plug>(operator-sandwich', 'hook_add': function('s:sandwich_hook_add')})
function! s:swap_hook_add()
  let g:swap_no_default_key_mappings = 1
  nmap g< <Plug>(swap-prev)
  nmap g> <Plug>(swap-next)
  nmap gS <Plug>(swap-interactive)
endfunction
call dein#add('machakann/vim-swap', {'on_map': '<Plug>', 'hook_add': function('s:swap_hook_add')})
call dein#add('mattn/emmet-vim', {'on_i': 1})
call dein#add('mhinz/vim-signify')
function! s:lsp_keymaps()
  nnoremap <silent> [lang]r :<C-u>CocRestart<CR>
  nmap <buffer><silent> <C-]> <Plug>(coc-definition)
  nmap <buffer><silent> <C-^> <Plug>(coc-references)
  inoremap <buffer><silent><expr> <C-x><C-o> coc#refresh()

  nmap <buffer><silent> <C-j> <Plug>(coc-diagnostic-next)
  nmap <buffer><silent> <C-k> <Plug>(coc-diagnostic-prev)

	inoremap <buffer><silent><expr> <C-j>
	  \ pumvisible() ? coc#_select_confirm() :
	  \ coc#expandableOrJumpable() ?
	  \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
	  \ <SID>check_back_space() ? "\<C-j>" :
	  \ coc#refresh()

	function! s:check_back_space() abort
	  let col = col('.') - 1
	  return !col || getline('.')[col - 1]  =~# '\s'
	endfunction

  if &filetype == 'vim'
  else
    nmap <buffer><silent> K <Plug>(coc-type-definition)
  endif

  function! s:lsp_fmt() abort
    if &filetype == 'go'
      call CocAction('organizeImport')
    endif
    call CocAction('format')
  endfunction
  nnoremap <buffer><silent> == :call <SID>lsp_fmt()<CR>
endfunction
AuPlug FileType c,cpp,go,json,rust,typescript,vim call s:lsp_keymaps()
AuPlug FileType go nnoremap <buffer><silent> [lang]i :CocCommand go.impl.cursor<CR>
call dein#add('neoclide/coc.nvim', {'merge':0, 'build': 'yarn install --frozen-lockfile'})
call dein#add('octol/vim-cpp-enhanced-highlight')
call dein#add('osyo-manga/unite-quickrun_config', {'depends': ['vim-quickrun']})
function! s:textobj_multiblock_hook_add()
  omap ab <Plug>(textobj-multiblock-a)
  omap ib <Plug>(textobj-multiblock-i)
endfunction
call dein#add('osyo-manga/vim-textobj-multiblock', {'hook_add': function('s:textobj_multiblock_hook_add')})
call dein#add('othree/html5.vim')
call dein#add('othree/javascript-libraries-syntax.vim')
call dein#add('othree/yajs.vim')
call dein#add('posva/vim-vue')
call dein#add('prettier/vim-prettier')
call dein#add('roxma/nvim-yarp')
call dein#add('roxma/vim-hug-neovim-rpc')
function! s:rust_keymaps()
  nnoremap <silent><buffer> [lang]q :<C-u>call <SID>lang_cmd('cargo', 'run')<CR>
  nnoremap <silent><buffer> [lang]b :<C-u>call <SID>lang_cmd('cargo', 'build')<CR>
  nnoremap <silent><buffer> [lang]t :<C-u>call <SID>lang_cmd('cargo', 'test -- --test-threads=4')<CR>
endfunction
AuPlug FileType rust call s:rust_keymaps()
call dein#add('rust-lang/rust.vim')
function! s:defx_hook_add()
  nmap [prefix]f [defx]
  nnoremap [defx] <Nop>
  nnoremap <silent> [defx]; :<C-u>Defx -auto-cd -show-ignored-files -resume<CR>
  nnoremap <silent> [defx]+n :<C-u>Defx -auto-cd -show-ignored-files -new<CR>
  nnoremap <silent> [defx]+v :<C-u>Defx -auto-cd -show-ignored-files -new -split=vertical<CR>
  nnoremap <silent> [defx]+s :<C-u>Defx -auto-cd -show-ignored-files -new -split=horizontal<CR>
  nnoremap <silent> [defx]+t :<C-u>Defx -auto-cd -show-ignored-files -new -split=tab<CR>
  nnoremap <silent> [defx]+f :<C-u>Defx -auto-cd -show-ignored-files -new -split=floating<CR>
endfunction
function! s:defx_config()
  nnoremap <silent><buffer> gr :<C-u>Denite -no-empty grep<CR>
  nnoremap <silent><buffer> ff :call <SID>denite_file_rec(<SID>git_root())<CR>
  nnoremap <silent><buffer> f. :call <SID>denite_file_rec('')<CR>
  nnoremap <nowait><silent><buffer><expr> . defx#do_action('toggle_ignored_files')
  nnoremap <nowait><silent><buffer><expr> S defx#do_action('search')
  nnoremap <nowait><silent><buffer><expr> c defx#do_action('copy')
  nnoremap <nowait><silent><buffer><expr> m defx#do_action('move')
  nnoremap <nowait><silent><buffer><expr> p defx#do_action('paste')
  nnoremap <nowait><silent><buffer><expr> h defx#do_action('cd', ['..'])
  nnoremap <nowait><silent><buffer><expr> j line('.') == line('$') ? 'ggj' : 'j'
  nnoremap <nowait><silent><buffer><expr> k line('.') == 1 ? 'G' : 'k'
  nnoremap <nowait><silent><buffer><expr> l defx#do_action('open')
  nnoremap <nowait><silent><buffer><expr> t defx#do_action('open', 'tabnew')
  nnoremap <nowait><silent><buffer><expr> D defx#do_action('new_directory')
  nnoremap <nowait><silent><buffer><expr> F defx#do_action('new_file')
  nnoremap <nowait><silent><buffer><expr> d defx#do_action('remove')
  nnoremap <nowait><silent><buffer><expr> r defx#do_action('rename')
  nnoremap <nowait><silent><buffer><expr> ~ defx#do_action('cd')
  nnoremap <nowait><silent><buffer><expr> \ defx#do_action('cd', ['/'])
  nnoremap <nowait><silent><buffer><expr> q defx#do_action('quit')
  nnoremap <nowait><silent><buffer><expr> Q defx#do_action('quit')
  nnoremap <nowait><silent><buffer><expr> * defx#do_action('toggle_select_all')
  nnoremap <nowait><silent><buffer><expr> <CR> defx#do_action('open')
  nnoremap <nowait><silent><buffer><expr> <Space> defx#do_action('toggle_select') . 'j'
  nnoremap <nowait><silent><buffer><expr> <C-l> defx#do_action('redraw')
  nnoremap <nowait><silent><buffer><expr> <C-g> defx#do_action('print')
  nnoremap <nowait><silent><buffer><expr> yy defx#do_action('yank_path')
endfunction
AuPlug FileType defx call s:defx_config()
call dein#add('Shougo/defx.nvim', {'hook_add': function('s:defx_hook_add')})
function! s:git_root()
  let l:root_dir=system('git rev-parse --show-toplevel')
  if v:shell_error != 0
    let l:root_dir=system('pwd')
  endif
  return l:root_dir
endfunction
function! s:denite_file_rec(path)
  let cmd='Denite file/rec'
  if !empty(a:path)
    let cmd=cmd.' -path='.a:path
  endif
  execute cmd
endfunction
function! s:denite_hook_add()
  nmap [prefix]d [denite]
  nnoremap [denite] <Nop>
  nnoremap <silent> [denite]bf :<C-u>Denite buffer<CR>
  nmap <silent> [denite]f <Nop>
  nnoremap <silent> [denite]ff :call <SID>denite_file_rec(<SID>git_root())<CR>
  nnoremap <silent> [denite]f. :call <SID>denite_file_rec('')<CR>
  nmap <silent> [denite]g <Nop>
  nnoremap <silent> [denite]ga :<C-u>Denite -no-empty -auto-action=preview -split=tab grep<CR>
  nnoremap <silent> [denite]gr :<C-u>Denite -no-empty grep<CR>
  nnoremap <silent> [denite]l :<C-u>Denite line<CR>
  nnoremap <silent> [denite]r :<C-u>Denite -resume<CR>

  nnoremap <silent> [denite]q :<C-u>Denite quickrun_config<CR>
endfunction
function! s:denite_hook_post_source()
  let l:ignore_globs = ['*~', '*.o', '*.exe', '*.bak', '.DS_Store', '*.sw[po]', '*.class', '*.min.*', 'node_modules', '.hg', '.git', '.bzr', '.svn', 'bin', 'vendor']
  if executable('ag')
    call denite#custom#var('grep', 'command', ['ag'])
    call denite#custom#var('grep', 'default_opts', ['--vimgrep', '--hidden'] + map(deepcopy(l:ignore_globs), { k, v -> '--ignore=' . v }))
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', [])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])

    call denite#custom#var('file/rec', 'command', [
          \   'ag',
          \   '--hidden',
          \   ] + map(deepcopy(l:ignore_globs), { k, v -> '--ignore=' . v }) + [ 
          \   '-g',
          \   '',
          \ ])
  endif
endfunction
function! s:denite_config()
  nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> a denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> I denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> A denite#do_map('open_filter_buffer')

  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> y denite#do_map('do_action', 'yank')
  nnoremap <silent><buffer><expr> c denite#do_map('do_action', 'cd')

  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
  nnoremap <silent><buffer><expr> * denite#do_map('toggle_select_all')
  nnoremap <silent><buffer><expr> q denite#do_map('quit')
endfunc
AuPlug FileType denite call s:denite_config()
call dein#add('Shougo/denite.nvim', {'hook_add': function('s:denite_hook_add'), 'hook_post_source': function('s:denite_hook_post_source')})
function! s:junkfile_hook_add()
  nnoremap <silent> [denite]j :<C-u>Denite junkfile:new junkfile<CR>
endfunction
call dein#add('Shougo/junkfile.vim', {'depends': 'denite.nvim', 'hook_add': function('s:junkfile_hook_add')})
function! s:neomru_hook_add()
  let g:neomru#file_mru_ignore_pattern =
       \'\~$\|\.\%(o\|exe\|dll\|bak\|zwc\|pyc\|sw[po]\)$'.
       \'\|\%(^\|/\)\.\%(hg\|git\|bzr\|svn\)\%($\|/\)'.
       \'\|^\%(\\\\\|/mnt/\|/media/\|/temp/\|/tmp/\|\%(/private\)\=/var/folders/\)'.
       \'\|\%(^\%(fugitive\)://\)'.
       \'\|\%(^\%(gina\)://\)'.
       \'\|\%(^\%(term\)://\)'

  nnoremap <silent> [denite]fm :<C-u>Denite file_mru<CR>
  nnoremap <silent> [denite]dm :<C-u>Denite directory_mru<CR>
endfunction
call dein#add('Shougo/neomru.vim', {'hook_add': function('s:neomru_hook_add')})
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/vinarise.vim')
function! s:textmanip_hook_add()
  xmap <C-j> <Plug>(textmanip-move-down)
  xmap <C-k> <Plug>(textmanip-move-up)
  xmap <C-h> <Plug>(textmanip-move-left)
  xmap <C-l> <Plug>(textmanip-move-right)
endfunction
call dein#add('t9md/vim-textmanip', {'on_map': '<Plug>', 'hook_add': function('s:textmanip_hook_add')})
call dein#add('thinca/vim-prettyprint')
call dein#add('thinca/vim-qfreplace')
function! s:quickrun_hook_add()
  map [prefix]q [quickrun]
  noremap [quickrun] <Nop>
  nmap [quickrun] <Plug>(quickrun)

  if filereadable(expand('~/.vim/quickrun_config.vim'))
    execute 'source' expand('~/.vim/quickrun_config.vim')
  endif
  if filereadable(expand('~/.vim/local_quickrun_config.vim'))
    execute 'source' expand('~/.vim/local_quickrun_config.vim')
  endif
endfunction
call dein#add('thinca/vim-quickrun', {'hook_add': function('s:quickrun_hook_add')})
function! s:ref_hook_add()
  let g:ref_man_cmd='man'
endfunction
call dein#add('thinca/vim-ref', {'hook_add': function('s:ref_hook_add')})
function! s:template_hook_add()
  AuPlug FileType * silent execute 'TemplateLoad /filetype/' . &l:filetype
endfunction
call dein#add('thinca/vim-template', {'hook_add': function('s:template_hook_add')})
call dein#add('tyru/caw.vim')
call dein#add('tyru/open-browser.vim')
call dein#add('tyru/open-browser-github.vim')
call dein#add('vim-jp/vimdoc-ja')
call dein#add('Yggdroot/indentLine')
