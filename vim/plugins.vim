if has('autocmd')
  augroup my_vimrc_plugins
    autocmd!
  augroup END
  command! -bang -nargs=* AuPlug autocmd<bang> my_vimrc_plugins <args>
else
  command! -bang -nargs=* AuPlug
endif
AuPlug VimEnter * call dein#call_hook('post_source')

call dein#add('andymass/vim-matchup')
function! s:miniyank_hook_add()
  nmap p <Plug>(miniyank-autoput)
  nmap P <Plug>(miniyank-autoPut)
  xmap p <Plug>(miniyank-autoput)
  xmap P <Plug>(miniyank-autoPut)
endfunction
call dein#add('bfredl/nvim-miniyank', {'hook_add': function('s:miniyank_hook_add'), 'if': has('nvim'), 'merge': 0})
call dein#add('cocopon/iceberg.vim')
function! s:easymotion_hook_add()
  let g:EasyMotion_do_mapping = 0
  nmap m <Plug>(easymotion-s)
endfunction
call dein#add('easymotion/vim-easymotion', {'hook_add': function('s:easymotion_hook_add')})
call dein#add('editorconfig/editorconfig-vim')
function! s:asterisk_hook_add()
  nmap *  <Plug>(asterisk-z*)
  nmap #  <Plug>(asterisk-z#)
  nmap g* <Plug>(asterisk-gz*)
  nmap g# <Plug>(asterisk-gz#)
  xmap *  <Plug>(asterisk-z*)
  xmap #  <Plug>(asterisk-z#)
  xmap g* <Plug>(asterisk-gz*)
  xmap g# <Plug>(asterisk-gz#)
endfunction
call dein#add('haya14busa/vim-asterisk', {'hook_add': function('s:asterisk_hook_add')})
call dein#add('iamcco/markdown-preview.nvim', {'merge': 0, 'build': 'cd app & yarn install'})
call dein#add('itchyny/lightline.vim')
call dein#add('kana/vim-niceblock')
call dein#add('kana/vim-operator-user')
call dein#add('kana/vim-repeat')
function! s:smartword_hook_add()
  nmap w  <Plug>(smartword-w)
  nmap b  <Plug>(smartword-b)
  nmap e  <Plug>(smartword-e)
  nmap ge <Plug>(smartword-ge)
  xmap w  <Plug>(smartword-w)
  xmap b  <Plug>(smartword-b)
  xmap e  <Plug>(smartword-e)
  xmap ge <Plug>(smartword-ge)
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
  nmap [prefix]g [gina]
  nnoremap [gina] <Nop>
  nnoremap [gina]b :<C-u>Gina branch -a<CR>
  nnoremap [gina]l :<C-u>Gina log<CR>
  nnoremap [gina]: :<C-u>Gina blame :<CR>
  nnoremap [gina]d :<C-u>Gina diff<CR>
  nnoremap [gina]s :<C-u>Gina status<CR>
  nnoremap [gina]p :<C-u>Gina pull --rebase<CR>
endfunction
function! s:gina_hook_post_source()
  call gina#custom#mapping#nmap('branch', 'dd', '<Plug>(gina-branch-delete)')
  call gina#custom#mapping#nmap('branch', 'r', '<Plug>(gina-branch-move)')
  call gina#custom#mapping#nmap('branch', 'n', '<Plug>(gina-branch-new)')
  call gina#custom#mapping#nmap('branch', 'R', '<Plug>(gina-branch-refresh)')
  call gina#custom#mapping#nmap('branch', 'b', '<Plug>(gina-browse)')
  call gina#custom#mapping#nmap('branch', 'yb', '<Plug>(gina-browse-yank)')
  call gina#custom#mapping#nmap('branch', 'D', ':call gina#action#call("branch:delete:force")')
  call gina#custom#mapping#nmap('branch', 'yy', '<Plug>(gina-yank-rev)')
  call gina#custom#mapping#nmap('branch', '<Space><CR>', '<Plug>(gina-show-commit)')

  call gina#custom#mapping#nmap('log', 'yy', '<Plug>(gina-yank-rev)')
  call gina#custom#mapping#nmap('log', 'co', '<Plug>(gina-changes-of)')
  call gina#custom#mapping#nmap('log', 'cp', '<Plug>(gina-changes-of-preview)')

  call gina#custom#mapping#nmap('status', 'yy', '<Plug>(gina-yank-path)')

  call gina#custom#mapping#nmap('changes', 'yy', '<Plug>(gina-yank-path)')
