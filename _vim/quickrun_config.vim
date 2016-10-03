let g:quickrun_config = get(g:, 'quickrun_config', {})

let g:quickrun_config['_'] = {}
let g:quickrun_config['_']['runner'] = 'job'

let g:quickrun_config['json'] = {'type': executable('jq') ? 'json/jq' : executable('json2yaml') ? 'json/json2yaml' : ''}
let g:quickrun_config['json/jq'] = {'command': 'jq', 'exec': '%c "%o" %s', 'cmdopt': '.', 'outputter/buffer/filetype': 'json'}
let g:quickrun_config['json/json2yaml'] = {'command': 'json2yaml', 'exec': '%c %s', 'outputter/buffer/filetype': 'yaml'}

let g:quickrun_config['yaml'] = {'type': executable('yaml2json') ? 'yaml/yaml2json' : ''}
let g:quickrun_config['yaml/yaml2json'] = {'command': 'yaml2json', 'exec': '%c %s', 'outputter/buffer/filetype': 'json'}

let g:quickrun_config['scala'] = {'type': executable('scala') ? 'scala/process_manager' : ''}

let  s:conf_base = {}
function! s:conf_base.decorate(config) dict
  return self.decorate_impl(deepcopy(a:config))
endfunction

function! s:new_conf(name, ...)
  let config = extend({'name': a:name}, s:conf_base)
  if a:0 != 0
    let config['decorate_impl'] = a:1
  endif
  return config
endfunction

let s:pp = s:new_conf('pp')
function! s:pp.decorate_impl(config) dict
  let a:config['cmdopt'] = get(a:config, 'cmdopt', '').' -E'
  let a:config['exec'] = '%c %o %s'
  return a:config
endfunction

let s:asm = s:new_conf('asm')
function! s:asm.decorate_impl(config) dict
  let a:config['cmdopt'] = get(a:config, 'cmdopt', '').' -S'
  let a:config['exec'] = ['%c %o %s -o -']
  return a:config
endfunction

function! s:std(config) dict
  let a:config['cmdopt'] = get(a:config, 'cmdopt', '').' -std='.self['name']
  return a:config
endfunction

let s:c11             = s:new_conf('c11', function('s:std'))
let s:c1x             = s:new_conf('c1x', function('s:std'))
let s:c89             = s:new_conf('c89', function('s:std'))
let s:c90             = s:new_conf('c90', function('s:std'))
let s:c99             = s:new_conf('c99', function('s:std'))
let s:c9x             = s:new_conf('c9x', function('s:std'))
let s:gnu11           = s:new_conf('gnu11', function('s:std'))
let s:gnu1x           = s:new_conf('gnu1x', function('s:std'))
let s:gnu89           = s:new_conf('gnu89', function('s:std'))
let s:gnu90           = s:new_conf('gnu90', function('s:std'))
let s:gnu99           = s:new_conf('gnu99', function('s:std'))
let s:gnu9x           = s:new_conf('gnu9x', function('s:std'))
let s:iso9899_1990    = s:new_conf('iso9899:1990', function('s:std'))
let s:iso9899_199409  = s:new_conf('iso9899:199409', function('s:std'))
let s:iso9899_1999    = s:new_conf('iso9899:1999', function('s:std'))
let s:iso9899_199x    = s:new_conf('iso9899:199x', function('s:std'))
let s:iso9899_2011    = s:new_conf('iso9899:2011', function('s:std'))

let s:cxx03    = s:new_conf('c++03', function('s:std'))
let s:cxx0x    = s:new_conf('c++0x', function('s:std'))
let s:cxx11    = s:new_conf('c++11', function('s:std'))
let s:cxx14    = s:new_conf('c++14', function('s:std'))
let s:cxx1y    = s:new_conf('c++1y', function('s:std'))
let s:cxx1z    = s:new_conf('c++1z', function('s:std'))
let s:cxx98    = s:new_conf('c++98', function('s:std'))
let s:gnuxx03  = s:new_conf('gnu++03', function('s:std'))
let s:gnuxx0x  = s:new_conf('gnu++0x', function('s:std'))
let s:gnuxx11  = s:new_conf('gnu++11', function('s:std'))
let s:gnuxx14  = s:new_conf('gnu++14', function('s:std'))
let s:gnuxx1y  = s:new_conf('gnu++1y', function('s:std'))
let s:gnuxx1z  = s:new_conf('gnu++1z', function('s:std'))
let s:gnuxx98  = s:new_conf('gnu++98', function('s:std'))

let s:cdst = [s:pp, s:asm]
let s:cstd = [s:c11, s:c1x, s:c89, s:c90, s:c99, s:c9x, s:gnu11, s:gnu1x, s:gnu89, s:gnu90, s:gnu99, s:gnu9x, s:iso9899_1990, s:iso9899_199409, s:iso9899_1999, s:iso9899_199x, s:iso9899_2011]

let s:cxxdst = [s:pp, s:asm]
let s:cxxstd = [s:cxx03, s:cxx0x, s:cxx11, s:cxx14, s:cxx1y, s:cxx1z, s:cxx98, s:gnuxx03, s:gnuxx0x, s:gnuxx11, s:gnuxx14, s:gnuxx1y, s:gnuxx1z, s:gnuxx98]

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
    call s:_set_quickrun_config({'name': 'c/gcc', 'config': {}}, [s:cdst, s:cstd])
  endif
  if executable('g++')
    call s:_set_quickrun_config({'name': 'cpp/g++', 'config': {}}, [s:cxxdst, s:cxxstd])
  endif
  if executable('clang')
    call s:_set_quickrun_config({'name': 'c/clang', 'config': {}}, [s:cdst, s:cstd])
  endif
  if executable('clang++')
    call s:_set_quickrun_config({'name': 'cpp/clang++', 'config': {}}, [s:cxxdst, s:cxxstd])
  endif
endfunction
call s:set_quickrun_configs()

