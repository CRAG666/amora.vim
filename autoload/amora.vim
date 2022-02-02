" =============================================================================
" Filename: autoload/amora.vim
" Author: crag
" License: MIT License
" =============================================================================

function! amora#get_configuration() "{{{
  return {
        \ 'style': get(g:, 'amora_style', 'default'),
        \ 'transparent_background': get(g:, 'amora_transparent_background', 0),
        \ 'disable_italic_comment': get(g:, 'amora_disable_italic_comment', 0),
        \ 'enable_italic': get(g:, 'amora_enable_italic', 0),
        \ 'cursor': get(g:, 'amora_cursor', 'auto'),
        \ 'menu_selection_background': get(g:, 'amora_menu_selection_background', 'blue'),
        \ 'spell_foreground': get(g:, 'amora_spell_foreground', 'none'),
        \ 'show_eob': get(g:, 'amora_show_eob', 1),
        \ 'current_word': get(g:, 'amora_current_word', get(g:, 'amora_transparent_background', 0) == 0 ? 'grey background' : 'bold'),
        \ 'lightline_disable_bold': get(g:, 'amora_lightline_disable_bold', 0),
        \ 'diagnostic_text_highlight': get(g:, 'amora_diagnostic_text_highlight', 0),
        \ 'diagnostic_line_highlight': get(g:, 'amora_diagnostic_line_highlight', 0),
        \ 'diagnostic_virtual_text': get(g:, 'amora_diagnostic_virtual_text', 'grey'),
        \ 'better_performance': get(g:, 'amora_better_performance', 0),
        \ }