endfunction
call dein#add('lambdalisue/gina.vim', {'hook_add': function('s:gina_hook_add'), 'hook_post_source': function('s:gina_hook_post_source')})
call dein#add('lambdalisue/vim-gista')
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
call dein#add('machakann/vim-sandwich', {'hook_add': function('s:sandwich_hook_add')})
function! s:swap_hook_add()
  let g:swap_no_default_key_mappings = 1
  nmap g< <Plug>(swap-prev)
  nmap g> <Plug>(swap-next)
  nmap gS <Plug>(swap-interactive)
endfunction
call dein#add('machakann/vim-swap', {'hook_add': function('s:swap_hook_add')})
let s:sign_delete_first_line = '-'
call dein#add('mhinz/vim-signify')
function! s:dial_hook_add()
  nmap <C-a> <Plug>(dial-increment)
  nmap <C-x> <Plug>(dial-decrement)
  vmap <C-a> <Plug>(dial-increment)
  vmap <C-x> <Plug>(dial-decrement)
  vmap g<C-a> <Plug>(dial-increment-additional)
  vmap g<C-x> <Plug>(dial-decrement-additional)
endfunction
call dein#add('monaqa/dial.nvim', {'hook_add': function('s:dial_hook_add')})
call dein#add('osyo-manga/unite-quickrun_config', {'depends': ['vim-quickrun']})
function! s:textobj_multiblock_hook_add()
  omap ab <Plug>(textobj-multiblock-a)
  omap ib <Plug>(textobj-multiblock-i)
endfunction
call dein#add('osyo-manga/vim-textobj-multiblock', {'hook_add': function('s:textobj_multiblock_hook_add')})
call dein#add('roxma/vim-hug-neovim-rpc')
function! s:defx_hook_add()
  nmap [prefix]f [defx]
  nnoremap [defx] <Nop>
  nnoremap <silent> [defx]; :<C-u>Defx -auto-cd -show-ignored-files -resume<CR>
  nnoremap <silent> [defx]+ :<C-u>Defx -auto-cd -show-ignored-files -new<CR>
  nnoremap <silent> [defx]v :<C-u>Defx -auto-cd -show-ignored-files -new -split=vertical<CR>
  nnoremap <silent> [defx]h :<C-u>Defx -auto-cd -show-ignored-files -new -split=horizontal<CR>
  nnoremap <silent> [defx]t :<C-u>Defx -auto-cd -show-ignored-files -new -split=tab<CR>
endfunction
function! s:defx_config()
  nnoremap <silent><buffer> gr :<C-u>Denite -no-empty grep<CR>
  nnoremap <silent><buffer> ff :call <SID>denite_file_rec(<SID>lang_root_dir())<CR>
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
  nnoremap <nowait><silent><buffer><expr> - defx#do_action('open_or_close_tree')
  nnoremap <nowait><silent><buffer><expr> q defx#do_action('quit')
  nnoremap <nowait><silent><buffer> Q :<C-u>bp\|bd #<CR>
  nnoremap <nowait><silent><buffer><expr> * defx#do_action('toggle_select_all')
  nnoremap <nowait><silent><buffer><expr> <CR> defx#do_action('open')
  nnoremap <nowait><silent><buffer><expr> <Space> defx#do_action('toggle_select') . 'j'
  nnoremap <nowait><silent><buffer><expr> <C-l> defx#do_action('redraw')
  nnoremap <nowait><silent><buffer><expr> <C-g> defx#do_action('print')
  nnoremap <nowait><silent><buffer><expr> y defx#do_action('yank_path')
