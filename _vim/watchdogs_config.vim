let g:quickrun_config = get(g:, 'quickrun_config', {})

let g:quickrun_config['watchdogs_checker/_' ] = {}
let g:quickrun_config['watchdogs_checker/_' ]['runner/vimproc/updatetime'] = 40
let g:quickrun_config['watchdogs_checker/_' ]['outputter/quickfix/open_cmd'] = ''

let g:quickrun_config['watchdogs_checker/_' ]['hook/qfsigns_update/enable_exit'] = 1

let g:quickrun_config['c/watchdogs_checker'] = {'type' : executable('clang') ? 'watchdogs_checker/clang' : executable('gcc')   ? 'watchdogs_checker/gcc' : ''}

let g:quickrun_config['watchdogs_checker/ghc-mod'] = {'cmdopt': '-fno-warn-type-defaults'}

" https://github.com/rust-lang/rust.vim/blob/master/syntax_checkers/rust/rustc.vim
let g:quickrun_config['rust/watchdogs_checker'] = {'type': executable('rustc') ? 'watchdogs_checker/rustc' : ''}
let g:quickrun_config['watchdogs_checker/rustc'] = {}
let g:quickrun_config['watchdogs_checker/rustc']['command'] = 'rustc'
let g:quickrun_config['watchdogs_checker/rustc']['exec'] = '%c %o -Zparse-only %s:p'
let g:quickrun_config['watchdogs_checker/rustc']['errorformat'] = '%E%f:%l:%c: %\d%#:%\d%# %.%\{-}error:%.%\{-} %m,%W%f:%l:%c: %\d%#:%\d%# %.%\{-}warning:%.%\{-} %m,%C%f:%l %m,%-Z%.%#'