endfunction "}}}
function! amora#get_palette(style) "{{{
  if a:style ==# 'default'
    let palette = {
          \ 'black':      ['#121221',   '234'],
          \ 'bg0':        ['#2c2e34',   '235'],
          \ 'bg1':        ['#33353f',   '236'],
          \ 'bg2':        ['#363944',   '236'],
          \ 'bg3':        ['#3b3e48',   '237'],
          \ 'bg4':        ['#414550',   '237'],
          \ 'bg_red':     ['#fb5c8e',   '203'],
          \ 'diff_red':   ['#55393d',   '52'],
          \ 'bg_green':   ['#9fd3b3',   '107'],
          \ 'diff_green': ['#394634',   '22'],
          \ 'bg_blue':    ['#93c5e6',   '110'],
          \ 'diff_blue':  ['#354157',   '17'],
          \ 'diff_yellow':['#4e432f',   '54'],
          \ 'fg':         ['#e2e2e3',   '250'],
          \ 'red':        ['#ed3f7f',   '203'],
          \ 'orange':     ['#f39660',   '215'],
          \ 'yellow':     ['#fff0b8',   '179'],
          \ 'green':      ['#84c49b',   '107'],
          \ 'blue':       ['#aed9f6',   '110'],
          \ 'purple':     ['#a29dff',   '141'],
          \ 'grey':       ['#2f2e51',   '246'],
          \ 'grey_dim':   ['#565393',   '240'],
          \ 'none':       ['NONE',      'NONE']
          \ }
  elseif a:style ==# 'focus'
    let palette = {
          \ 'black':      ['#292929',   '238'],
          \ 'bg0':        ['#212121',   '237'],
          \ 'bg1':        ['#1a1a1a',   '236'],
          \ 'bg2':        ['#141414',   '234'],
          \ 'bg3':        ['#5c5c5c',   '237'],
          \ 'bg4':        ['#634e75',   '237'],
          \ 'bg_red':     ['#fb5c8e',   '203'],
          \ 'diff_red':   ['#55393d',   '52'],
          \ 'bg_green':   ['#a2baa8',   '84'],
          \ 'diff_green': ['#394634',   '22'],
          \ 'bg_blue':    ['#aabae7',   '117'],
          \ 'diff_blue':  ['#354157',   '17'],
          \ 'diff_yellow':['#4e432f',   '54'],
          \ 'fg':         ['#e3e1e4',   '250'],
          \ 'red':        ['#e68ac1',   '203'],
          \ 'orange':     ['#ef9062',   '215'],
          \ 'yellow':     ['#eacac0',   '179'],
          \ 'green':      ['#a2baa8',   '107'],
          \ 'blue':       ['#aabae7',   '110'],
          \ 'purple':     ['#ab9df2',   '176'],
          \ 'grey':       ['#848089',   '246'],
          \ 'grey_dim':   ['#605d68',   '240'],
          \ 'none':       ['NONE',      'NONE']
          \ }
  elseif a:style ==# 'old'
    let palette = {
          \ 'black':      ['#181a1c',   '237'],
          \ 'bg0':        ['#2b2d3a',   '235'],
          \ 'bg1':        ['#333648',   '236'],
          \ 'bg2':        ['#363a4e',   '236'],
          \ 'bg3':        ['#634e75',   '237'],
          \ 'bg4':        ['#3f445b',   '237'],
          \ 'bg_red':     ['#ed3f7f',   '203'],
          \ 'diff_red':   ['#55393d',   '52'],
          \ 'bg_green':   ['#bfd1c3',   '107'],
          \ 'diff_green': ['#394634',   '22'],
          \ 'bg_blue':    ['#c4d1f5',   '110'],
          \ 'diff_blue':  ['#354157',   '17'],
          \ 'diff_yellow':['#4e432f',   '54'],
          \ 'fg':         ['#e1e3e4',   '250'],
          \ 'red':        ['#fb5c8e',   '203'],
          \ 'orange':     ['#f89860',   '215'],
          \ 'yellow':     ['#f0ddd8',   '179'],
          \ 'green':      ['#a2baa8',   '107'],
          \ 'blue':       ['#aabae7',   '110'],
          \ 'purple':     ['#9985d1',   '176'],
          \ 'grey':       ['#7e8294',   '246'],
          \ 'grey_dim':   ['#5a5e7a',   '240'],
          \ 'none':       ['NONE',      'NONE']
          \ }
  elseif a:style ==# 'kiwi'
    let palette = {
          \ 'black':      ['#161627',   '237'],
          \ 'bg0':        ['#354047',   '238'],
          \ 'bg1':        ['#2b333a',   '237'],
          \ 'bg2':        ['#232a2f',   '236'],
          \ 'bg3':        ['#414e58',   '239'],
          \ 'bg4':        ['#6c8391',   '61'],
          \ 'bg_red':     ['#df8b92',   '203'],
          \ 'diff_red':   ['#55393d',   '52'],
          \ 'bg_green':   ['#aabb9c',   '107'],
          \ 'diff_green': ['#394634',   '22'],
          \ 'bg_blue':    ['#9cc2de',   '110'],
          \ 'diff_blue':  ['#354157',   '17'],
          \ 'diff_yellow':['#4e432f',   '54'],
          \ 'fg':         ['#e1e3e4',   '250'],
          \ 'red':        ['#c97e84',   '203'],
          \ 'orange':     ['#f69c5e',   '215'],
          \ 'yellow':     ['#d4bc91',   '179'],
          \ 'green':      ['#89977f',   '107'],
          \ 'blue':       ['#8da5ce',   '110'],
          \ 'purple':     ['#ba9cf3',   '176'],
          \ 'grey':       ['#828a9a',   '246'],
          \ 'grey_dim':   ['#5a6477',   '240'],
          \ 'none':       ['NONE',      'NONE']
          \ }
  elseif a:style ==# 'magic'
    let palette = {
          \ 'black':      ['#1c1e1f',   '237'],
          \ 'bg0':        ['#273136',   '235'],
          \ 'bg1':        ['#313b42',   '236'],
          \ 'bg2':        ['#353f46',   '236'],
          \ 'bg3':        ['#3a444b',   '237'],
          \ 'bg4':        ['#414b53',   '237'],
          \ 'bg_red':     ['#E83F80',   '203'],
          \ 'diff_red':   ['#55393d',   '52'],
          \ 'bg_green':   ['#d9e07b',   '107'],
          \ 'diff_green': ['#394634',   '22'],
          \ 'bg_blue':    ['#B3DFEF',   '110'],
          \ 'diff_blue':  ['#354157',   '17'],
          \ 'diff_yellow':['#4e432f',   '54'],
          \ 'fg':         ['#e1e2e3',   '250'],
          \ 'red':        ['#E83F80',   '203'],
          \ 'orange':     ['#f3a96a',   '215'],
          \ 'yellow':     ['#ffb65e',   '179'],
          \ 'green':      ['#d9e07b',   '107'],
          \ 'blue':       ['#B3DFEF',   '110'],
          \ 'purple':     ['#B982FF',   '176'],
          \ 'grey':       ['#82878b',   '246'],
          \ 'grey_dim':   ['#55626d',   '240'],
          \ 'none':       ['NONE',      'NONE']
          \ }
  elseif a:style ==# 'espresso'
    let palette = {
          \ 'black':      ['#1f1e1c',   '237'],
          \ 'bg0':        ['#312c2b',   '235'],
          \ 'bg1':        ['#393230',   '236'],
          \ 'bg2':        ['#413937',   '236'],
          \ 'bg3':        ['#49403c',   '237'],
          \ 'bg4':        ['#4e433f',   '237'],
          \ 'bg_red':     ['#fd6883',   '203'],
          \ 'diff_red':   ['#55393d',   '52'],
          \ 'bg_green':   ['#adda78',   '107'],
          \ 'diff_green': ['#394634',   '22'],
          \ 'bg_blue':    ['#85dad2',   '110'],
          \ 'diff_blue':  ['#354157',   '17'],
          \ 'diff_yellow':['#4e432f',   '54'],
          \ 'fg':         ['#e4e3e1',   '250'],
          \ 'red':        ['#f86882',   '203'],
          \ 'orange':     ['#f08d71',   '215'],
          \ 'yellow':     ['#f0c66f',   '179'],
          \ 'green':      ['#a6cd77',   '107'],
          \ 'blue':       ['#81d0c9',   '110'],
          \ 'purple':     ['#9fa0e1',   '176'],
          \ 'grey':       ['#90817b',   '246'],
          \ 'grey_dim':   ['#6a5e59',   '240'],
          \ 'none':       ['NONE',      'NONE']
          \ }
  endif
  return palette