endfunction
AuPlug FileType defx call s:defx_config()
call dein#add('Shougo/defx.nvim', {'hook_add': function('s:defx_hook_add')})
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
  nnoremap <silent> [denite]ff :call <SID>denite_file_rec(<SID>lang_root_dir())<CR>
  nnoremap <silent> [denite]f. :call <SID>denite_file_rec('')<CR>
  nmap <silent> [denite]g <Nop>
  nnoremap <silent> [denite]ga :<C-u>Denite -no-empty -auto-action=preview -split=tab grep<CR>
  nnoremap <silent> [denite]gr :<C-u>Denite -no-empty grep<CR>
  nnoremap <silent> [denite]l :<C-u>Denite line<CR>
  nnoremap <silent> [denite]r :<C-u>Denite -resume<CR>

  nnoremap <silent> [denite]q :<C-u>Denite unite:quickrun_config<CR>
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
  nnoremap <silent><buffer><expr> f denite#do_map('do_action', 'quickfix')
  nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> y denite#do_map('do_action', 'yank')
  nnoremap <silent><buffer><expr> c denite#do_map('do_action', 'cd')

  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
  nnoremap <silent><buffer><expr> * denite#do_map('toggle_select_all')
  nnoremap <silent><buffer><expr> q denite#do_map('quit')

  nnoremap <silent><buffer><expr> <TAB> denite#do_map('choose_action')
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
call dein#add('t9md/vim-textmanip', {'hook_add': function('s:textmanip_hook_add')})
call dein#add('thinca/vim-prettyprint')
call dein#add('thinca/vim-qfreplace')
function! s:quickrun_hook_add()
  nmap [prefix]q [quickrun]
  nnoremap [quickrun] <Nop>
  nnoremap [quickrun] :<C-u>QuickRun -input =@<CR>

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

 if exists('g:vscode')
   finish
 endif

" Proggraming Languages

nmap [prefix]l [lang]
nnoremap [lang] <Nop>

function s:lang_root_dir()
  let l:gitroot = system('git rev-parse --show-toplevel')
  if v:shell_error == 0
    return l:gitroot
  endif
  return expand('%:p:h')
endfunction

function! s:lang_cmd(cmd, ...) abort
  silent! write
  let l:args = substitute(join(a:000), '\s\+$', '', '')
  if has('nvim')
      let l:cmd = 'terminal'
  elseif has('terminal')
      let l:cmd = 'terminal ++curwin'
  else
      let l:cmd = '!'
  endif
  noautocmd new
  " echom 'execute' l:cmd 'set' '-x' '&&' a:cmd l:args
  execute l:cmd 'set' '-x' '&&' a:cmd l:args
endfunction

"" LSP

let g:lsp_document_code_action_signs_enabled = 0
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_echo_delay = 128
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_float_delay = 128
let g:lsp_diagnostics_highlights_delay = 128
let g:lsp_diagnostics_highlights_enabled = 1
let g:lsp_diagnostics_highlights_insert_mode_enabled = 0
let g:lsp_diagnostics_signs_delay = 128
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_diagnostics_virtual_text_insert_mode_enabled = 0

let g:lsp_settings = {
      \ 'efm-langserver': {
      \   'disabled': 0,
      \   'allowlist': ['javascript', 'typescript', 'vue', 'markdown', 'json', 'yaml'],
      \   'initialization_options': {
      \     'diagnostics': v:true,
      \     'documentFormatting': v:true,
      \     'codeAction': v:true,
      \   },
      \  },
      \ 'eslint-language-server': {
      \   'allowlist': ['javascript', 'typescript', 'vue'],
      \  },
      \ 'yaml-language-server': {
      \   'workspace_config': {
      \     'yaml': {
      \       'schemas': {
      \         'https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.0/schema.yaml': '/openapi.yaml',
      \       },
      \       'completion': v:true,
      \       'hover': v:true,
      \       'validate': v:true,
      \     },
      \   },
      \  },
      \ }

