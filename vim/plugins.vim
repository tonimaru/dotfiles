Au VimEnter * call dein#call_hook('post_source')

let s:base_dir = fnamemodify(expand('<sfile>'), ':h') . '/plugin_settings/'
call dein#load_toml(s:base_dir . 'common.toml')
call dein#load_toml(s:base_dir . 'display.toml')
call dein#load_toml(s:base_dir . 'edit.toml')
call dein#load_toml(s:base_dir . 'move.toml')
call dein#load_toml(s:base_dir . 'tools.toml')
call dein#load_toml(s:base_dir . 'chore.toml')

if exists('g:vscode')
  finish
elseif has('nvim')
  call dein#load_toml(s:base_dir . 'nvim.toml', {'merged': v:false})
else
  call dein#load_toml(s:base_dir . 'vim.toml', {'merged': v:false})
endif

call dein#load_toml(s:base_dir . 'filetypes/clojure.toml')
call dein#load_toml(s:base_dir . 'filetypes/go.toml')
call dein#load_toml(s:base_dir . 'filetypes/html.toml')
call dein#load_toml(s:base_dir . 'filetypes/json.toml')
call dein#load_toml(s:base_dir . 'filetypes/markdown.toml')
call dein#load_toml(s:base_dir . 'filetypes/rust.toml')
call dein#load_toml(s:base_dir . 'filetypes/typescript.toml')

call dein#load_toml(s:base_dir . 'complete.toml')
call dein#load_toml(s:base_dir . 'ff.toml')