endfunction "}}}
function! amora#highlight(group, fg, bg, ...) "{{{
  execute 'highlight' a:group
        \ 'guifg=' . a:fg[0]
        \ 'guibg=' . a:bg[0]
        \ 'ctermfg=' . a:fg[1]
        \ 'ctermbg=' . a:bg[1]
        \ 'gui=' . (a:0 >= 1 ?
          \ a:1 :
          \ 'NONE')
        \ 'cterm=' . (a:0 >= 1 ?
          \ (a:1 ==# 'undercurl' ?
            \ 'underline' :
            \ a:1) :
          \ 'NONE')
        \ 'guisp=' . (a:0 >= 2 ?
          \ a:2[0] :
          \ 'NONE')
endfunction "}}}
function! amora#syn_gen(path, last_modified, msg) "{{{
  " Generate the `after/syntax` directory.
  let full_content = join(readfile(a:path), "\n") " Get the content of `colors/amora.vim`
  let syn_conent = []
  let rootpath = amora#syn_rootpath(a:path) " Get the path to place the `after/syntax` directory.
  call substitute(full_content, '" syn_begin.\{-}syn_end', '\=add(syn_conent, submatch(0))', 'g') " Search for 'syn_begin.\{-}syn_end' (non-greedy) and put all the search results into a list.
  for content in syn_conent
    let syn_list = []
    call substitute(matchstr(matchstr(content, 'syn_begin:.\{-}{{{'), ':.\{-}{{{'), '\(\w\|-\)\+', '\=add(syn_list, submatch(0))', 'g') " Get the file types. }}}}}}
    for syn in syn_list
      call amora#syn_write(rootpath, syn, content) " Write the content.
    endfor
  endfor
  call amora#syn_write(rootpath, 'text', "let g:amora_last_modified = '" . a:last_modified . "'") " Write the last modified time to `after/syntax/text/amora.vim`
  let syntax_relative_path = has('win32') ? '\after\syntax' : '/after/syntax'
  if a:msg ==# 'update'
    echohl WarningMsg | echom '[amora] Updated ' . rootpath . syntax_relative_path | echohl None
    call amora#ftplugin_detect(a:path)
  else
    echohl WarningMsg | echom '[amora] Generated ' . rootpath . syntax_relative_path | echohl None
  endif