" let g:lsp_settings_filetype_javascript = ['eslint-language-server', 'typescript-language-server']
let g:lsp_settings_filetype_typescript = ['eslint-language-server', 'typescript-language-server', 'deno']
let g:lsp_settings_filetype_vue = ['eslint-language-server', 'vls']

call dein#add('prabirshrestha/vim-lsp')
call dein#add('mattn/vim-lsp-settings')

function! s:vsnip_hook_add()
  let l:snip_root = g:dein#_runtime_path . '/snippets'
  let g:vsnip_snippet_dirs = [l:snip_root, l:snip_root . '/javascript', l:snip_root . 'vue']
  let g:vsnip_filetypes = {
    \   'typescript': ['javascript', 'typescript'],
    \ }

  imap <expr> <C-j> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'
  smap <expr> <C-j> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'
  imap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
  smap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
  imap <expr> <Tab> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<Tab>'
  smap <expr> <Tab> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<Tab>'

  imap <expr> <C-h> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-h>'
  smap <expr> <C-h> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-h>'
  imap <expr> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
  smap <expr> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
endfunction
call dein#add('rafamadriz/friendly-snippets')
call dein#add('sdras/vue-vscode-snippets')
call dein#add('hrsh7th/vim-vsnip', {'hook_add': function('s:vsnip_hook_add')})
call dein#add('hrsh7th/vim-vsnip-integ')

call dein#add('prabirshrestha/asyncomplete.vim')
call dein#add('prabirshrestha/asyncomplete-lsp.vim')

function! s:formatoption()
  let l:types = {
        \ 'javascript': 'efm-langserver',
        \ 'typescript': 'efm-langserver',
        \ }
  let l:mode = mode()
  let l:opt = { 'bufnr': bufnr('%'), 'sync': l:mode =~# '[vV]' || l:mode ==# "\<C-V>" }
  if has_key(l:types, &filetype)
    let l:opt['server'] = l:types[&filetype]
  endif
  return l:opt
endfunction

function! s:on_lsp_buffer_enabled()
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes

  nnoremap <buffer><silent> [lang]a :LspCodeActionSync<CR>

  nmap <buffer><silent> <C-]> <Plug>(lsp-definition)
  nmap <buffer><silent> <C-^> <Plug>(lsp-references)
  nnoremap <buffer><silent> == :silent! w <BAR> call lsp#internal#document_formatting#format(<SID>formatoption())<CR>
  xnoremap <buffer><silent> = :call lsp#internal#document_formatting#format(<SID>formatoption())<CR>

  nmap <buffer><silent> <C-h> <Plug>(lsp-hover)

  nmap <buffer><silent> <C-j> <Plug>(lsp-next-diagnostic)
  nmap <buffer><silent> <C-k> <Plug>(lsp-previous-diagnostic)

  if expand('%:p:h') =~ '.*\/node_modules\/.*'
    call lsp#disable_diagnostics_for_buffer()
  endif
endfunction
AuPlug User lsp_buffer_enabled call s:on_lsp_buffer_enabled()

"" Golang

call dein#add('buoto/gotests-vim')

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
  return s:lang_root_dir()
endfunction
function! s:go_current_func_name()
  let orig_view = winsaveview()
  try
    let l:pattern = '\C'.'^\s*'.'func\>'.'\s\+'.'\((\w\+\s\+[^)]\+)\s\+\)\='.'\('.'[^(]\+'.'\)'.'\%('.'\s*'.'('.'\=\)'
    if search(l:pattern, 'bW') == 0
        return expand("<cword>")
    endif

    let m = matchlist(getline('.'), l:pattern)
    if empty(m)
      return NONE
    endif

    return m[2]
  finally
    call winrestview(orig_view)
  endtry
