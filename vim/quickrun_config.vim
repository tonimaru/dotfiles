let g:quickrun_config = get(g:, 'quickrun_config', {})

let g:quickrun_config['_'] = {}

if has('nvim')
  let g:quickrun_config['_']['runner'] = 'neovim_job'
elseif exists('*ch_close_in')
  let g:quickrun_config['_']['runner'] = 'job'
  let g:quickrun_config['_']['runner/job/interval'] = 33
endif

let g:quickrun_config['json'] = {'type': executable('jq') ? 'json/jq' : executable('json2yaml') ? 'json/json2yaml' : ''}
let g:quickrun_config['json/jq'] = {'command': 'jq', 'exec': 'cat %s | %c "%o"', 'cmdopt': '.', 'outputter/buffer/filetype': 'json'}
let g:quickrun_config['json/json2yaml'] = {'command': 'json2yaml', 'exec': '%c %s', 'outputter/buffer/filetype': 'yaml'}

let g:quickrun_config['yaml'] = {'type': executable('yaml2json') ? 'yaml/yaml2json' : ''}
let g:quickrun_config['yaml/yaml2json'] = {'command': 'yaml2json', 'exec': '%c %s', 'outputter/buffer/filetype': 'json'}

let g:quickrun_config['scala'] = {'type': executable('scala') ? 'scala/process_manager' : ''}

let g:quickrun_config['go'] = {
\   'hook/output_encode/encoding': 'utf-8',
\   'tempfile': '%{tempname()}.go',
\   'hook/cd/directory': '%S:p:h',
\   'exec': 'GO111MODULE=off %c run %s:p:t %a',
\   'command': 'go',
\ }

let g:quickrun_config['clojure'] = {
\   'command': 'clj',
\   'exec': '%c -M %s %a',
\ }
