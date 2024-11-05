let s:dein_base = $HOME .'/.cache/dein'
let s:dein_src = s:dein_base . "/repos/github.com/Shougo/dein.vim"

let s:proot = fnamemodify($MYVIMRC, ":p:h") . '/conf/plugins'
let s:tomls = glob(s:proot . "/settings/**/*.toml")->split("\n")

if !isdirectory(s:dein_src)
  if !executable('git')
    finish
  endif

  echo 'Install dein.'
  silent execute printf('!mkdir -p %s', s:dein_src)
  execute '!git clone https://github.com/Shougo/dein.vim.git' s:dein_src
  if v:shell_error
    finish
  endif
endif

if has('vim_starting')
  execute 'set runtimepath+=' . s:dein_src
endif

let $HOOKS_DIR=s:proot . "/settings/hooks"

let g:dein#auto_recache = v:true
if dein#load_state(s:dein_base)
  call dein#begin(s:dein_base, s:tomls)
  call dein#add(s:dein_src, #{merge: v:false})

  for toml in s:tomls
    call dein#load_toml(toml, #{lazy: 1})
  endfor

  if filereadable(s:proot . "/local.vim")
    execute "source" s:proot . "/local.vim"
  endif

  call dein#end()
  call dein#save_state()
endif

if exists(':filetype') | filetype indent plugin on | endif
if exists(':syntax') | syntax on | endif

if !empty(globpath(&runtimepath, expand('colors/tokyonight-night.lua')))
  colorscheme tokyonight-night
endif

if dein#check_install()
  echo 'Install plugins.'
  call dein#install()
endif