endfunction
call dein#add('fatih/vim-go', {'hook_add': function('s:go_hook_add')})
function! s:go_keymaps()
  nnoremap <silent><buffer> [lang]q :<C-u>call <SID>lang_cmd('go run', <SID>go_root_dir())<CR>
  nnoremap <silent><buffer> [lang]b :<C-u>call <SID>lang_cmd('go build -v -trimpath -p 4')<CR>
  nnoremap <silent><buffer> [lang]s :<C-u>GoAlternate!<CR>
  nnoremap <silent><buffer> [lang]t :<C-u>call <SID>lang_cmd('go test ./... -v -parallel 4 -count=1')<CR>
  nnoremap <silent><buffer> [lang]f :<C-u>call <SID>lang_cmd('go test -v -run=' . <SID>go_current_func_name())<CR>
  nnoremap <silent><buffer> [lang]c :<C-u>GoCoverageToggle<CR>
endfunction
AuPlug FileType go call s:go_keymaps()

"" TypeScript

call dein#add('HerringtonDarkholme/yats.vim')
function! s:typescript_run()
  let l:nm = finddir('node_modules', ".;")
  if executable('deno') && !isdirectory(l:nm)
    call s:lang_cmd('deno', 'run', expand('%:p'))
    return
  endif
  if executable('ts-node')
    call s:lang_cmd('ts-node', expand('%:p'))
    return
  endif
endfunction
function! s:typescript_keymaps()
  nnoremap <silent><buffer> [lang]q :<C-u>call <SID>typescript_run()<CR>
  nnoremap <silent><buffer> [lang]t :<C-u>call <SID>lang_cmd('npm test', '--', '--silent=false', '--verbose', 'false', expand('%:p'))<CR>
endfunction
AuPlug FileType typescript call s:typescript_keymaps()

"" Rust

function! s:rust_run()
  let l:cargo = findfile('Cargo.toml', ".;")
  echom l:cargo
  if filereadable(l:cargo)
    call s:lang_cmd('cargo', 'run')
    return
  endif
  echom "single file"
  call s:lang_cmd('rustc', expand('%:p'), '&&', expand('%:p:r'), '&&', 'rm', expand('%:p:r'))
endfunction
function! s:rust_keymaps()
  nnoremap <silent><buffer> [lang]q :<C-u>call <SID>rust_run()<CR>
  nnoremap <silent><buffer> [lang]b :<C-u>call <SID>lang_cmd('cargo', 'build')<CR>
  nnoremap <silent><buffer> [lang]t :<C-u>call <SID>lang_cmd('cargo', 'test -- --test-threads=4')<CR>
endfunction
AuPlug FileType rust call s:rust_keymaps()
call dein#add('rust-lang/rust.vim')

"" HTML, Template Engine

call dein#add('othree/html5.vim')
call dein#add('digitaltoad/vim-pug')
call dein#add('mattn/emmet-vim')

"" Vue

function! s:vue_hook_add()
  let g:vim_vue_plugin_use_pug = 0
  let g:vim_vue_plugin_use_typescript = 1
  let g:vim_vue_plugin_use_sass = 1
  let g:vim_vue_plugin_highlight_vue_attr = 1
endfunction
call dein#add('leafOfTree/vim-vue-plugin', {'hook_add': function('s:vue_hook_add')})

"" C, C++, Obj-C

function! s:vim_lsp_cxx_highlight_hook_add()
  let g:lsp_cxx_hl_use_text_props = 1
endfunction
call dein#add('jackguo380/vim-lsp-cxx-highlight', {'hook_add': function('s:vim_lsp_cxx_highlight_hook_add')})
call dein#add('octol/vim-cpp-enhanced-highlight')

"" Diff

function! s:unified_diff_hook_add()
  set diffexpr=unified_diff#diffexpr()
endfunction
call dein#add('lambdalisue/vim-unified-diff', {'hook_add': function('s:unified_diff_hook_add')})

"" Web

call dein#add('neoclide/jsonc.vim')
call dein#add('elzr/vim-json', {'hook_add': { -> execute('let g:vim_json_syntax_conceal = 0') }})
call dein#add('hail2u/vim-css3-syntax')
call dein#add('ingydotnet/yaml-vim')
call dein#add('othree/javascript-libraries-syntax.vim')
call dein#add('roxma/nvim-yarp')
