let s:dein_base = $HOME .'/.cache/dein'
let s:dein_src = s:dein_base . "/repos/github.com/Shougo/dein.vim"

let s:tomls = [
  \ 'settings/common.toml',
  \ 'settings/color.toml',
  \ 'settings/display.toml',
  \ 'settings/text.toml',
  \ 'settings/edit.toml',
  \ 'settings/move.toml',
  \ 'settings/ddc.toml',
  \ 'settings/ddu.toml',
  \ 'settings/filer.toml',
  \ 'settings/git.toml',
  \ 'settings/lsp.toml',
  \ 'settings/tools.toml',
  \ 'settings/toy.toml',
  \ 'settings/filetypes/bicep.toml',
  \ 'settings/filetypes/clojure.toml',
  \ 'settings/filetypes/go.toml',
  \ 'settings/filetypes/html.toml',
  \ 'settings/filetypes/json.toml',
  \ 'settings/filetypes/markdown.toml',
  \ 'settings/filetypes/rust.toml',
  \ 'settings/filetypes/typescript.toml',
  \ ]

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

let g:dein#auto_recache = v:true
if dein#load_state(s:dein_base)
  call dein#begin(s:dein_base, s:tomls)
  call dein#add(s:dein_src, #{merge: v:false})

  let s:proot = fnamemodify($MYVIMRC, ":p:h") . '/conf/plugins/'

  for toml in s:tomls
    call dein#load_toml(s:proot . toml, #{lazy: 1})
  endfor

  call dein#end()
  call dein#save_state()
endif

if has('filetype') | filetype indent plugin on | endif
if has('syntax') | syntax on | endif

if !empty(globpath(&runtimepath, expand('colors/codedark.vim')))
  colorscheme codedark
endif

if dein#check_install()
  echo 'Install plugins.'
  call dein#install()
endif