endfunction "}}}
function! amora#syn_write(rootpath, syn, content) "{{{
  " Write the content.
  let syn_path = a:rootpath . '/after/syntax/' . a:syn . '/amora.vim' " The path of a syntax file.
  " create a new file if it doesn't exist
  if !filereadable(syn_path)
    call mkdir(a:rootpath . '/after/syntax/' . a:syn, 'p')
    call writefile([
          \ "if !exists('g:colors_name') || g:colors_name !=# 'amora'",
          \ '    finish',
          \ 'endif'
          \ ], syn_path, 'a') " Abort if the current color scheme is not amora.
    call writefile([
          \ "if index(g:amora_loaded_file_types, '" . a:syn . "') ==# -1",
          \ "    call add(g:amora_loaded_file_types, '" . a:syn . "')",
          \ 'else',
          \ '    finish',
          \ 'endif'
          \ ], syn_path, 'a') " Abort if this file type has already been loaded.
  endif
  " If there is something like `call amora#highlight()`, then add
  " code to initialize the palette and configuration.
  if matchstr(a:content, 'amora#highlight') !=# ''
    call writefile([
          \ 'let s:configuration = amora#get_configuration()',
          \ 'let s:palette = amora#get_palette(s:configuration.style)'
          \ ], syn_path, 'a')
  endif
  " Append the content.
  call writefile(split(a:content, "\n"), syn_path, 'a')
  " Add modeline.
  call writefile(['" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:'], syn_path, 'a')
endfunction "}}}
function! amora#syn_rootpath(path) "{{{
  " Get the directory where `after/syntax` is generated.
  if (matchstr(a:path, '^/usr/share') ==# '') " Return the plugin directory. The `after/syntax` directory should never be generated in `/usr/share`, even if you are a root user.
    return fnamemodify(a:path, ':p:h:h')
  else " Use vim home directory.
    if has('nvim')
      return stdpath('config')
    else
      return expand('~') . '/.vim'
    endif
  endif
endfunction "}}}
function! amora#syn_newest(path, last_modified) "{{{
  " Determine whether the current syntax files are up to date by comparing the last modified time in `colors/amora.vim` and `after/syntax/text/amora.vim`.
  let rootpath = amora#syn_rootpath(a:path)
  execute 'source ' . rootpath . '/after/syntax/text/amora.vim'
  return a:last_modified ==# g:amora_last_modified ? 1 : 0
endfunction "}}}
function! amora#syn_clean(path, msg) "{{{
  " Clean the `after/syntax` directory.
  let rootpath = amora#syn_rootpath(a:path)
  " Remove `after/syntax/**/amora.vim`.
  let file_list = split(globpath(rootpath, 'after/syntax/**/amora.vim'), "\n")
  for file in file_list
    call delete(file)
  endfor
  " Remove empty directories.
  let dir_list = split(globpath(rootpath, 'after/syntax/*'), "\n")
  for dir in dir_list
    if globpath(dir, '*') ==# ''
      call delete(dir, 'd')
    endif
  endfor
  if globpath(rootpath . '/after/syntax', '*') ==# ''
    call delete(rootpath . '/after/syntax', 'd')
  endif
  if globpath(rootpath . '/after', '*') ==# ''
    call delete(rootpath . '/after', 'd')
  endif
  if a:msg
    let syntax_relative_path = has('win32') ? '\after\syntax' : '/after/syntax'
    echohl WarningMsg | echom '[amora] Cleaned ' . rootpath . syntax_relative_path | echohl None
  endif
endfunction "}}}
function! amora#syn_exists(path) "{{{
  return filereadable(amora#syn_rootpath(a:path) . '/after/syntax/text/amora.vim')
endfunction "}}}
function! amora#ftplugin_detect(path) "{{{
  " Check if /after/ftplugin exists.
  " This directory is generated in earlier versions, users may need to manually clean it.
  let rootpath = amora#syn_rootpath(a:path)
  if filereadable(amora#syn_rootpath(a:path) . '/after/ftplugin/text/amora.vim')
    let ftplugin_relative_path = has('win32') ? '\after\ftplugin' : '/after/ftplugin'
    echohl WarningMsg | echom '[amora] Detected ' . rootpath . ftplugin_relative_path | echohl None
    echohl WarningMsg | echom '[amora] This directory is no longer used, you may need to manually delete it.' | echohl None
  endif
endfunction "}}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
