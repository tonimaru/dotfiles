if !executable('git')
  echoerr "git is not executable"
  finish
endif

let s:dpp_base = '~/.cache/dpp'->expand()
let s:repo_base = s:dpp_base . '/repos'

function! s:init_plugin(repo) abort
  const dir = s:repo_base .. '/' .. a:repo
  if !dir->isdirectory()
    silent execute printf('!mkdir -p %s', dir)
    execute '!git clone https://' .. a:repo dir
    if v:shell_error
      echoerr "failed to git clone"
      finish
    endif
  endif

  if has('vim_starting')
    execute 'set runtimepath+=' . dir
  endif
endfunction
call s:init_plugin('github.com/Shougo/dpp.vim')
let s:exts = [
    \ 'github.com/Shougo/dpp-ext-installer',
    \ 'github.com/Shougo/dpp-ext-toml',
    \ 'github.com/Shougo/dpp-ext-lazy',
    \ 'github.com/Shougo/dpp-protocol-git',
    \ ]
for ext in s:exts
    call s:init_plugin(ext)
endfor

function! s:check_install()
  if !dpp#sync_ext_action('installer', 'getNotInstalled')->empty()
    call dpp#async_ext_action('installer', 'install')
  endif
endfunction

let $BASE_DIR = '<sfile>'->expand()->fnamemodify(':h')
let $HOOKS_DIR=$BASE_DIR . "/settings/hooks"
let s:config_path=$BASE_DIR .. '/init.ts'

if s:dpp_base->dpp#min#load_state()
  call s:init_plugin('github.com/vim-denops/denops.vim')
  autocmd my_vimrc User Dpp:makeStatePost call s:check_install()
  call denops#server#wait_async({ -> dpp#make_state(s:dpp_base, s:config_path) })
else
  call denops#server#wait_async({ -> s:check_install() })
endif

execute 'autocmd' 'my_vimrc' 'BufWritePost' $BASE_DIR .. '/**' 'call dpp#make_state(s:dpp_base, s:config_path)'

if exists(':filetype') | filetype indent plugin on | endif
if exists(':syntax') | syntax on | endif

if has("nvim")
  if !empty(globpath(&runtimepath, expand('colors/tokyonight-night.lua')))
    colorscheme tokyonight-night
  endif
endif
