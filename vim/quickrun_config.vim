let g:quickrun_config = get(g:, 'quickrun_config', {})

let g:quickrun_config['_'] = {}

if !has('nvim')
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

let  s:conf_base = {}
function! s:conf_base.decorate(config) dict
  return self._decorate(deepcopy(a:config))
endfunction

function! s:new_conf(name, ...)
  let config = extend({'name': a:name}, s:conf_base)
  if a:0 != 0
    call extend(config, a:1)
  endif
  return config
endfunction

function! s:dst(config) dict
  let a:config['cmdopt'] = get(a:config, 'cmdopt', '').' '.self['opt']
  let a:config['exec'] = self['exec']
  return a:config
endfunction

let s:pp      = s:new_conf('pp',      {'_decorate': function('s:dst'), 'opt': '-E',            'exec': '%c %o %s'})
let s:asm     = s:new_conf('asm',     {'_decorate': function('s:dst'), 'opt': '-S',            'exec': '%c %o %s -o -'})
let s:LLVM_IR = s:new_conf('LLVM_IR', {'_decorate': function('s:dst'), 'opt': '-S -emit-llvm', 'exec': '%c %o %s -o -'})

function! s:std(config) dict
  let a:config['cmdopt'] = get(a:config, 'cmdopt', '').' -std='.self['name']
  return a:config
endfunction

let s:c11            = s:new_conf('c11',            {'_decorate': function('s:std')})
let s:c1x            = s:new_conf('c1x',            {'_decorate': function('s:std')})
let s:c89            = s:new_conf('c89',            {'_decorate': function('s:std')})
let s:c90            = s:new_conf('c90',            {'_decorate': function('s:std')})
let s:c99            = s:new_conf('c99',            {'_decorate': function('s:std')})
let s:c9x            = s:new_conf('c9x',            {'_decorate': function('s:std')})
let s:gnu11          = s:new_conf('gnu11',          {'_decorate': function('s:std')})
let s:gnu1x          = s:new_conf('gnu1x',          {'_decorate': function('s:std')})
let s:gnu89          = s:new_conf('gnu89',          {'_decorate': function('s:std')})
let s:gnu90          = s:new_conf('gnu90',          {'_decorate': function('s:std')})
let s:gnu99          = s:new_conf('gnu99',          {'_decorate': function('s:std')})
let s:gnu9x          = s:new_conf('gnu9x',          {'_decorate': function('s:std')})
let s:iso9899_1990   = s:new_conf('iso9899:1990',   {'_decorate': function('s:std')})
let s:iso9899_199409 = s:new_conf('iso9899:199409', {'_decorate': function('s:std')})
let s:iso9899_1999   = s:new_conf('iso9899:1999',   {'_decorate': function('s:std')})
let s:iso9899_199x   = s:new_conf('iso9899:199x',   {'_decorate': function('s:std')})
let s:iso9899_2011   = s:new_conf('iso9899:2011',   {'_decorate': function('s:std')})

let s:cxx03   = s:new_conf('c++03',   {'_decorate': function('s:std')})
let s:cxx0x   = s:new_conf('c++0x',   {'_decorate': function('s:std')})
let s:cxx11   = s:new_conf('c++11',   {'_decorate': function('s:std')})
let s:cxx14   = s:new_conf('c++14',   {'_decorate': function('s:std')})
let s:cxx1y   = s:new_conf('c++1y',   {'_decorate': function('s:std')})
let s:cxx1z   = s:new_conf('c++1z',   {'_decorate': function('s:std')})
let s:cxx98   = s:new_conf('c++98',   {'_decorate': function('s:std')})
let s:gnuxx03 = s:new_conf('gnu++03', {'_decorate': function('s:std')})
let s:gnuxx0x = s:new_conf('gnu++0x', {'_decorate': function('s:std')})
let s:gnuxx11 = s:new_conf('gnu++11', {'_decorate': function('s:std')})
let s:gnuxx14 = s:new_conf('gnu++14', {'_decorate': function('s:std')})
let s:gnuxx1y = s:new_conf('gnu++1y', {'_decorate': function('s:std')})
let s:gnuxx1z = s:new_conf('gnu++1z', {'_decorate': function('s:std')})
let s:gnuxx98 = s:new_conf('gnu++98', {'_decorate': function('s:std')})

function! s:optim(config) dict
  let a:config['cmdopt'] = get(a:config, 'cmdopt', '').' '.self['opt']
  return a:config
endfunction

let s:O0 = s:new_conf('O0', {'_decorate': function('s:optim'), 'opt': '-O0'})
let s:O1 = s:new_conf('O1', {'_decorate': function('s:optim'), 'opt': '-O1'})
let s:O2 = s:new_conf('O2', {'_decorate': function('s:optim'), 'opt': '-O2'})
let s:O3 = s:new_conf('O3', {'_decorate': function('s:optim'), 'opt': '-O3'})
let s:Os = s:new_conf('Os', {'_decorate': function('s:optim'), 'opt': '-Os'})

let s:cdst = [s:pp, s:asm]
let s:cstd = [s:c11, s:c1x, s:c89, s:c90, s:c99, s:c9x, s:gnu11, s:gnu1x, s:gnu89, s:gnu90, s:gnu99, s:gnu9x, s:iso9899_1990, s:iso9899_199409, s:iso9899_1999, s:iso9899_199x, s:iso9899_2011]
let s:coptim = [s:O0, s:O1, s:O2, s:O3, s:Os]

let s:cxxdst = [s:pp, s:asm]
let s:cxxstd = [s:cxx03, s:cxx0x, s:cxx11, s:cxx14, s:cxx1y, s:cxx1z, s:cxx98, s:gnuxx03, s:gnuxx0x, s:gnuxx11, s:gnuxx14, s:gnuxx1y, s:gnuxx1z, s:gnuxx98]
let s:cxxoptim = [s:O0, s:O1, s:O2, s:O3, s:Os]

function! s:_apply(current, arg)
  let config = extend(a:arg.decorate(a:current['config']), {'type': a:current['name']}, 'force')
  let name = printf('%s/%s', a:current['name'], a:arg['name'])
  return {'name': name, 'config': config}
endfunction

function! s:_build_impl(current, args_list)
  let r = []
  let next = copy(a:args_list)
  for args in a:args_list
    let next = next[1:]
    for arg in args
      let v = s:_apply(a:current, arg)
      call add(r, v)
      call extend(r, s:_build_impl(v, next))
    endfor
  endfor
  return r
endfunction

function! s:_set_quickrun_config(root, arg)
  let built = s:_build_impl(a:root, a:arg)
  for v in built
    let g:quickrun_config[v['name']] = v['config']
  endfor
endfunction

function! s:set_quickrun_configs()
  if executable('gcc')
    call s:_set_quickrun_config({'name': 'c/gcc', 'config': {}}, [s:cdst, s:cstd, s:coptim])
  endif
  if executable('g++')
    call s:_set_quickrun_config({'name': 'cpp/g++', 'config': {}}, [s:cxxdst, s:cxxstd, s:cxxoptim])
  endif
  if executable('clang')
    call s:_set_quickrun_config({'name': 'c/clang', 'config': {}}, [add(copy(s:cdst), s:LLVM_IR), s:cstd, s:coptim])
  endif
  if executable('clang++')
    call s:_set_quickrun_config({'name': 'cpp/clang++', 'config': {}}, [add(copy(s:cxxdst), s:LLVM_IR), s:cxxstd, s:cxxoptim])
  endif
endfunction
call s:set_quickrun_configs()
let g:quickrun_config['cpp'] = { 'type': 'cpp/clang++/c++14' }
