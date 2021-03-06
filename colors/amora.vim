" -----------------------------------------------------------------------------
" Name:         Amora
" Description:  High Contrast & Vivid Color Scheme based on Monokai Pro
" Author:       Sainnhepark <sainnhe@gmail.com>
" Website:      https://github.com/sainnhe/amora/
" License:      MIT
" -----------------------------------------------------------------------------

" Initialization: {{{
let s:configuration = amora#get_configuration()
let s:palette = amora#get_palette(s:configuration.style)
let s:path = expand('<sfile>:p') " the path of this script
let s:last_modified = 'Mon Jan 24 04:20:24 UTC 2022'
let g:amora_loaded_file_types = []

if !(exists('g:colors_name') && g:colors_name ==# 'amora' && s:configuration.better_performance)
  highlight clear
  if exists('syntax_on')
    syntax reset
  endif
endif

let g:colors_name = 'amora'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif
" }}}
" Common Highlight Groups: {{{
" UI: {{{
if s:configuration.transparent_background
  call amora#highlight('Normal', s:palette.fg, s:palette.none)
  call amora#highlight('Terminal', s:palette.fg, s:palette.none)
  if s:configuration.show_eob
    call amora#highlight('EndOfBuffer', s:palette.bg4, s:palette.none)
  else
    call amora#highlight('EndOfBuffer', s:palette.bg0, s:palette.none)
  endif
  call amora#highlight('Folded', s:palette.grey, s:palette.none)
  call amora#highlight('ToolbarLine', s:palette.fg, s:palette.none)
  call amora#highlight('FoldColumn', s:palette.grey_dim, s:palette.none)
else
  call amora#highlight('Normal', s:palette.fg, s:palette.bg0)
  call amora#highlight('Terminal', s:palette.fg, s:palette.bg0)
  if s:configuration.show_eob
    call amora#highlight('EndOfBuffer', s:palette.bg4, s:palette.bg0)
  else
    call amora#highlight('EndOfBuffer', s:palette.bg0, s:palette.bg0)
  endif
  call amora#highlight('Folded', s:palette.grey, s:palette.bg1)
  call amora#highlight('ToolbarLine', s:palette.fg, s:palette.bg2)
  call amora#highlight('FoldColumn', s:palette.grey_dim, s:palette.none)
endif
call amora#highlight('SignColumn', s:palette.fg, s:palette.none)
call amora#highlight('IncSearch', s:palette.bg0, s:palette.bg_red)
call amora#highlight('Search', s:palette.bg0, s:palette.bg_green)
call amora#highlight('ColorColumn', s:palette.none, s:palette.bg1)
call amora#highlight('Conceal', s:palette.grey_dim, s:palette.none)
if s:configuration.cursor ==# 'auto'
  call amora#highlight('Cursor', s:palette.none, s:palette.none, 'reverse')
else
  call amora#highlight('Cursor', s:palette.bg0, s:palette[s:configuration.cursor])
endif
highlight! link vCursor Cursor
highlight! link iCursor Cursor
highlight! link lCursor Cursor
highlight! link CursorIM Cursor
if &diff
  call amora#highlight('CursorLine', s:palette.none, s:palette.none, 'underline')
  call amora#highlight('CursorColumn', s:palette.none, s:palette.none, 'bold')
else
  call amora#highlight('CursorLine', s:palette.none, s:palette.bg1)
  call amora#highlight('CursorColumn', s:palette.none, s:palette.bg1)
endif
call amora#highlight('LineNr', s:palette.grey_dim, s:palette.none)
if &diff
  call amora#highlight('CursorLineNr', s:palette.fg, s:palette.none, 'underline')
else
  call amora#highlight('CursorLineNr', s:palette.fg, s:palette.none)
endif
call amora#highlight('DiffAdd', s:palette.none, s:palette.diff_green)
call amora#highlight('DiffChange', s:palette.none, s:palette.diff_blue)
call amora#highlight('DiffDelete', s:palette.none, s:palette.diff_red)
call amora#highlight('DiffText', s:palette.bg0, s:palette.blue)
call amora#highlight('Directory', s:palette.green, s:palette.none)
call amora#highlight('ErrorMsg', s:palette.red, s:palette.none, 'bold,underline')
call amora#highlight('WarningMsg', s:palette.yellow, s:palette.none, 'bold')
call amora#highlight('ModeMsg', s:palette.fg, s:palette.none, 'bold')
call amora#highlight('MoreMsg', s:palette.blue, s:palette.none, 'bold')
call amora#highlight('MatchParen', s:palette.none, s:palette.bg4)
call amora#highlight('NonText', s:palette.bg4, s:palette.none)
call amora#highlight('Whitespace', s:palette.bg4, s:palette.none)
call amora#highlight('SpecialKey', s:palette.bg4, s:palette.none)
call amora#highlight('Pmenu', s:palette.fg, s:palette.bg2)
call amora#highlight('PmenuSbar', s:palette.none, s:palette.bg2)
if s:configuration.menu_selection_background ==# 'blue'
  call amora#highlight('PmenuSel', s:palette.bg0, s:palette.bg_blue)
elseif s:configuration.menu_selection_background ==# 'green'
  call amora#highlight('PmenuSel', s:palette.bg0, s:palette.bg_green)
elseif s:configuration.menu_selection_background ==# 'red'
  call amora#highlight('PmenuSel', s:palette.bg0, s:palette.bg_red)
endif
highlight! link WildMenu PmenuSel
call amora#highlight('PmenuThumb', s:palette.none, s:palette.grey)
call amora#highlight('NormalFloat', s:palette.fg, s:palette.bg2)
call amora#highlight('Question', s:palette.yellow, s:palette.none)
if s:configuration.spell_foreground ==# 'none'
  call amora#highlight('SpellBad', s:palette.none, s:palette.none, 'undercurl', s:palette.red)
  call amora#highlight('SpellCap', s:palette.none, s:palette.none, 'undercurl', s:palette.yellow)
  call amora#highlight('SpellLocal', s:palette.none, s:palette.none, 'undercurl', s:palette.blue)
  call amora#highlight('SpellRare', s:palette.none, s:palette.none, 'undercurl', s:palette.purple)
else
  call amora#highlight('SpellBad', s:palette.red, s:palette.none, 'undercurl', s:palette.red)
  call amora#highlight('SpellCap', s:palette.yellow, s:palette.none, 'undercurl', s:palette.yellow)
  call amora#highlight('SpellLocal', s:palette.blue, s:palette.none, 'undercurl', s:palette.blue)
  call amora#highlight('SpellRare', s:palette.purple, s:palette.none, 'undercurl', s:palette.purple)
endif
call amora#highlight('StatusLine', s:palette.fg, s:palette.bg3)
call amora#highlight('StatusLineTerm', s:palette.fg, s:palette.bg3)
call amora#highlight('StatusLineNC', s:palette.grey, s:palette.bg1)
call amora#highlight('StatusLineTermNC', s:palette.grey, s:palette.bg1)
call amora#highlight('TabLine', s:palette.fg, s:palette.bg4)
call amora#highlight('TabLineFill', s:palette.grey, s:palette.bg1)
call amora#highlight('TabLineSel', s:palette.bg0, s:palette.bg_red)
call amora#highlight('VertSplit', s:palette.black, s:palette.none)
call amora#highlight('Visual', s:palette.none, s:palette.bg3)
call amora#highlight('VisualNOS', s:palette.none, s:palette.bg3, 'underline')
call amora#highlight('QuickFixLine', s:palette.blue, s:palette.none, 'bold')
call amora#highlight('Debug', s:palette.yellow, s:palette.none)
call amora#highlight('debugPC', s:palette.bg0, s:palette.green)
call amora#highlight('debugBreakpoint', s:palette.bg0, s:palette.red)
call amora#highlight('ToolbarButton', s:palette.bg0, s:palette.bg_blue)
if has('nvim')
  call amora#highlight('Substitute', s:palette.bg0, s:palette.yellow)
  highlight! link DiagnosticFloatingError ErrorFloat
  highlight! link DiagnosticFloatingWarn WarningFloat
  highlight! link DiagnosticFloatingInfo InfoFloat
  highlight! link DiagnosticFloatingHint HintFloat
  highlight! link DiagnosticError ErrorText
  highlight! link DiagnosticWarn WarningText
  highlight! link DiagnosticInfo InfoText
  highlight! link DiagnosticHint HintText
  highlight! link DiagnosticVirtualTextError VirtualTextError
  highlight! link DiagnosticVirtualTextWarn VirtualTextWarning
  highlight! link DiagnosticVirtualTextInfo VirtualTextInfo
  highlight! link DiagnosticVirtualTextHint VirtualTextHint
  highlight! link DiagnosticUnderlineError ErrorText
  highlight! link DiagnosticUnderlineWarn WarningText
  highlight! link DiagnosticUnderlineInfo InfoText
  highlight! link DiagnosticUnderlineHint HintText
  highlight! link DiagnosticSignError RedSign
  highlight! link DiagnosticSignWarn YellowSign
  highlight! link DiagnosticSignInfo BlueSign
  highlight! link DiagnosticSignHint GreenSign
  highlight! link LspDiagnosticsFloatingError ErrorFloat
  highlight! link LspDiagnosticsFloatingWarning WarningFloat
  highlight! link LspDiagnosticsFloatingInformation InfoFloat
  highlight! link LspDiagnosticsFloatingHint HintFloat
  highlight! link LspDiagnosticsDefaultError ErrorText
  highlight! link LspDiagnosticsDefaultWarning WarningText
  highlight! link LspDiagnosticsDefaultInformation InfoText
  highlight! link LspDiagnosticsDefaultHint HintText
  highlight! link LspDiagnosticsVirtualTextError VirtualTextError
  highlight! link LspDiagnosticsVirtualTextWarning VirtualTextWarning
  highlight! link LspDiagnosticsVirtualTextInformation VirtualTextInfo
  highlight! link LspDiagnosticsVirtualTextHint VirtualTextHint
  highlight! link LspDiagnosticsUnderlineError ErrorText
  highlight! link LspDiagnosticsUnderlineWarning WarningText
  highlight! link LspDiagnosticsUnderlineInformation InfoText
  highlight! link LspDiagnosticsUnderlineHint HintText
  highlight! link LspDiagnosticsSignError RedSign
  highlight! link LspDiagnosticsSignWarning YellowSign
  highlight! link LspDiagnosticsSignInformation BlueSign
  highlight! link LspDiagnosticsSignHint GreenSign
  highlight! link LspReferenceText CurrentWord
  highlight! link LspReferenceRead CurrentWord
  highlight! link LspReferenceWrite CurrentWord
  highlight! link TermCursor Cursor
  highlight! link healthError Red
  highlight! link healthSuccess Green
  highlight! link healthWarning Yellow
endif
" }}}
" Syntax: {{{
if s:configuration.enable_italic
  call amora#highlight('Type', s:palette.blue, s:palette.none, 'italic')
  call amora#highlight('Structure', s:palette.blue, s:palette.none, 'italic')
  call amora#highlight('StorageClass', s:palette.blue, s:palette.none, 'italic')
  call amora#highlight('Identifier', s:palette.orange, s:palette.none, 'italic')
  call amora#highlight('Constant', s:palette.orange, s:palette.none, 'italic')
else
  call amora#highlight('Type', s:palette.blue, s:palette.none)
  call amora#highlight('Structure', s:palette.blue, s:palette.none)
  call amora#highlight('StorageClass', s:palette.blue, s:palette.none)
  call amora#highlight('Identifier', s:palette.orange, s:palette.none)
  call amora#highlight('Constant', s:palette.orange, s:palette.none)
endif
call amora#highlight('PreProc', s:palette.red, s:palette.none)
call amora#highlight('PreCondit', s:palette.red, s:palette.none)
call amora#highlight('Include', s:palette.red, s:palette.none)
call amora#highlight('Keyword', s:palette.red, s:palette.none)
call amora#highlight('Define', s:palette.red, s:palette.none)
call amora#highlight('Typedef', s:palette.red, s:palette.none)
call amora#highlight('Exception', s:palette.red, s:palette.none)
call amora#highlight('Conditional', s:palette.red, s:palette.none)
call amora#highlight('Repeat', s:palette.red, s:palette.none)
call amora#highlight('Statement', s:palette.red, s:palette.none)
call amora#highlight('Macro', s:palette.purple, s:palette.none)
call amora#highlight('Error', s:palette.red, s:palette.none)
call amora#highlight('Label', s:palette.purple, s:palette.none)
call amora#highlight('Special', s:palette.purple, s:palette.none)
call amora#highlight('SpecialChar', s:palette.purple, s:palette.none)
call amora#highlight('Boolean', s:palette.purple, s:palette.none)
call amora#highlight('String', s:palette.yellow, s:palette.none)
call amora#highlight('Character', s:palette.yellow, s:palette.none)
call amora#highlight('Number', s:palette.purple, s:palette.none)
call amora#highlight('Float', s:palette.purple, s:palette.none)
call amora#highlight('Function', s:palette.red, s:palette.none)
call amora#highlight('Operator', s:palette.green, s:palette.none)
call amora#highlight('Title', s:palette.red, s:palette.none, 'bold')
call amora#highlight('Tag', s:palette.orange, s:palette.none)
call amora#highlight('Delimiter', s:palette.fg, s:palette.none)
if s:configuration.disable_italic_comment
  call amora#highlight('Comment', s:palette.grey, s:palette.none)
  call amora#highlight('SpecialComment', s:palette.grey, s:palette.none)
  call amora#highlight('Todo', s:palette.blue, s:palette.none)
else
  call amora#highlight('Comment', s:palette.grey, s:palette.none, 'italic')
  call amora#highlight('SpecialComment', s:palette.grey, s:palette.none, 'italic')
  call amora#highlight('Todo', s:palette.blue, s:palette.none, 'italic')
endif
call amora#highlight('Ignore', s:palette.grey, s:palette.none)
call amora#highlight('Underlined', s:palette.none, s:palette.none, 'underline')
" }}}
" Predefined Highlight Groups: {{{
call amora#highlight('Fg', s:palette.fg, s:palette.none)
call amora#highlight('Grey', s:palette.grey, s:palette.none)
call amora#highlight('Red', s:palette.red, s:palette.none)
call amora#highlight('Orange', s:palette.orange, s:palette.none)
call amora#highlight('Yellow', s:palette.yellow, s:palette.none)
call amora#highlight('Green', s:palette.green, s:palette.none)
call amora#highlight('Blue', s:palette.blue, s:palette.none)
call amora#highlight('Purple', s:palette.purple, s:palette.none)
if s:configuration.enable_italic
  call amora#highlight('RedItalic', s:palette.red, s:palette.none, 'italic')
  call amora#highlight('OrangeItalic', s:palette.orange, s:palette.none, 'italic')
  call amora#highlight('YellowItalic', s:palette.yellow, s:palette.none, 'italic')
  call amora#highlight('GreenItalic', s:palette.green, s:palette.none, 'italic')
  call amora#highlight('BlueItalic', s:palette.blue, s:palette.none, 'italic')
  call amora#highlight('PurpleItalic', s:palette.purple, s:palette.none, 'italic')
else
  call amora#highlight('RedItalic', s:palette.red, s:palette.none)
  call amora#highlight('OrangeItalic', s:palette.orange, s:palette.none)
  call amora#highlight('YellowItalic', s:palette.yellow, s:palette.none)
  call amora#highlight('GreenItalic', s:palette.green, s:palette.none)
  call amora#highlight('BlueItalic', s:palette.blue, s:palette.none)
  call amora#highlight('PurpleItalic', s:palette.purple, s:palette.none)
endif
call amora#highlight('RedSign', s:palette.red, s:palette.none)
call amora#highlight('OrangeSign', s:palette.orange, s:palette.none)
call amora#highlight('YellowSign', s:palette.yellow, s:palette.none)
call amora#highlight('GreenSign', s:palette.green, s:palette.none)
call amora#highlight('BlueSign', s:palette.blue, s:palette.none)
call amora#highlight('PurpleSign', s:palette.purple, s:palette.none)
if s:configuration.diagnostic_text_highlight
  call amora#highlight('ErrorText', s:palette.none, s:palette.diff_red, 'undercurl', s:palette.red)
  call amora#highlight('WarningText', s:palette.none, s:palette.diff_yellow, 'undercurl', s:palette.yellow)
  call amora#highlight('InfoText', s:palette.none, s:palette.diff_blue, 'undercurl', s:palette.blue)
  call amora#highlight('HintText', s:palette.none, s:palette.diff_green, 'undercurl', s:palette.green)
else
  call amora#highlight('ErrorText', s:palette.none, s:palette.none, 'undercurl', s:palette.red)
  call amora#highlight('WarningText', s:palette.none, s:palette.none, 'undercurl', s:palette.yellow)
  call amora#highlight('InfoText', s:palette.none, s:palette.none, 'undercurl', s:palette.blue)
  call amora#highlight('HintText', s:palette.none, s:palette.none, 'undercurl', s:palette.green)
endif
if s:configuration.diagnostic_line_highlight
  call amora#highlight('ErrorLine', s:palette.none, s:palette.diff_red)
  call amora#highlight('WarningLine', s:palette.none, s:palette.diff_yellow)
  call amora#highlight('InfoLine', s:palette.none, s:palette.diff_blue)
  call amora#highlight('HintLine', s:palette.none, s:palette.diff_green)
else
  highlight clear ErrorLine
  highlight clear WarningLine
  highlight clear InfoLine
  highlight clear HintLine
endif
if s:configuration.diagnostic_virtual_text ==# 'grey'
  highlight! link VirtualTextWarning Grey
  highlight! link VirtualTextError Grey
  highlight! link VirtualTextInfo Grey
  highlight! link VirtualTextHint Grey
else
  highlight! link VirtualTextWarning Yellow
  highlight! link VirtualTextError Red
  highlight! link VirtualTextInfo Blue
  highlight! link VirtualTextHint Green
endif
call amora#highlight('ErrorFloat', s:palette.red, s:palette.bg2)
call amora#highlight('WarningFloat', s:palette.yellow, s:palette.bg2)
call amora#highlight('InfoFloat', s:palette.blue, s:palette.bg2)
call amora#highlight('HintFloat', s:palette.green, s:palette.bg2)
if &diff
  call amora#highlight('CurrentWord', s:palette.bg0, s:palette.purple)
elseif s:configuration.current_word ==# 'grey background'
  call amora#highlight('CurrentWord', s:palette.none, s:palette.bg2)
else
  call amora#highlight('CurrentWord', s:palette.none, s:palette.none, s:configuration.current_word)
endif
" }}}
" }}}
" Terminal: {{{
if (has('termguicolors') && &termguicolors) || has('gui_running')
  " Definition
  let s:terminal = {
        \ 'black':           s:palette.black,
        \ 'red':             s:palette.red,
        \ 'yellow':          s:palette.yellow,
        \ 'green':           s:palette.green,
        \ 'cyan':            s:palette.orange,
        \ 'blue':            s:palette.blue,
        \ 'purple':          s:palette.purple,
        \ 'white':           s:palette.fg,
        \ 'bright_black':    s:palette.grey,
        \ }
  " Implementation: {{{
  if !has('nvim')
    let g:terminal_ansi_colors = [s:terminal.black[0], s:terminal.red[0], s:terminal.green[0], s:terminal.yellow[0],
          \ s:terminal.blue[0], s:terminal.purple[0], s:terminal.cyan[0], s:terminal.white[0], s:terminal.black[0], s:terminal.red[0],
          \ s:terminal.green[0], s:terminal.yellow[0], s:terminal.blue[0], s:terminal.purple[0], s:terminal.cyan[0], s:terminal.white[0]]
  else
    let g:terminal_color_0 = s:terminal.black[0]
    let g:terminal_color_1 = s:terminal.red[0]
    let g:terminal_color_2 = s:terminal.green[0]
    let g:terminal_color_3 = s:terminal.yellow[0]
    let g:terminal_color_4 = s:terminal.blue[0]
    let g:terminal_color_5 = s:terminal.purple[0]
    let g:terminal_color_6 = s:terminal.cyan[0]
    let g:terminal_color_7 = s:terminal.white[0]
    let g:terminal_color_8 = s:terminal.bright_black[0]
    let g:terminal_color_9 = s:terminal.red[0]
    let g:terminal_color_10 = s:terminal.green[0]
    let g:terminal_color_11 = s:terminal.yellow[0]
    let g:terminal_color_12 = s:terminal.blue[0]
    let g:terminal_color_13 = s:terminal.purple[0]
    let g:terminal_color_14 = s:terminal.cyan[0]
    let g:terminal_color_15 = s:terminal.white[0]
  endif
  " }}}
endif
" }}}
" Plugins: {{{
" nvim-treesitter/nvim-treesitter {{{
call amora#highlight('TSStrong', s:palette.none, s:palette.none, 'bold')
call amora#highlight('TSEmphasis', s:palette.none, s:palette.none, 'italic')
call amora#highlight('TSUnderline', s:palette.none, s:palette.none, 'underline')
call amora#highlight('TSNote', s:palette.bg0, s:palette.blue, 'bold')
call amora#highlight('TSWarning', s:palette.bg0, s:palette.yellow, 'bold')
call amora#highlight('TSDanger', s:palette.bg0, s:palette.red, 'bold')
highlight! link TSAnnotation BlueItalic
highlight! link TSAttribute BlueItalic
highlight! link TSBoolean Purple
highlight! link TSCharacter Yellow
highlight! link TSComment Comment
highlight! link TSConditional Red
highlight! link TSConstBuiltin OrangeItalic
highlight! link TSConstMacro OrangeItalic
highlight! link TSConstant OrangeItalic
highlight! link TSConstructor PurpleItalic
highlight! link TSException Red
highlight! link TSField PurpleItalic
highlight! link TSFloat Purple
highlight! link TSFuncBuiltin PurpleItalic
highlight! link TSFuncMacro PurpleItalic
highlight! link TSFunction PurpleItalic
highlight! link TSInclude Red
highlight! link TSKeyword Red
highlight! link TSKeywordFunction Red
highlight! link TSKeywordOperator Red
highlight! link TSLabel Red
highlight! link TSMethod PurpleItalic
highlight! link TSNamespace BlueItalic
highlight! link TSNone Fg
highlight! link TSNumber Purple
highlight! link TSOperator Red
highlight! link TSParameter Fg
highlight! link TSParameterReference Fg
highlight! link TSProperty Fg
highlight! link TSPunctBracket Grey
highlight! link TSPunctDelimiter Grey
highlight! link TSPunctSpecial Yellow
highlight! link TSRepeat Red
highlight! link TSString Yellow
highlight! link TSStringEscape PurpleItalic
highlight! link TSStringRegex PurpleItalic
highlight! link TSStructure OrangeItalic
highlight! link TSSymbol Fg
highlight! link TSTag BlueItalic
highlight! link TSTagDelimiter Red
highlight! link TSText PurpleItalic
highlight! link TSStrike Grey
highlight! link TSMath Yellow
highlight! link TSType BlueItalic
highlight! link TSTypeBuiltin BlueItalic
highlight! link TSURI markdownUrl
highlight! link TSVariable Fg
highlight! link TSVariableBuiltin OrangeItalic
" }}}
" neoclide/coc.nvim {{{
call amora#highlight('CocHoverRange', s:palette.none, s:palette.none, 'bold,underline')
highlight! link CocSemClass TSType
highlight! link CocSemEnum TSType
highlight! link CocSemInterface TSType
highlight! link CocSemStruct TSType
highlight! link CocSemTypeParameter TSType
highlight! link CocSemVariable TSVariable
highlight! link CocSemEnumMember TSVariableBuiltin
highlight! link CocSemEvent TSLabel
highlight! link CocSemModifier TSOperator
highlight! link CocErrorFloat ErrorFloat
highlight! link CocWarningFloat WarningFloat
highlight! link CocInfoFloat InfoFloat
highlight! link CocHintFloat HintFloat
highlight! link CocErrorHighlight ErrorText
highlight! link CocWarningHighlight WarningText
highlight! link CocInfoHighlight InfoText
highlight! link CocHintHighlight HintText
highlight! link CocHighlightText CurrentWord
highlight! link CocHoverRange CurrentWord
highlight! link CocErrorSign RedSign
highlight! link CocWarningSign YellowSign
highlight! link CocInfoSign BlueSign
highlight! link CocHintSign GreenSign
highlight! link CocWarningVirtualText VirtualTextWarning
highlight! link CocErrorVirtualText VirtualTextError
highlight! link CocInfoVirtualText VirtualTextInfo
highlight! link CocHintVirtualText VirtualTextHint
highlight! link CocErrorLine ErrorLine
highlight! link CocWarningLine WarningLine
highlight! link CocInfoLine InfoLine
highlight! link CocHintLine HintLine
highlight! link CocCodeLens Grey
highlight! link CocFadeOut Grey
highlight! link CocStrikeThrough Grey
highlight! link CocListMode StatusLine
highlight! link CocListPath StatusLine
highlight! link CocSelectedText Red
highlight! link CocListsLine Fg
highlight! link CocListsDesc Grey
highlight! link HighlightedyankRegion Visual
highlight! link CocGitAddedSign GreenSign
highlight! link CocGitChangeRemovedSign PurpleSign
highlight! link CocGitChangedSign BlueSign
highlight! link CocGitRemovedSign RedSign
highlight! link CocGitTopRemovedSign RedSign
" }}}
" prabirshrestha/vim-lsp {{{
highlight! link LspErrorVirtual VirtualTextError
highlight! link LspWarningVirtual VirtualTextWarning
highlight! link LspInformationVirtual VirtualTextInfo
highlight! link LspHintVirtual VirtualTextHint
highlight! link LspErrorHighlight ErrorText
highlight! link LspWarningHighlight WarningText
highlight! link LspInformationHighlight InfoText
highlight! link LspHintHighlight HintText
highlight! link lspReference CurrentWord
" }}}
" ycm-core/YouCompleteMe {{{
highlight! link YcmErrorSign RedSign
highlight! link YcmWarningSign YellowSign
highlight! link YcmErrorLine ErrorLine
highlight! link YcmWarningLine WarningLine
highlight! link YcmErrorSection ErrorText
highlight! link YcmWarningSection WarningText
" }}}
" dense-analysis/ale {{{
highlight! link ALEError ErrorText
highlight! link ALEWarning WarningText
highlight! link ALEInfo InfoText
highlight! link ALEErrorSign RedSign
highlight! link ALEWarningSign YellowSign
highlight! link ALEInfoSign BlueSign
highlight! link ALEErrorLine ErrorLine
highlight! link ALEWarningLine WarningLine
highlight! link ALEInfoLine InfoLine
highlight! link ALEVirtualTextError VirtualTextError
highlight! link ALEVirtualTextWarning VirtualTextWarning
highlight! link ALEVirtualTextInfo VirtualTextInfo
highlight! link ALEVirtualTextStyleError VirtualTextHint
highlight! link ALEVirtualTextStyleWarning VirtualTextHint
" }}}
" neomake/neomake {{{
highlight! link NeomakeError ErrorText
highlight! link NeomakeWarning WarningText
highlight! link NeomakeInfo InfoText
highlight! link NeomakeMessage HintText
highlight! link NeomakeErrorSign RedSign
highlight! link NeomakeWarningSign YellowSign
highlight! link NeomakeInfoSign BlueSign
highlight! link NeomakeMessageSign GreenSign
highlight! link NeomakeVirtualtextError VirtualTextError
highlight! link NeomakeVirtualtextWarning VirtualTextWarning
highlight! link NeomakeVirtualtextInfo VirtualTextInfo
highlight! link NeomakeVirtualtextMessag VirtualTextHint
" }}}
" vim-syntastic/syntastic {{{
highlight! link SyntasticError ErrorText
highlight! link SyntasticWarning WarningText
highlight! link SyntasticErrorSign RedSign
highlight! link SyntasticWarningSign YellowSign
highlight! link SyntasticErrorLine ErrorLine
highlight! link SyntasticWarningLine WarningLine
" }}}
" Yggdroot/LeaderF{{{
if !exists('g:Lf_StlColorscheme')
  let g:Lf_StlColorscheme = 'one'
endif
call amora#highlight('Lf_hl_match', s:palette.green, s:palette.none, 'bold')
call amora#highlight('Lf_hl_match0', s:palette.green, s:palette.none, 'bold')
call amora#highlight('Lf_hl_match1', s:palette.blue, s:palette.none, 'bold')
call amora#highlight('Lf_hl_match2', s:palette.red, s:palette.none, 'bold')
call amora#highlight('Lf_hl_match3', s:palette.yellow, s:palette.none, 'bold')
call amora#highlight('Lf_hl_match4', s:palette.purple, s:palette.none, 'bold')
call amora#highlight('Lf_hl_matchRefine', s:palette.yellow, s:palette.none, 'bold')
call amora#highlight('Lf_hl_popup_normalMode', s:palette.bg0, s:palette.blue, 'bold')
call amora#highlight('Lf_hl_popup_inputMode', s:palette.bg0, s:palette.green, 'bold')
call amora#highlight('Lf_hl_popup_category', s:palette.fg, s:palette.bg4)
call amora#highlight('Lf_hl_popup_nameOnlyMode', s:palette.fg, s:palette.bg3)
call amora#highlight('Lf_hl_popup_fullPathMode', s:palette.fg, s:palette.bg3)
call amora#highlight('Lf_hl_popup_fuzzyMode', s:palette.fg, s:palette.bg3)
call amora#highlight('Lf_hl_popup_regexMode', s:palette.fg, s:palette.bg3)
call amora#highlight('Lf_hl_popup_lineInfo', s:palette.bg0, s:palette.blue)
call amora#highlight('Lf_hl_popup_total', s:palette.bg0, s:palette.red)
call amora#highlight('Lf_hl_popup_cursor', s:palette.bg0, s:palette.blue)
highlight! link Lf_hl_cursorline Fg
highlight! link Lf_hl_selection DiffAdd
highlight! link Lf_hl_rgHighlight Visual
highlight! link Lf_hl_gtagsHighlight Visual
highlight! link Lf_hl_popup_inputText Pmenu
highlight! link Lf_hl_popup_window Pmenu
highlight! link Lf_hl_popup_prompt Blue
highlight! link Lf_hl_popup_cwd Pmenu
highlight! link Lf_hl_popup_blank Lf_hl_popup_window
highlight! link Lf_hl_popup_spin Purple
" }}}
" liuchengxu/vim-clap {{{
call amora#highlight('ClapSelected', s:palette.red, s:palette.none, 'bold')
call amora#highlight('ClapCurrentSelection', s:palette.none, s:palette.bg0, 'bold')
call amora#highlight('ClapSpinner', s:palette.blue, s:palette.bg2, 'bold')
call amora#highlight('ClapBlines', s:palette.fg, s:palette.none)
call amora#highlight('ClapProviderId', s:palette.fg, s:palette.none, 'bold')
call amora#highlight('ClapMatches1', s:palette.red, s:palette.none, 'bold')
call amora#highlight('ClapMatches2', s:palette.orange, s:palette.none, 'bold')
call amora#highlight('ClapMatches3', s:palette.yellow, s:palette.none, 'bold')
call amora#highlight('ClapMatches4', s:palette.blue, s:palette.none, 'bold')
call amora#highlight('ClapMatches5', s:palette.purple, s:palette.none, 'bold')
call amora#highlight('ClapFuzzyMatches', s:palette.green, s:palette.none, 'bold')
call amora#highlight('ClapNoMatchesFound', s:palette.red, s:palette.none, 'bold')
highlight! link ClapInput Pmenu
highlight! link ClapDisplay Pmenu
highlight! link ClapPreview Pmenu
highlight! link ClapFuzzyMatches1 ClapFuzzyMatches
highlight! link ClapFuzzyMatches2 ClapFuzzyMatches
highlight! link ClapFuzzyMatches3 ClapFuzzyMatches
highlight! link ClapFuzzyMatches4 ClapFuzzyMatches
highlight! link ClapFuzzyMatches5 ClapFuzzyMatches
highlight! link ClapFuzzyMatches6 ClapFuzzyMatches
highlight! link ClapFuzzyMatches7 ClapFuzzyMatches
highlight! link ClapFuzzyMatches8 ClapFuzzyMatches
highlight! link ClapFuzzyMatches9 ClapFuzzyMatches
highlight! link ClapFuzzyMatches10 ClapFuzzyMatches
highlight! link ClapFuzzyMatches11 ClapFuzzyMatches
highlight! link ClapFuzzyMatches12 ClapFuzzyMatches
highlight! link ClapBlinesLineNr Grey
highlight! link ClapProviderColon ClapBlines
highlight! link ClapProviderAbout ClapBlines
highlight! link ClapFile Fg
highlight! link ClapSearchText ClapFuzzyMatches
" }}}
" junegunn/fzf.vim {{{
let g:fzf_colors = {
      \ 'fg': ['fg', 'Normal'],
      \ 'bg': ['bg', 'Normal'],
      \ 'hl': ['fg', 'Green'],
      \ 'fg+': ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+': ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+': ['fg', 'Green'],
      \ 'info': ['fg', 'Yellow'],
      \ 'border':  ['fg', 'Grey'],
      \ 'prompt': ['fg', 'Red'],
      \ 'pointer': ['fg', 'Blue'],
      \ 'marker': ['fg', 'Blue'],
      \ 'spinner': ['fg', 'Yellow'],
      \ 'header': ['fg', 'Blue']
      \ }
" }}}
" Shougo/denite.nvim{{{
call amora#highlight('deniteMatchedChar', s:palette.green, s:palette.none, 'bold')
call amora#highlight('deniteMatchedRange', s:palette.green, s:palette.none, 'bold,underline')
call amora#highlight('deniteInput', s:palette.green, s:palette.bg1, 'bold')
call amora#highlight('deniteStatusLineNumber', s:palette.purple, s:palette.bg1)
call amora#highlight('deniteStatusLinePath', s:palette.fg, s:palette.bg1)
highlight! link deniteSelectedLine Green
" }}}
" kien/ctrlp.vim{{{
call amora#highlight('CtrlPMatch', s:palette.green, s:palette.none, 'bold')
call amora#highlight('CtrlPPrtBase', s:palette.grey, s:palette.none)
call amora#highlight('CtrlPLinePre', s:palette.grey, s:palette.none)
call amora#highlight('CtrlPMode1', s:palette.blue, s:palette.bg1, 'bold')
call amora#highlight('CtrlPMode2', s:palette.bg1, s:palette.blue, 'bold')
call amora#highlight('CtrlPStats', s:palette.grey, s:palette.bg1, 'bold')
highlight! link CtrlPNoEntries Red
highlight! link CtrlPPrtCursor Blue
" }}}
" airblade/vim-gitgutter {{{
highlight! link GitGutterAdd GreenSign
highlight! link GitGutterChange BlueSign
highlight! link GitGutterDelete RedSign
highlight! link GitGutterChangeDelete PurpleSign
highlight! link GitGutterAddLine DiffAdd
highlight! link GitGutterChangeLine DiffChange
highlight! link GitGutterDeleteLine DiffDelete
highlight! link GitGutterChangeDeleteLine DiffChange
highlight! link GitGutterAddLineNr Green
highlight! link GitGutterChangeLineNr Blue
highlight! link GitGutterDeleteLineNr Red
highlight! link GitGutterChangeDeleteLineNr Purple
" }}}
" mhinz/vim-signify {{{
highlight! link SignifySignAdd GreenSign
highlight! link SignifySignChange BlueSign
highlight! link SignifySignDelete RedSign
highlight! link SignifySignChangeDelete PurpleSign
highlight! link SignifyLineAdd DiffAdd
highlight! link SignifyLineChange DiffChange
highlight! link SignifyLineChangeDelete DiffChange
highlight! link SignifyLineDelete DiffDelete
" }}}
" andymass/vim-matchup {{{
call amora#highlight('MatchParenCur', s:palette.none, s:palette.none, 'bold')
call amora#highlight('MatchWord', s:palette.none, s:palette.none, 'underline')
call amora#highlight('MatchWordCur', s:palette.none, s:palette.none, 'underline')
" }}}
" easymotion/vim-easymotion {{{
highlight! link EasyMotionTarget Search
highlight! link EasyMotionShade Grey
" }}}
" justinmk/vim-sneak {{{
call amora#highlight('SneakLabelMask', s:palette.bg_green, s:palette.bg_green)
highlight! link Sneak Search
highlight! link SneakLabel Search
highlight! link SneakScope DiffText
" }}}
" terryma/vim-multiple-cursors {{{
highlight! link multiple_cursors_cursor Cursor
highlight! link multiple_cursors_visual Visual
" }}}
" mg979/vim-visual-multi {{{
let g:VM_Mono_hl = 'Cursor'
let g:VM_Extend_hl = 'Visual'
let g:VM_Cursor_hl = 'Cursor'
let g:VM_Insert_hl = 'Cursor'
" }}}
" dominikduda/vim_current_word {{{
highlight! link CurrentWordTwins CurrentWord
" }}}
" RRethy/vim-illuminate {{{
highlight! link illuminatedWord CurrentWord
" }}}
" itchyny/vim-cursorword {{{
highlight! link CursorWord0 CurrentWord
highlight! link CursorWord1 CurrentWord
" }}}
" Yggdroot/indentLine {{{
let g:indentLine_color_gui = s:palette.grey_dim[0]
let g:indentLine_color_term = s:palette.grey_dim[1]
" }}}
" nathanaelkane/vim-indent-guides {{{
if get(g:, 'indent_guides_auto_colors', 1) == 0
  call amora#highlight('IndentGuidesOdd', s:palette.bg0, s:palette.bg1)
  call amora#highlight('IndentGuidesEven', s:palette.bg0, s:palette.bg2)
endif
" }}}
" thiagoalessio/rainbow_levels.vim {{{
highlight! link RainbowLevel0 Red
highlight! link RainbowLevel1 Orange
highlight! link RainbowLevel2 Yellow
highlight! link RainbowLevel3 Green
highlight! link RainbowLevel4 Blue
highlight! link RainbowLevel5 Purple
highlight! link RainbowLevel6 Yellow
highlight! link RainbowLevel7 Green
highlight! link RainbowLevel8 Blue
" }}}
" kshenoy/vim-signature {{{
highlight! link SignatureMarkText BlueSign
highlight! link SignatureMarkerText PurpleSign
" }}}
" ap/vim-buftabline {{{
highlight! link BufTabLineCurrent TabLineSel
highlight! link BufTabLineActive TabLine
highlight! link BufTabLineHidden TabLineFill
highlight! link BufTabLineFill TabLineFill
" }}}
" liuchengxu/vim-which-key {{{
highlight! link WhichKey Red
highlight! link WhichKeySeperator Green
highlight! link WhichKeyGroup Orange
highlight! link WhichKeyDesc Blue
" }}}
" junegunn/limelight.vim {{{
let g:limelight_conceal_ctermfg = s:palette.grey_dim[1]
let g:limelight_conceal_guifg = s:palette.grey_dim[0]
" }}}
" unblevable/quick-scope {{{
call amora#highlight('QuickScopePrimary', s:palette.green, s:palette.none, 'underline')
call amora#highlight('QuickScopeSecondary', s:palette.blue, s:palette.none, 'underline')
" }}}
" APZelos/blamer.nvim {{{
highlight! link Blamer Grey
" }}}
" cohama/agit.vim {{{
highlight! link agitTree Grey
highlight! link agitDate Green
highlight! link agitRemote Red
highlight! link agitHead Blue
highlight! link agitRef Orange
highlight! link agitTag Blue
highlight! link agitStatFile Blue
highlight! link agitStatRemoved Red
highlight! link agitStatAdded Green
highlight! link agitStatMessage Orange
highlight! link agitDiffRemove Red
highlight! link agitDiffAdd Green
highlight! link agitDiffHeader Blue
highlight! link agitAuthor Yellow
" }}}
if has('nvim')
" hrsh7th/nvim-cmp {{{
call amora#highlight('CmpItemAbbrMatch', s:palette.green, s:palette.none, 'bold')
call amora#highlight('CmpItemAbbrMatchFuzzy', s:palette.green, s:palette.none, 'bold')
highlight! link CmpItemAbbr Fg
highlight! link CmpItemAbbrDeprecated Fg
highlight! link CmpItemMenu Fg
highlight! link CmpItemKind Blue
highlight! link CmpItemKindText Fg
highlight! link CmpItemKindMethod Green
highlight! link CmpItemKindFunction Green
highlight! link CmpItemKindConstructor Green
highlight! link CmpItemKindField Green
highlight! link CmpItemKindVariable Orange
highlight! link CmpItemKindClass Blue
highlight! link CmpItemKindInterface Blue
highlight! link CmpItemKindModule Blue
highlight! link CmpItemKindProperty Orange
highlight! link CmpItemKindUnit Purple
highlight! link CmpItemKindValue Purple
highlight! link CmpItemKindEnum Blue
highlight! link CmpItemKindKeyword Red
highlight! link CmpItemKindSnippet Yellow
highlight! link CmpItemKindColor Yellow
highlight! link CmpItemKindFile Yellow
highlight! link CmpItemKindReference Yellow
highlight! link CmpItemKindFolder Yellow
highlight! link CmpItemKindEnumMember Purple
highlight! link CmpItemKindConstant Orange
highlight! link CmpItemKindStruct Blue
highlight! link CmpItemKindEvent Red
highlight! link CmpItemKindOperator Red
highlight! link CmpItemKindTypeParameter Blue
" }}}
" folke/trouble.nvim {{{
highlight! link TroubleText Fg
highlight! link TroubleSource Grey
highlight! link TroubleCode Grey
" }}}
" nvim-telescope/telescope.nvim {{{
call amora#highlight('TelescopeMatching', s:palette.green, s:palette.none, 'bold')
highlight! link TelescopeBorder Grey
highlight! link TelescopePromptPrefix Blue
highlight! link TelescopeSelection DiffAdd
" }}}
" lewis6991/gitsigns.nvim {{{
highlight! link GitSignsAdd GreenSign
highlight! link GitSignsChange BlueSign
highlight! link GitSignsDelete RedSign
highlight! link GitSignsAddNr Green
highlight! link GitSignsChangeNr Blue
highlight! link GitSignsDeleteNr Red
highlight! link GitSignsAddLn DiffAdd
highlight! link GitSignsChangeLn DiffChange
highlight! link GitSignsDeleteLn DiffDelete
highlight! link GitSignsCurrentLineBlame Grey
" }}}
" phaazon/hop.nvim {{{
call amora#highlight('HopNextKey', s:palette.red, s:palette.none, 'bold')
call amora#highlight('HopNextKey1', s:palette.blue, s:palette.none, 'bold')
highlight! link HopNextKey2 Blue
highlight! link HopUnmatched Grey
" }}}
" lukas-reineke/indent-blankline.nvim {{{
highlight! link IndentBlanklineChar Conceal
highlight! link IndentBlanklineSpaceChar Conceal
highlight! link IndentBlanklineSpaceCharBlankline Conceal
highlight! link IndentBlanklineContextChar Grey
" }}}
" p00f/nvim-ts-rainbow {{{
highlight! link rainbowcol1 Red
highlight! link rainbowcol2 Orange
highlight! link rainbowcol3 Yellow
highlight! link rainbowcol4 Green
highlight! link rainbowcol5 Blue
highlight! link rainbowcol6 Purple
highlight! link rainbowcol7 Green
" }}}
" romgrk/barbar.nvim {{{
call amora#highlight('BufferCurrent', s:palette.fg, s:palette.bg4)
call amora#highlight('BufferCurrentIndex', s:palette.fg, s:palette.bg4)
call amora#highlight('BufferCurrentMod', s:palette.blue, s:palette.bg4)
call amora#highlight('BufferCurrentSign', s:palette.red, s:palette.bg4)
call amora#highlight('BufferCurrentTarget', s:palette.red, s:palette.bg4, 'bold')
call amora#highlight('BufferVisible', s:palette.fg, s:palette.bg2)
call amora#highlight('BufferVisibleIndex', s:palette.fg, s:palette.bg2)
call amora#highlight('BufferVisibleMod', s:palette.blue, s:palette.bg2)
call amora#highlight('BufferVisibleSign', s:palette.red, s:palette.bg2)
call amora#highlight('BufferVisibleTarget', s:palette.yellow, s:palette.bg2, 'bold')
call amora#highlight('BufferInactive', s:palette.grey, s:palette.bg2)
call amora#highlight('BufferInactiveIndex', s:palette.grey, s:palette.bg2)
call amora#highlight('BufferInactiveMod', s:palette.grey, s:palette.bg2)
call amora#highlight('BufferInactiveSign', s:palette.grey_dim, s:palette.bg2)
call amora#highlight('BufferInactiveTarget', s:palette.yellow, s:palette.bg2, 'bold')
call amora#highlight('BufferTabpages', s:palette.bg0, s:palette.blue, 'bold')
call amora#highlight('BufferTabpageFill', s:palette.bg0, s:palette.bg0)
" }}}
" rcarriga/nvim-notify {{{
highlight! link NotifyERRORBorder Red
highlight! link NotifyWARNBorder Yellow
highlight! link NotifyINFOBorder Green
highlight! link NotifyDEBUGBorder Grey
highlight! link NotifyTRACEBorder Purple
highlight! link NotifyERRORIcon Red
highlight! link NotifyWARNIcon Yellow
highlight! link NotifyINFOIcon Green
highlight! link NotifyDEBUGIcon Grey
highlight! link NotifyTRACEIcon Purple
highlight! link NotifyERRORTitle Red
highlight! link NotifyWARNTitle Yellow
highlight! link NotifyINFOTitle Green
highlight! link NotifyDEBUGTitle Grey
highlight! link NotifyTRACETitle Purple
" }}}
" glepnir/lspsaga.nvim {{{
call amora#highlight('LspFloatWinBorder', s:palette.bg0, s:palette.bg0)
call amora#highlight('LspSagaDiagnosticHeader', s:palette.orange, s:palette.none, 'bold')
call amora#highlight('LspSagaCodeActionTitle', s:palette.blue, s:palette.none, 'bold')
call amora#highlight('DefinitionPreviewTitle', s:palette.purple, s:palette.none, 'bold')
highlight! link LspSagaDiagnosticBorder Orange
highlight! link LspSagaDiagnosticTruncateLine Orange
highlight! link LspSagaRenameBorder Blue
highlight! link LspSagaRenamePromptPrefix Red
highlight! link LspSagaCodeActionBorder Blue
highlight! link LspSagaCodeActionTruncateLine Blue
highlight! link LspSagaCodeActionContent Purple
highlight! link LspSagaHoverBorder Purple
highlight! link LspSagaDocTruncateLine Purple
highlight! link LspSagaSignatureHelpBorder Purple
highlight! link LspSagaShTruncateLine Purple
highlight! link LspSagaDefPreviewBorder Green
highlight! link DefinitionIcon Green
highlight! link LspLinesDiagBorder Yellow
highlight! link LineDiagTuncateLine Yellow
highlight! link LspSagaAutoPreview Blue
highlight! link LspSagaFinderSelection Fg
highlight! link DiagnosticWarning DiagnosticWarn
highlight! link DiagnosticInformation DiagnosticInfo
highlight! link ReferencesCount Grey
highlight! link DefinitionCount Grey
highlight! link TargetFileName Grey
" }}}
endif
" }}}
" Extended File Types: {{{
" Whitelist: {{{ File type optimizations that will always be loaded.
" diff {{{
highlight! link diffAdded Green
highlight! link diffRemoved Red
highlight! link diffChanged Blue
highlight! link diffOldFile Yellow
highlight! link diffNewFile Orange
highlight! link diffFile Purple
highlight! link diffLine Grey
highlight! link diffIndexLine Purple
" }}}
" }}}
" Generate the `after/syntax` directory based on the comment tags in this file.
" For example, the content between `syn_begin: sh/zsh` and `syn_end` will be placed in `after/syntax/sh/amora.vim` and `after/syntax/zsh/amora.vim`.
if amora#syn_exists(s:path) " If the syntax files exist.
  if s:configuration.better_performance
    if !amora#syn_newest(s:path, s:last_modified) " Regenerate if it's not up to date.
      call amora#syn_clean(s:path, 0)
      call amora#syn_gen(s:path, s:last_modified, 'update')
    endif
    finish
  else
    call amora#syn_clean(s:path, 1)
  endif
else
  if s:configuration.better_performance
    call amora#syn_gen(s:path, s:last_modified, 'generate')
    finish
  endif
endif
" syn_begin: vim-plug {{{
" https://github.com/junegunn/vim-plug
call amora#highlight('plug1', s:palette.red, s:palette.none, 'bold')
call amora#highlight('plugNumber', s:palette.yellow, s:palette.none, 'bold')
highlight! link plug2 Blue
highlight! link plugBracket Blue
highlight! link plugName Green
highlight! link plugDash Red
highlight! link plugNotLoaded Grey
highlight! link plugH2 Purple
highlight! link plugMessage Purple
highlight! link plugError Red
highlight! link plugRelDate Grey
highlight! link plugStar Purple
highlight! link plugUpdate Blue
highlight! link plugDeleted Grey
highlight! link plugEdge Purple
" syn_end }}}
" syn_begin: coctree {{{
" https://github.com/neoclide/coc.nvim
highlight! link CocTreeOpenClose Purple
highlight! link CocTreeDescription Grey
highlight! link CocSymbolFile Red
highlight! link CocSymbolModule Green
highlight! link CocSymbolNamespace Green
highlight! link CocSymbolPackage Green
highlight! link CocSymbolClass Blue
highlight! link CocSymbolMethod Red
highlight! link CocSymbolProperty Orange
highlight! link CocSymbolField Red
highlight! link CocSymbolConstructor Red
highlight! link CocSymbolEnum Blue
highlight! link CocSymbolInterface Blue
highlight! link CocSymbolFunction Red
highlight! link CocSymbolVariable Orange
highlight! link CocSymbolConstant Orange
highlight! link CocSymbolString Yellow
highlight! link CocSymbolNumber Yellow
highlight! link CocSymbolBoolean Yellow
highlight! link CocSymbolArray Yellow
highlight! link CocSymbolObject Yellow
highlight! link CocSymbolKey Green
highlight! link CocSymbolNull Yellow
highlight! link CocSymbolEnumMember Orange
highlight! link CocSymbolStruct Blue
highlight! link CocSymbolEvent Yellow
highlight! link CocSymbolOperator Yellow
highlight! link CocSymbolTypeParameter Blue
highlight! link CocSymbolDefault Yellow
" syn_end }}}
" syn_begin: coc-explorer {{{
" https://github.com/weirongxu/coc-explorer
highlight! link CocExplorerBufferRoot Red
highlight! link CocExplorerBufferExpandIcon Blue
highlight! link CocExplorerBufferBufnr Yellow
highlight! link CocExplorerBufferModified Yellow
highlight! link CocExplorerBufferReadonly Red
highlight! link CocExplorerBufferBufname Grey
highlight! link CocExplorerBufferFullpath Grey
highlight! link CocExplorerFileRoot Red
highlight! link CocExplorerFileRootName Purple
highlight! link CocExplorerFileExpandIcon Blue
highlight! link CocExplorerFileFullpath Grey
highlight! link CocExplorerFileDirectory Purple
highlight! link CocExplorerFileGitStaged Green
highlight! link CocExplorerFileGitUnstaged Yellow
highlight! link CocExplorerFileGitRootStaged Green
highlight! link CocExplorerFileGitRootUnstaged Yellow
highlight! link CocExplorerGitPathChange Fg
highlight! link CocExplorerGitContentChange Fg
highlight! link CocExplorerGitRenamed Green
highlight! link CocExplorerGitCopied Fg
highlight! link CocExplorerGitAdded Purple
highlight! link CocExplorerGitUntracked Blue
highlight! link CocExplorerGitUnmodified Fg
highlight! link CocExplorerGitUnmerged Orange
highlight! link CocExplorerGitMixed Fg
highlight! link CocExplorerGitModified Yellow
highlight! link CocExplorerGitDeleted Red
highlight! link CocExplorerGitIgnored Grey
highlight! link CocExplorerFileSize Blue
highlight! link CocExplorerTimeAccessed Green
highlight! link CocExplorerTimeCreated Green
highlight! link CocExplorerTimeModified Green
highlight! link CocExplorerFileRootName Orange
highlight! link CocExplorerBufferNameVisible Purple
highlight! link CocExplorerIndentLine Conceal
highlight! link CocExplorerHelpDescription Grey
highlight! link CocExplorerHelpHint Grey
highlight! link CocExplorerDiagnosticError Red
highlight! link CocExplorerDiagnosticWarning Yellow
highlight! link CocExplorerFileHidden Grey
" syn_end }}}
" syn_begin: tagbar {{{
" https://github.com/majutsushi/tagbar
highlight! link TagbarFoldIcon Blue
highlight! link TagbarSignature Purple
highlight! link TagbarKind Red
highlight! link TagbarScope Orange
highlight! link TagbarNestedKind Blue
highlight! link TagbarVisibilityPrivate Red
highlight! link TagbarVisibilityPublic Blue
" syn_end }}}
" syn_begin: vista/vista_kind/vista_markdown {{{
" https://github.com/liuchengxu/vista.vim
highlight! link VistaBracket Grey
highlight! link VistaChildrenNr Orange
highlight! link VistaScope Red
highlight! link VistaTag Purple
highlight! link VistaPrefix Grey
highlight! link VistaIcon Blue
highlight! link VistaScopeKind Yellow
highlight! link VistaColon Grey
highlight! link VistaLineNr Grey
highlight! link VistaHeadNr Fg
highlight! link VistaPublic Purple
highlight! link VistaProtected Yellow
highlight! link VistaPrivate Red
" syn_end }}}
" syn_begin: nerdtree {{{
" https://github.com/preservim/nerdtree
highlight! link NERDTreeDir Purple
highlight! link NERDTreeDirSlash Purple
highlight! link NERDTreeOpenable Blue
highlight! link NERDTreeClosable Blue
highlight! link NERDTreeFile Fg
highlight! link NERDTreeExecFile Red
highlight! link NERDTreeUp Grey
highlight! link NERDTreeCWD Green
highlight! link NERDTreeHelp Grey
highlight! link NERDTreeToggleOn Purple
highlight! link NERDTreeToggleOff Red
highlight! link NERDTreeFlags Blue
highlight! link NERDTreeLinkFile Grey
highlight! link NERDTreeLinkTarget Green
" syn_end }}}
" syn_begin: dirvish {{{
" https://github.com/justinmk/vim-dirvish
highlight! link DirvishPathTail Blue
highlight! link DirvishArg Yellow
" syn_end }}}
" syn_begin: NvimTree {{{
" https://github.com/kyazdani42/nvim-tree.lua
highlight! link NvimTreeSymlink Fg
highlight! link NvimTreeFolderName Purple
highlight! link NvimTreeRootFolder Grey
highlight! link NvimTreeFolderIcon Blue
highlight! link NvimTreeEmptyFolderName Purple
highlight! link NvimTreeOpenedFolderName Purple
highlight! link NvimTreeExecFile Fg
highlight! link NvimTreeOpenedFile Fg
highlight! link NvimTreeSpecialFile Fg
highlight! link NvimTreeImageFile Fg
highlight! link NvimTreeMarkdownFile Fg
highlight! link NvimTreeIndentMarker Grey
highlight! link NvimTreeGitDirty Yellow
highlight! link NvimTreeGitStaged Blue
highlight! link NvimTreeGitMerge Orange
highlight! link NvimTreeGitRenamed Green
highlight! link NvimTreeGitNew Green
highlight! link NvimTreeGitDeleted Red
highlight! link NvimTreeLspDiagnosticsError RedSign
highlight! link NvimTreeLspDiagnosticsWarning YellowSign
highlight! link NvimTreeLspDiagnosticsInformation BlueSign
highlight! link NvimTreeLspDiagnosticsHint GreenSign
" syn_end }}}
" syn_begin: fern {{{
" https://github.com/lambdalisue/fern.vim
highlight! link FernMarkedLine None
highlight! link FernMarkedText Purple
highlight! link FernRootSymbol FernRootText
highlight! link FernRootText Blue
highlight! link FernLeafSymbol FernLeafText
highlight! link FernLeafText Fg
highlight! link FernBranchSymbol FernBranchText
highlight! link FernBranchText Green
highlight! link FernWindowSelectIndicator TabLineSel
highlight! link FernWindowSelectStatusLine TabLine
" syn_end }}}
" syn_begin: netrw {{{
" https://www.vim.org/scripts/script.php?script_id=1075
highlight! link netrwDir Purple
highlight! link netrwClassify Purple
highlight! link netrwLink Grey
highlight! link netrwSymLink Fg
highlight! link netrwExe Red
highlight! link netrwComment Grey
highlight! link netrwList Yellow
highlight! link netrwHelpCmd Blue
highlight! link netrwCmdSep Grey
highlight! link netrwVersion Green
" syn_end }}}
" syn_begin: startify/quickmenu {{{
" https://github.com/mhinz/vim-startify
" https://github.com/skywind3000/quickmenu.vim
highlight! link StartifyBracket Grey
highlight! link StartifyFile Purple
highlight! link StartifyNumber Red
highlight! link StartifyPath Grey
highlight! link StartifySlash Grey
highlight! link StartifySection Blue
highlight! link StartifyHeader Green
highlight! link StartifySpecial Grey
" syn_end }}}
" syn_begin: quickmenu {{{
" https://github.com/skywind3000/quickmenu.vim
highlight! link QuickmenuOption Purple
highlight! link QuickmenuNumber Orange
highlight! link QuickmenuBracket Grey
highlight! link QuickmenuHelp Blue
highlight! link QuickmenuSpecial Grey
highlight! link QuickmenuHeader Green
" syn_end }}}
" syn_begin: undotree {{{
" https://github.com/mbbill/undotree
call amora#highlight('UndotreeSavedBig', s:palette.red, s:palette.none, 'bold')
highlight! link UndotreeNode Blue
highlight! link UndotreeNodeCurrent Purple
highlight! link UndotreeSeq Green
highlight! link UndotreeCurrent Blue
highlight! link UndotreeNext Yellow
highlight! link UndotreeTimeStamp Grey
highlight! link UndotreeHead Purple
highlight! link UndotreeBranch Blue
highlight! link UndotreeSavedSmall Red
" syn_end }}}
" syn_begin: NeogitStatus/NeogitCommitView {{{
" https://github.com/TimUntersberger/neogit
highlight! link NeogitNotificationInfo Blue
highlight! link NeogitNotificationWarning Yellow
highlight! link NeogitNotificationError Red
highlight! link NeogitDiffAdd Green
highlight! link NeogitDiffDelete Red
highlight! link NeogitDiffContextHighlight CursorLine
highlight! link NeogitHunkHeaderHighlight TabLine
highlight! link NeogitHunkHeader TabLineFill
highlight! link NeogitCommandCodeNormal Green
highlight! link NeogitCommandCodeError Red
highlight! link NeogitCommitViewHeader diffIndexLine
highlight! link NeogitFilePath diffFile
" syn_end }}}
" syn_begin: dashboard {{{
" https://github.com/glepnir/dashboard-nvim
highlight! link DashboardHeader Blue
highlight! link DashboardCenter Green
highlight! link DashboardShortcut Red
highlight! link DashboardFooter Yellow
" syn_end }}}
" syn_begin: markdown {{{
" builtin: {{{
call amora#highlight('markdownH1', s:palette.red, s:palette.none, 'bold')
call amora#highlight('markdownH2', s:palette.orange, s:palette.none, 'bold')
call amora#highlight('markdownH3', s:palette.yellow, s:palette.none, 'bold')
call amora#highlight('markdownH4', s:palette.green, s:palette.none, 'bold')
call amora#highlight('markdownH5', s:palette.blue, s:palette.none, 'bold')
call amora#highlight('markdownH6', s:palette.purple, s:palette.none, 'bold')
call amora#highlight('markdownUrl', s:palette.blue, s:palette.none, 'underline')
call amora#highlight('markdownItalic', s:palette.none, s:palette.none, 'italic')
call amora#highlight('markdownBold', s:palette.none, s:palette.none, 'bold')
call amora#highlight('markdownItalicDelimiter', s:palette.grey, s:palette.none, 'italic')
highlight! link markdownCode Green
highlight! link markdownCodeBlock Green
highlight! link markdownCodeDelimiter Green
highlight! link markdownBlockquote Grey
highlight! link markdownListMarker Red
highlight! link markdownOrderedListMarker Red
highlight! link markdownRule Purple
highlight! link markdownHeadingRule Grey
highlight! link markdownUrlDelimiter Grey
highlight! link markdownLinkDelimiter Grey
highlight! link markdownLinkTextDelimiter Grey
highlight! link markdownHeadingDelimiter Grey
highlight! link markdownLinkText Red
highlight! link markdownUrlTitleDelimiter Green
highlight! link markdownIdDeclaration markdownLinkText
highlight! link markdownBoldDelimiter Grey
highlight! link markdownId Yellow
" }}}
" vim-markdown: https://github.com/gabrielelana/vim-markdown{{{
call amora#highlight('mkdURL', s:palette.blue, s:palette.none, 'underline')
call amora#highlight('mkdInlineURL', s:palette.blue, s:palette.none, 'underline')
call amora#highlight('mkdItalic', s:palette.grey, s:palette.none, 'italic')
highlight! link mkdCodeDelimiter Green
highlight! link mkdBold Grey
highlight! link mkdLink Red
highlight! link mkdHeading Grey
highlight! link mkdListItem Red
highlight! link mkdRule Purple
highlight! link mkdDelimiter Grey
highlight! link mkdId Yellow
" }}}
" syn_end }}}
" syn_begin: vimwiki {{{
call amora#highlight('VimwikiHeader1', s:palette.red, s:palette.none, 'bold')
call amora#highlight('VimwikiHeader2', s:palette.orange, s:palette.none, 'bold')
call amora#highlight('VimwikiHeader3', s:palette.yellow, s:palette.none, 'bold')
call amora#highlight('VimwikiHeader4', s:palette.green, s:palette.none, 'bold')
call amora#highlight('VimwikiHeader5', s:palette.blue, s:palette.none, 'bold')
call amora#highlight('VimwikiHeader6', s:palette.purple, s:palette.none, 'bold')
call amora#highlight('VimwikiLink', s:palette.blue, s:palette.none, 'underline')
call amora#highlight('VimwikiItalic', s:palette.none, s:palette.none, 'italic')
call amora#highlight('VimwikiBold', s:palette.none, s:palette.none, 'bold')
call amora#highlight('VimwikiUnderline', s:palette.none, s:palette.none, 'underline')
highlight! link VimwikiList Red
highlight! link VimwikiTag Blue
highlight! link VimwikiCode Purple
highlight! link VimwikiHR Yellow
highlight! link VimwikiHeaderChar Grey
highlight! link VimwikiMarkers Grey
highlight! link VimwikiPre Purple
highlight! link VimwikiPreDelim Purple
highlight! link VimwikiNoExistsLink Red
" syn_end }}}
" syn_begin: rst {{{
" builtin: https://github.com/marshallward/vim-restructuredtext{{{
call amora#highlight('rstStandaloneHyperlink', s:palette.purple, s:palette.none, 'underline')
call amora#highlight('rstEmphasis', s:palette.none, s:palette.none, 'italic')
call amora#highlight('rstStrongEmphasis', s:palette.none, s:palette.none, 'bold')
call amora#highlight('rstStandaloneHyperlink', s:palette.blue, s:palette.none, 'underline')
call amora#highlight('rstHyperlinkTarget', s:palette.blue, s:palette.none, 'underline')
highlight! link rstSubstitutionReference Blue
highlight! link rstInterpretedTextOrHyperlinkReference Purple
highlight! link rstTableLines Grey
highlight! link rstInlineLiteral Purple
highlight! link rstLiteralBlock Purple
highlight! link rstQuotedLiteralBlock Purple
" }}}
" syn_end }}}
" syn_begin: tex {{{
" builtin: http://www.drchip.org/astronaut/vim/index.html#SYNTAX_TEX{{{
highlight! link texStatement BlueItalic
highlight! link texOnlyMath Grey
highlight! link texDefName Yellow
highlight! link texNewCmd Orange
highlight! link texCmdName Blue
highlight! link texBeginEnd Red
highlight! link texBeginEndName Purple
highlight! link texDocType RedItalic
highlight! link texDocTypeArgs Orange
highlight! link texInputFile Purple
" }}}
" vimtex: https://github.com/lervag/vimtex {{{
highlight! link texFileArg Purple
highlight! link texCmd BlueItalic
highlight! link texCmdPackage BlueItalic
highlight! link texCmdDef Red
highlight! link texDefArgName Yellow
highlight! link texCmdNewcmd Red
highlight! link texCmdClass Red
highlight! link texCmdTitle Red
highlight! link texCmdAuthor Red
highlight! link texCmdEnv Red
highlight! link texCmdPart Red
highlight! link texEnvArgName Purple
" }}}
" syn_end }}}
" syn_begin: html/markdown/javascriptreact/typescriptreact {{{
" builtin: https://notabug.org/jorgesumle/vim-html-syntax{{{
call amora#highlight('htmlH1', s:palette.red, s:palette.none, 'bold')
call amora#highlight('htmlH2', s:palette.orange, s:palette.none, 'bold')
call amora#highlight('htmlH3', s:palette.yellow, s:palette.none, 'bold')
call amora#highlight('htmlH4', s:palette.green, s:palette.none, 'bold')
call amora#highlight('htmlH5', s:palette.blue, s:palette.none, 'bold')
call amora#highlight('htmlH6', s:palette.purple, s:palette.none, 'bold')
call amora#highlight('htmlLink', s:palette.none, s:palette.none, 'underline')
call amora#highlight('htmlBold', s:palette.none, s:palette.none, 'bold')
call amora#highlight('htmlBoldUnderline', s:palette.none, s:palette.none, 'bold,underline')
call amora#highlight('htmlBoldItalic', s:palette.none, s:palette.none, 'bold,italic')
call amora#highlight('htmlBoldUnderlineItalic', s:palette.none, s:palette.none, 'bold,underline,italic')
call amora#highlight('htmlUnderline', s:palette.none, s:palette.none, 'underline')
call amora#highlight('htmlUnderlineItalic', s:palette.none, s:palette.none, 'underline,italic')
call amora#highlight('htmlItalic', s:palette.none, s:palette.none, 'italic')
highlight! link htmlTag Red
highlight! link htmlEndTag Blue
highlight! link htmlTagN RedItalic
highlight! link htmlTagName RedItalic
highlight! link htmlArg Blue
highlight! link htmlScriptTag Purple
highlight! link htmlSpecialTagName RedItalic
highlight! link htmlString Red
" }}}
" syn_end }}}
" syn_begin: htmldjango {{{
" builtin: https://github.com/vim/vim/blob/master/runtime/syntax/htmldjango.vim{{{
highlight! link djangoTagBlock Yellow
" }}}
" syn_end }}}
" syn_begin: xml {{{
" builtin: https://github.com/chrisbra/vim-xml-ftplugin{{{
highlight! link xmlTag Red
highlight! link xmlEndTag Blue
highlight! link xmlTagName RedItalic
highlight! link xmlEqual Orange
highlight! link xmlAttrib Blue
highlight! link xmlEntity Green
highlight! link xmlEntityPunct Green
highlight! link xmlDocTypeDecl Grey
highlight! link xmlDocTypeKeyword RedItalic
highlight! link xmlCdataStart Grey
highlight! link xmlCdataCdata Purple
highlight! link xmlString Red
" }}}
" syn_end }}}
" syn_begin: css/scss/sass/less {{{
" builtin: https://github.com/JulesWang/css.vim{{{
highlight! link cssStringQ Red
highlight! link cssStringQQ Red
highlight! link cssAttrComma Grey
highlight! link cssBraces Grey
highlight! link cssTagName Purple
highlight! link cssClassNameDot Grey
highlight! link cssClassName Green
highlight! link cssFunctionName Orange
highlight! link cssAttr Red
highlight! link cssCommonAttr Red
highlight! link cssProp Blue
highlight! link cssPseudoClassId Yellow
highlight! link cssPseudoClassFn Red
highlight! link cssPseudoClass Yellow
highlight! link cssImportant Green
highlight! link cssSelectorOp Orange
highlight! link cssSelectorOp2 Orange
highlight! link cssColor Red
highlight! link cssUnitDecorators Red
highlight! link cssValueLength Red
highlight! link cssValueInteger Red
highlight! link cssValueNumber Red
highlight! link cssValueAngle Red
highlight! link cssValueTime Red
highlight! link cssValueFrequency Red
highlight! link cssVendor Grey
highlight! link cssNoise Grey
" }}}
" syn_end }}}
" syn_begin: scss {{{
" scss-syntax: https://github.com/cakebaker/scss-syntax.vim{{{
highlight! link scssMixinName Orange
highlight! link scssSelectorChar Grey
highlight! link scssSelectorName Red
highlight! link scssInterpolationDelimiter Yellow
highlight! link scssVariableValue Green
highlight! link scssNull Purple
highlight! link scssBoolean Purple
highlight! link scssVariableAssignment Grey
highlight! link scssAttribute Green
highlight! link scssFunctionName Orange
highlight! link scssVariable Fg
highlight! link scssAmpersand Purple
" }}}
" syn_end }}}
" syn_begin: less {{{
" vim-less: https://github.com/groenewege/vim-less{{{
highlight! link lessMixinChar Grey
highlight! link lessClass Red
highlight! link lessFunction Orange
" }}}
" syn_end }}}
" syn_begin: javascript/javascriptreact {{{
" builtin: http://www.fleiner.com/vim/syntax/javascript.vim{{{
highlight! link javaScriptNull OrangeItalic
highlight! link javaScriptIdentifier BlueItalic
highlight! link javaScriptParens Fg
highlight! link javaScriptBraces Fg
highlight! link javaScriptNumber Purple
highlight! link javaScriptLabel Red
highlight! link javaScriptGlobal BlueItalic
highlight! link javaScriptMessage BlueItalic
" }}}
" vim-javascript: https://github.com/pangloss/vim-javascript{{{
highlight! link jsNoise Fg
highlight! link Noise Fg
highlight! link jsParens Fg
highlight! link jsBrackets Fg
highlight! link jsObjectBraces Fg
highlight! link jsThis BlueItalic
highlight! link jsUndefined OrangeItalic
highlight! link jsNull OrangeItalic
highlight! link jsNan OrangeItalic
highlight! link jsSuper OrangeItalic
highlight! link jsPrototype OrangeItalic
highlight! link jsFunction Red
highlight! link jsGlobalNodeObjects BlueItalic
highlight! link jsGlobalObjects BlueItalic
highlight! link jsArrowFunction Red
highlight! link jsArrowFuncArgs Fg
highlight! link jsFuncArgs Fg
highlight! link jsObjectProp Fg
highlight! link jsVariableDef Fg
highlight! link jsObjectKey Fg
highlight! link jsParen Fg
highlight! link jsParenIfElse Fg
highlight! link jsParenRepeat Fg
highlight! link jsParenSwitch Fg
highlight! link jsParenCatch Fg
highlight! link jsBracket Fg
highlight! link jsObjectValue Fg
highlight! link jsDestructuringBlock Fg
highlight! link jsBlockLabel Purple
highlight! link jsFunctionKey Green
highlight! link jsClassDefinition BlueItalic
highlight! link jsDot Grey
highlight! link jsSpreadExpression Purple
highlight! link jsSpreadOperator Green
highlight! link jsModuleKeyword BlueItalic
highlight! link jsTemplateExpression Purple
highlight! link jsTemplateBraces Purple
highlight! link jsClassMethodType BlueItalic
highlight! link jsExceptions BlueItalic
" }}}
" yajs: https://github.com/othree/yajs.vim{{{
highlight! link javascriptOpSymbol Red
highlight! link javascriptOpSymbols Red
highlight! link javascriptIdentifierName Fg
highlight! link javascriptVariable BlueItalic
highlight! link javascriptObjectLabel Fg
highlight! link javascriptPropertyNameString Fg
highlight! link javascriptFuncArg Fg
highlight! link javascriptObjectLiteral Green
highlight! link javascriptIdentifier OrangeItalic
highlight! link javascriptArrowFunc Red
highlight! link javascriptTemplate Green
highlight! link javascriptTemplateSubstitution Green
highlight! link javascriptTemplateSB Green
highlight! link javascriptNodeGlobal BlueItalic
highlight! link javascriptDocTags RedItalic
highlight! link javascriptDocNotation Blue
highlight! link javascriptClassSuper OrangeItalic
highlight! link javascriptClassName BlueItalic
highlight! link javascriptClassSuperName BlueItalic
highlight! link javascriptOperator Red
highlight! link javascriptBrackets Fg
highlight! link javascriptBraces Fg
highlight! link javascriptLabel Green
highlight! link javascriptEndColons Grey
highlight! link javascriptObjectLabelColon Grey
highlight! link javascriptDotNotation Grey
highlight! link javascriptGlobalArrayDot Grey
highlight! link javascriptGlobalBigIntDot Grey
highlight! link javascriptGlobalDateDot Grey
highlight! link javascriptGlobalJSONDot Grey
highlight! link javascriptGlobalMathDot Grey
highlight! link javascriptGlobalNumberDot Grey
highlight! link javascriptGlobalObjectDot Grey
highlight! link javascriptGlobalPromiseDot Grey
highlight! link javascriptGlobalRegExpDot Grey
highlight! link javascriptGlobalStringDot Grey
highlight! link javascriptGlobalSymbolDot Grey
highlight! link javascriptGlobalURLDot Grey
highlight! link javascriptMethod Purple
highlight! link javascriptMethodName Purple
highlight! link javascriptObjectMethodName Purple
highlight! link javascriptGlobalMethod Purple
highlight! link javascriptDOMStorageMethod Purple
highlight! link javascriptFileMethod Purple
highlight! link javascriptFileReaderMethod Purple
highlight! link javascriptFileListMethod Purple
highlight! link javascriptBlobMethod Purple
highlight! link javascriptURLStaticMethod Purple
highlight! link javascriptNumberStaticMethod Purple
highlight! link javascriptNumberMethod Purple
highlight! link javascriptDOMNodeMethod Purple
highlight! link javascriptES6BigIntStaticMethod Purple
highlight! link javascriptBOMWindowMethod Purple
highlight! link javascriptHeadersMethod Purple
highlight! link javascriptRequestMethod Purple
highlight! link javascriptResponseMethod Purple
highlight! link javascriptES6SetMethod Purple
highlight! link javascriptReflectMethod Purple
highlight! link javascriptPaymentMethod Purple
highlight! link javascriptPaymentResponseMethod Purple
highlight! link javascriptTypedArrayStaticMethod Purple
highlight! link javascriptGeolocationMethod Purple
highlight! link javascriptES6MapMethod Purple
highlight! link javascriptServiceWorkerMethod Purple
highlight! link javascriptCacheMethod Purple
highlight! link javascriptFunctionMethod Purple
highlight! link javascriptXHRMethod Purple
highlight! link javascriptBOMNavigatorMethod Purple
highlight! link javascriptServiceWorkerMethod Purple
highlight! link javascriptDOMEventTargetMethod Purple
highlight! link javascriptDOMEventMethod Purple
highlight! link javascriptIntlMethod Purple
highlight! link javascriptDOMDocMethod Purple
highlight! link javascriptStringStaticMethod Purple
highlight! link javascriptStringMethod Purple
highlight! link javascriptSymbolStaticMethod Purple
highlight! link javascriptRegExpMethod Purple
highlight! link javascriptObjectStaticMethod Purple
highlight! link javascriptObjectMethod Purple
highlight! link javascriptBOMLocationMethod Purple
highlight! link javascriptJSONStaticMethod Purple
highlight! link javascriptGeneratorMethod Purple
highlight! link javascriptEncodingMethod Purple
highlight! link javascriptPromiseStaticMethod Purple
highlight! link javascriptPromiseMethod Purple
highlight! link javascriptBOMHistoryMethod Purple
highlight! link javascriptDOMFormMethod Purple
highlight! link javascriptClipboardMethod Purple
highlight! link javascriptTypedArrayStaticMethod Purple
highlight! link javascriptBroadcastMethod Purple
highlight! link javascriptDateStaticMethod Purple
highlight! link javascriptDateMethod Purple
highlight! link javascriptConsoleMethod Purple
highlight! link javascriptArrayStaticMethod Purple
highlight! link javascriptArrayMethod Purple
highlight! link javascriptMathStaticMethod Purple
highlight! link javascriptSubtleCryptoMethod Purple
highlight! link javascriptCryptoMethod Purple
highlight! link javascriptProp Fg
highlight! link javascriptBOMWindowProp Fg
highlight! link javascriptDOMStorageProp Fg
highlight! link javascriptFileReaderProp Fg
highlight! link javascriptURLUtilsProp Fg
highlight! link javascriptNumberStaticProp Fg
highlight! link javascriptDOMNodeProp Fg
highlight! link javascriptRequestProp Fg
highlight! link javascriptResponseProp Fg
highlight! link javascriptES6SetProp Fg
highlight! link javascriptPaymentProp Fg
highlight! link javascriptPaymentResponseProp Fg
highlight! link javascriptPaymentAddressProp Fg
highlight! link javascriptPaymentShippingOptionProp Fg
highlight! link javascriptTypedArrayStaticProp Fg
highlight! link javascriptServiceWorkerProp Fg
highlight! link javascriptES6MapProp Fg
highlight! link javascriptRegExpStaticProp Fg
highlight! link javascriptRegExpProp Fg
highlight! link javascriptXHRProp Fg
highlight! link javascriptBOMNavigatorProp Green
highlight! link javascriptDOMEventProp Fg
highlight! link javascriptBOMNetworkProp Fg
highlight! link javascriptDOMDocProp Fg
highlight! link javascriptSymbolStaticProp Fg
highlight! link javascriptSymbolProp Fg
highlight! link javascriptBOMLocationProp Fg
highlight! link javascriptEncodingProp Fg
highlight! link javascriptCryptoProp Fg
highlight! link javascriptBOMHistoryProp Fg
highlight! link javascriptDOMFormProp Fg
highlight! link javascriptDataViewProp Fg
highlight! link javascriptBroadcastProp Fg
highlight! link javascriptMathStaticProp Fg
" }}}
" vim-jsx-pretty: https://github.com/maxmellon/vim-jsx-pretty{{{
highlight! link jsxTagName RedItalic
highlight! link jsxOpenPunct Red
highlight! link jsxClosePunct Blue
highlight! link jsxEscapeJs Purple
highlight! link jsxAttrib Blue
" }}}
" syn_end }}}
" syn_begin: typescript/typescriptreact {{{
" vim-typescript: https://github.com/leafgarland/typescript-vim{{{
highlight! link typescriptStorageClass Red
highlight! link typescriptEndColons Fg
highlight! link typescriptSource BlueItalic
highlight! link typescriptMessage Green
highlight! link typescriptGlobalObjects BlueItalic
highlight! link typescriptInterpolation Green
highlight! link typescriptInterpolationDelimiter Green
highlight! link typescriptBraces Fg
highlight! link typescriptParens Fg
" }}}
" yats: https:github.com/HerringtonDarkholme/yats.vim{{{
highlight! link typescriptMethodAccessor Red
highlight! link typescriptVariable Red
highlight! link typescriptVariableDeclaration Fg
highlight! link typescriptTypeReference BlueItalic
highlight! link typescriptBraces Fg
highlight! link typescriptEnumKeyword Red
highlight! link typescriptEnum BlueItalic
highlight! link typescriptIdentifierName Fg
highlight! link typescriptProp Fg
highlight! link typescriptCall Fg
highlight! link typescriptInterfaceName BlueItalic
highlight! link typescriptEndColons Fg
highlight! link typescriptMember Fg
highlight! link typescriptMemberOptionality Red
highlight! link typescriptObjectLabel Fg
highlight! link typescriptDefaultParam Fg
highlight! link typescriptArrowFunc Red
highlight! link typescriptAbstract Red
highlight! link typescriptObjectColon Grey
highlight! link typescriptTypeAnnotation Grey
highlight! link typescriptAssign Red
highlight! link typescriptBinaryOp Red
highlight! link typescriptUnaryOp Red
highlight! link typescriptFuncComma Fg
highlight! link typescriptClassName BlueItalic
highlight! link typescriptClassHeritage BlueItalic
highlight! link typescriptInterfaceHeritage BlueItalic
highlight! link typescriptIdentifier OrangeItalic
highlight! link typescriptGlobal BlueItalic
highlight! link typescriptOperator Red
highlight! link typescriptNodeGlobal BlueItalic
highlight! link typescriptExport Red
highlight! link typescriptImport Red
highlight! link typescriptTypeParameter BlueItalic
highlight! link typescriptReadonlyModifier Red
highlight! link typescriptAccessibilityModifier Red
highlight! link typescriptAmbientDeclaration Red
highlight! link typescriptTemplateSubstitution Green
highlight! link typescriptTemplateSB Green
highlight! link typescriptExceptions Red
highlight! link typescriptCastKeyword Red
highlight! link typescriptOptionalMark Red
highlight! link typescriptNull OrangeItalic
highlight! link typescriptMappedIn Red
highlight! link typescriptFuncTypeArrow Red
highlight! link typescriptTernaryOp Red
highlight! link typescriptParenExp Fg
highlight! link typescriptIndexExpr Fg
highlight! link typescriptDotNotation Grey
highlight! link typescriptGlobalNumberDot Grey
highlight! link typescriptGlobalStringDot Grey
highlight! link typescriptGlobalArrayDot Grey
highlight! link typescriptGlobalObjectDot Grey
highlight! link typescriptGlobalSymbolDot Grey
highlight! link typescriptGlobalMathDot Grey
highlight! link typescriptGlobalDateDot Grey
highlight! link typescriptGlobalJSONDot Grey
highlight! link typescriptGlobalRegExpDot Grey
highlight! link typescriptGlobalPromiseDot Grey
highlight! link typescriptGlobalURLDot Grey
highlight! link typescriptGlobalMethod Purple
highlight! link typescriptDOMStorageMethod Purple
highlight! link typescriptFileMethod Purple
highlight! link typescriptFileReaderMethod Purple
highlight! link typescriptFileListMethod Purple
highlight! link typescriptBlobMethod Purple
highlight! link typescriptURLStaticMethod Purple
highlight! link typescriptNumberStaticMethod Purple
highlight! link typescriptNumberMethod Purple
highlight! link typescriptDOMNodeMethod Purple
highlight! link typescriptPaymentMethod Purple
highlight! link typescriptPaymentResponseMethod Purple
highlight! link typescriptHeadersMethod Purple
highlight! link typescriptRequestMethod Purple
highlight! link typescriptResponseMethod Purple
highlight! link typescriptES6SetMethod Purple
highlight! link typescriptReflectMethod Purple
highlight! link typescriptBOMWindowMethod Purple
highlight! link typescriptGeolocationMethod Purple
highlight! link typescriptServiceWorkerMethod Purple
highlight! link typescriptCacheMethod Purple
highlight! link typescriptES6MapMethod Purple
highlight! link typescriptFunctionMethod Purple
highlight! link typescriptRegExpMethod Purple
highlight! link typescriptXHRMethod Purple
highlight! link typescriptBOMNavigatorMethod Purple
highlight! link typescriptServiceWorkerMethod Purple
highlight! link typescriptIntlMethod Purple
highlight! link typescriptDOMEventTargetMethod Purple
highlight! link typescriptDOMEventMethod Purple
highlight! link typescriptDOMDocMethod Purple
highlight! link typescriptStringStaticMethod Purple
highlight! link typescriptStringMethod Purple
highlight! link typescriptSymbolStaticMethod Purple
highlight! link typescriptObjectStaticMethod Purple
highlight! link typescriptObjectMethod Purple
highlight! link typescriptJSONStaticMethod Purple
highlight! link typescriptEncodingMethod Purple
highlight! link typescriptBOMLocationMethod Purple
highlight! link typescriptPromiseStaticMethod Purple
highlight! link typescriptPromiseMethod Purple
highlight! link typescriptSubtleCryptoMethod Purple
highlight! link typescriptCryptoMethod Purple
highlight! link typescriptBOMHistoryMethod Purple
highlight! link typescriptDOMFormMethod Purple
highlight! link typescriptConsoleMethod Purple
highlight! link typescriptDateStaticMethod Purple
highlight! link typescriptDateMethod Purple
highlight! link typescriptArrayStaticMethod Purple
highlight! link typescriptArrayMethod Purple
highlight! link typescriptMathStaticMethod Purple
highlight! link typescriptStringProperty Fg
highlight! link typescriptDOMStorageProp Fg
highlight! link typescriptFileReaderProp Fg
highlight! link typescriptURLUtilsProp Fg
highlight! link typescriptNumberStaticProp Fg
highlight! link typescriptDOMNodeProp Fg
highlight! link typescriptBOMWindowProp Fg
highlight! link typescriptRequestProp Fg
highlight! link typescriptResponseProp Fg
highlight! link typescriptPaymentProp Fg
highlight! link typescriptPaymentResponseProp Fg
highlight! link typescriptPaymentAddressProp Fg
highlight! link typescriptPaymentShippingOptionProp Fg
highlight! link typescriptES6SetProp Fg
highlight! link typescriptServiceWorkerProp Fg
highlight! link typescriptES6MapProp Fg
highlight! link typescriptRegExpStaticProp Fg
highlight! link typescriptRegExpProp Fg
highlight! link typescriptBOMNavigatorProp Green
highlight! link typescriptXHRProp Fg
highlight! link typescriptDOMEventProp Fg
highlight! link typescriptDOMDocProp Fg
highlight! link typescriptBOMNetworkProp Fg
highlight! link typescriptSymbolStaticProp Fg
highlight! link typescriptEncodingProp Fg
highlight! link typescriptBOMLocationProp Fg
highlight! link typescriptCryptoProp Fg
highlight! link typescriptDOMFormProp Fg
highlight! link typescriptBOMHistoryProp Fg
highlight! link typescriptMathStaticProp Fg
" }}}
" syn_end }}}
" syn_begin: dart {{{
" dart-lang: https://github.com/dart-lang/dart-vim-plugin{{{
highlight! link dartCoreClasses BlueItalic
highlight! link dartTypeName BlueItalic
highlight! link dartInterpolation Purple
highlight! link dartTypeDef Red
highlight! link dartClassDecl Red
highlight! link dartLibrary Red
highlight! link dartMetadata OrangeItalic
" }}}
" syn_end }}}
" syn_begin: c/cpp/objc/objcpp {{{
" vim-cpp-enhanced-highlight: https://github.com/octol/vim-cpp-enhanced-highlight{{{
highlight! link cLabel Red
highlight! link cppSTLnamespace BlueItalic
highlight! link cppSTLtype BlueItalic
highlight! link cppAccess Red
highlight! link cppStructure Red
highlight! link cppSTLios BlueItalic
highlight! link cppSTLiterator BlueItalic
highlight! link cppSTLexception Red
" }}}
" vim-cpp-modern: https://github.com/bfrg/vim-cpp-modern{{{
highlight! link cppSTLVariable BlueItalic
" }}}
" chromatica: https://github.com/arakashic/chromatica.nvim{{{
highlight! link Member TSVariable
highlight! link Variable TSVariable
highlight! link Namespace TSNamespace
highlight! link EnumConstant TSNumber
highlight! link chromaticaException TSException
highlight! link chromaticaCast TSLabel
highlight! link OperatorOverload TSOperator
highlight! link AccessQual TSOperator
highlight! link Linkage TSOperator
highlight! link AutoType TSType
" }}}
" vim-lsp-cxx-highlight https://github.com/jackguo380/vim-lsp-cxx-highlight{{{
highlight! link LspCxxHlSkippedRegion Grey
highlight! link LspCxxHlSkippedRegionBeginEnd TSKeyword
highlight! link LspCxxHlGroupEnumConstant TSStructure
highlight! link LspCxxHlGroupNamespace TSNamespace
highlight! link LspCxxHlGroupMemberVariable TSVariable
" }}}
" syn_end }}}
" syn_begin: objc {{{
" builtin: {{{
highlight! link objcModuleImport Red
highlight! link objcException Red
highlight! link objcProtocolList Fg
highlight! link objcDirective Red
highlight! link objcPropertyAttribute Purple
highlight! link objcHiddenArgument Fg
" }}}
" syn_end }}}
" syn_begin: cs {{{
" builtin: https://github.com/nickspoons/vim-cs{{{
highlight! link csUnspecifiedStatement Red
highlight! link csStorage Red
highlight! link csClass Red
highlight! link csNewType BlueItalic
highlight! link csContextualStatement Red
highlight! link csInterpolationDelimiter Purple
highlight! link csInterpolation Purple
highlight! link csEndColon Fg
" }}}
" syn_end }}}
" syn_begin: python {{{
" builtin: {{{
highlight! link pythonBuiltin BlueItalic
highlight! link pythonExceptions Red
highlight! link pythonDecoratorName OrangeItalic
" }}}
" python-syntax: https://github.com/vim-python/python-syntax{{{
highlight! link pythonExClass BlueItalic
highlight! link pythonBuiltinType BlueItalic
highlight! link pythonBuiltinObj OrangeItalic
highlight! link pythonDottedName OrangeItalic
highlight! link pythonBuiltinFunc Purple
highlight! link pythonFunction Purple
highlight! link pythonDecorator OrangeItalic
highlight! link pythonInclude Include
highlight! link pythonImport PreProc
highlight! link pythonOperator Red
highlight! link pythonConditional Red
highlight! link pythonRepeat Red
highlight! link pythonException Red
highlight! link pythonNone OrangeItalic
highlight! link pythonCoding Grey
highlight! link pythonDot Grey
" }}}
" semshi: https://github.com/numirias/semshi{{{
call amora#highlight('semshiUnresolved', s:palette.orange, s:palette.none, 'undercurl')
highlight! link semshiImported TSInclude
highlight! link semshiParameter TSParameter
highlight! link semshiParameterUnused Grey
highlight! link semshiSelf TSVariableBuiltin
highlight! link semshiGlobal TSType
highlight! link semshiBuiltin TSTypeBuiltin
highlight! link semshiAttribute TSAttribute
highlight! link semshiLocal TSKeyword
highlight! link semshiFree TSKeyword
highlight! link semshiSelected CurrentWord
highlight! link semshiErrorSign RedSign
highlight! link semshiErrorChar RedSign
" }}}
" syn_end }}}
" syn_begin: lua {{{
" builtin: {{{
highlight! link luaFunc Purple
highlight! link luaFunction Red
highlight! link luaTable Fg
highlight! link luaIn Red
" }}}
" vim-lua: https://github.com/tbastos/vim-lua{{{
highlight! link luaFuncCall Red
highlight! link luaLocal Green
highlight! link luaSpecialValue Yellow
highlight! link luaBraces Fg
highlight! link luaBuiltIn BlueItalic
highlight! link luaNoise Grey
highlight! link luaLabel Green
highlight! link luaFuncTable BlueItalic
highlight! link luaFuncArgName Fg
highlight! link luaEllipsis Red
highlight! link luaDocTag Purple
" }}}
" syn_end }}}
" syn_begin: java {{{
" builtin: {{{
highlight! link javaClassDecl Red
highlight! link javaMethodDecl Red
highlight! link javaVarArg Fg
highlight! link javaAnnotation Purple
highlight! link javaUserLabel Purple
highlight! link javaTypedef OrangeItalic
highlight! link javaParen Fg
highlight! link javaParen1 Fg
highlight! link javaParen2 Fg
highlight! link javaParen3 Fg
highlight! link javaParen4 Fg
highlight! link javaParen5 Fg
" }}}
" syn_end }}}
" syn_begin: kotlin {{{
" kotlin-vim: https://github.com/udalov/kotlin-vim{{{
highlight! link ktSimpleInterpolation Purple
highlight! link ktComplexInterpolation Purple
highlight! link ktComplexInterpolationBrace Purple
highlight! link ktStructure Red
highlight! link ktKeyword OrangeItalic
" }}}
" syn_end }}}
" syn_begin: scala {{{
" builtin: https://github.com/derekwyatt/vim-scala{{{
highlight! link scalaNameDefinition Fg
highlight! link scalaInterpolationBoundary Purple
highlight! link scalaInterpolation Purple
highlight! link scalaTypeOperator Red
highlight! link scalaOperator Red
highlight! link scalaKeywordModifier Red
" }}}
" syn_end }}}
" syn_begin: go {{{
" builtin: https://github.com/google/vim-ft-go{{{
highlight! link goDirective Red
highlight! link goConstants OrangeItalic
highlight! link goDeclType Red
" }}}
" polyglot: {{{
highlight! link goPackage Red
highlight! link goImport Red
highlight! link goBuiltins Purple
highlight! link goPredefinedIdentifiers OrangeItalic
highlight! link goVar Red
" }}}
" syn_end }}}
" syn_begin: rust {{{
" builtin: https://github.com/rust-lang/rust.vim{{{
highlight! link rustStructure Green
highlight! link rustIdentifier OrangeItalic
highlight! link rustModPath BlueItalic
highlight! link rustModPathSep Grey
highlight! link rustSelf OrangeItalic
highlight! link rustSuper OrangeItalic
highlight! link rustDeriveTrait Purple
highlight! link rustEnumVariant Purple
highlight! link rustMacroVariable OrangeItalic
highlight! link rustAssert Red
highlight! link rustPanic Red
highlight! link rustPubScopeCrate BlueItalic
highlight! link rustAttribute Purple
" }}}
" coc-rust-analyzer: https://github.com/fannheyward/coc-rust-analyzer {{{
highlight! link CocRustChainingHint Grey
highlight! link CocRustTypeHint Grey
" }}}
" syn_end }}}
" syn_begin: swift {{{
" swift.vim: https://github.com/keith/swift.vim{{{
highlight! link swiftInterpolatedWrapper Purple
highlight! link swiftInterpolatedString Purple
highlight! link swiftProperty Fg
highlight! link swiftTypeDeclaration Red
highlight! link swiftClosureArgument OrangeItalic
highlight! link swiftStructure Red
" }}}
" syn_end }}}
" syn_begin: php {{{
" builtin: https://jasonwoof.com/gitweb/?p=vim-syntax.git;a=blob;f=php.vim;hb=HEAD{{{
highlight! link phpVarSelector Fg
highlight! link phpIdentifier Fg
highlight! link phpDefine Red
highlight! link phpStructure Green
highlight! link phpSpecialFunction Red
highlight! link phpInterpSimpleCurly Purple
highlight! link phpComparison Green
highlight! link phpMethodsVar Fg
highlight! link phpInterpVarname Fg
highlight! link phpMemberSelector Green
highlight! link phpLabel Green
" }}}
" php.vim: https://github.com/StanAngeloff/php.vim{{{
highlight! link phpParent Fg
highlight! link phpNowDoc Yellow
highlight! link phpFunction Purple
highlight! link phpMethod Purple
highlight! link phpClass BlueItalic
highlight! link phpSuperglobals BlueItalic
highlight! link phpNullValue OrangeItalic
" }}}
" syn_end }}}
" syn_begin: ruby {{{
" builtin: https://github.com/vim-ruby/vim-ruby{{{
highlight! link rubyKeywordAsMethod Green
highlight! link rubyInterpolation Purple
highlight! link rubyInterpolationDelimiter Purple
highlight! link rubyStringDelimiter Yellow
highlight! link rubyBlockParameterList Fg
highlight! link rubyDefine Red
highlight! link rubyModuleName Red
highlight! link rubyAccess Red
highlight! link rubyMacro Red
highlight! link rubySymbol Fg
" }}}
" syn_end }}}
" syn_begin: haskell {{{
" haskell-vim: https://github.com/neovimhaskell/haskell-vim{{{
highlight! link haskellBrackets Fg
highlight! link haskellIdentifier OrangeItalic
highlight! link haskellDecl Red
highlight! link haskellType BlueItalic
highlight! link haskellDeclKeyword Red
highlight! link haskellWhere Red
highlight! link haskellDeriving Red
highlight! link haskellForeignKeywords Red
" }}}
" syn_end }}}
" syn_begin: perl/pod {{{
" builtin: https://github.com/vim-perl/vim-perl{{{
highlight! link perlStatementPackage Red
highlight! link perlStatementInclude Red
highlight! link perlStatementStorage Red
highlight! link perlStatementList Red
highlight! link perlMatchStartEnd Red
highlight! link perlVarSimpleMemberName Purple
highlight! link perlVarSimpleMember Fg
highlight! link perlMethod Purple
highlight! link podVerbatimLine Purple
highlight! link podCmdText Yellow
highlight! link perlVarPlain Fg
highlight! link perlVarPlain2 Fg
" }}}
" syn_end }}}
" syn_begin: ocaml {{{
" builtin: https://github.com/rgrinberg/vim-ocaml{{{
highlight! link ocamlArrow Red
highlight! link ocamlEqual Red
highlight! link ocamlOperator Red
highlight! link ocamlKeyChar Red
highlight! link ocamlModPath Purple
highlight! link ocamlFullMod Purple
highlight! link ocamlModule BlueItalic
highlight! link ocamlConstructor Orange
highlight! link ocamlModParam Fg
highlight! link ocamlModParam1 Fg
highlight! link ocamlAnyVar Fg " aqua
highlight! link ocamlPpxEncl Red
highlight! link ocamlPpxIdentifier Fg
highlight! link ocamlSigEncl Red
highlight! link ocamlModParam1 Fg
" }}}
" syn_end }}}
" syn_begin: erlang {{{
" builtin: https://github.com/vim-erlang/vim-erlang-runtime{{{
highlight! link erlangAtom Fg
highlight! link erlangVariable Fg
highlight! link erlangLocalFuncRef Purple
highlight! link erlangLocalFuncCall Purple
highlight! link erlangGlobalFuncRef Purple
highlight! link erlangGlobalFuncCall Purple
highlight! link erlangAttribute BlueItalic
highlight! link erlangPipe Red
" }}}
" syn_end }}}
" syn_begin: elixir {{{
" vim-elixir: https://github.com/elixir-editors/vim-elixir{{{
highlight! link elixirStringDelimiter Yellow
highlight! link elixirKeyword Red
highlight! link elixirInterpolation Purple
highlight! link elixirInterpolationDelimiter Purple
highlight! link elixirSelf BlueItalic
highlight! link elixirPseudoVariable OrangeItalic
highlight! link elixirModuleDefine Red
highlight! link elixirBlockDefinition Red
highlight! link elixirDefine Red
highlight! link elixirPrivateDefine Red
highlight! link elixirGuard Red
highlight! link elixirPrivateGuard Red
highlight! link elixirProtocolDefine Red
highlight! link elixirImplDefine Red
highlight! link elixirRecordDefine Red
highlight! link elixirPrivateRecordDefine Red
highlight! link elixirMacroDefine Red
highlight! link elixirPrivateMacroDefine Red
highlight! link elixirDelegateDefine Red
highlight! link elixirOverridableDefine Red
highlight! link elixirExceptionDefine Red
highlight! link elixirCallbackDefine Red
highlight! link elixirStructDefine Red
highlight! link elixirExUnitMacro Red
" }}}
" syn_end }}}
" syn_begin: lisp {{{
" builtin: http://www.drchip.org/astronaut/vim/index.html#SYNTAX_LISP{{{
highlight! link lispAtomMark Purple
highlight! link lispKey Orange
highlight! link lispFunc Red
" }}}
" syn_end }}}
" syn_begin: clojure {{{
" builtin: https://github.com/guns/vim-clojure-static{{{
highlight! link clojureMacro Green
highlight! link clojureFunc Red
highlight! link clojureConstant OrangeItalic
highlight! link clojureSpecial Red
highlight! link clojureDefine Red
highlight! link clojureKeyword Blue
highlight! link clojureVariable Fg
highlight! link clojureMeta Purple
highlight! link clojureDeref Purple
" }}}
" syn_end }}}
" syn_begin: matlab {{{
" builtin: {{{
highlight! link matlabSemicolon Fg
highlight! link matlabFunction RedItalic
highlight! link matlabImplicit Purple
highlight! link matlabDelimiter Fg
highlight! link matlabOperator Purple
highlight! link matlabArithmeticOperator Red
highlight! link matlabArithmeticOperator Red
highlight! link matlabRelationalOperator Red
highlight! link matlabRelationalOperator Red
highlight! link matlabLogicalOperator Red
" }}}
" syn_end }}}
" syn_begin: octave {{{
" vim-octave: https://github.com/McSinyx/vim-octave{{{
highlight! link octaveDelimiter Orange
highlight! link octaveSemicolon Grey
highlight! link octaveOperator Orange
highlight! link octaveVariable BlueItalic
highlight! link octaveVarKeyword BlueItalic
" }}}
" syn_end }}}
" syn_begin: sh/zsh {{{
" builtin: http://www.drchip.org/astronaut/vim/index.html#SYNTAX_SH{{{
highlight! link shRange Fg
highlight! link shOption Green
highlight! link shQuote Yellow
highlight! link shVariable BlueItalic
highlight! link shDerefSimple BlueItalic
highlight! link shDerefVar BlueItalic
highlight! link shDerefSpecial BlueItalic
highlight! link shDerefOff BlueItalic
highlight! link shVarAssign Red
highlight! link shFunctionOne Purple
highlight! link shFunctionKey Red
" }}}
" syn_end }}}
" syn_begin: zsh {{{
" builtin: https://github.com/chrisbra/vim-zsh{{{
highlight! link zshOption BlueItalic
highlight! link zshSubst Orange
highlight! link zshFunction Red
" }}}
" syn_end }}}
" syn_begin: ps1 {{{
" vim-ps1: https://github.com/PProvost/vim-ps1{{{
highlight! link ps1FunctionInvocation Red
highlight! link ps1FunctionDeclaration Red
highlight! link ps1InterpolationDelimiter Purple
highlight! link ps1BuiltIn BlueItalic
" }}}
" syn_end }}}
" syn_begin: vim {{{
call amora#highlight('vimCommentTitle', s:palette.grey, s:palette.none, 'bold')
highlight! link vimLet Green
highlight! link vimFunction Red
highlight! link vimIsCommand Fg
highlight! link vimUserFunc Red
highlight! link vimFuncName Red
highlight! link vimMap BlueItalic
highlight! link vimNotation Purple
highlight! link vimMapLhs Red
highlight! link vimMapRhs Red
highlight! link vimSetEqual BlueItalic
highlight! link vimSetSep Fg
highlight! link vimOption BlueItalic
highlight! link vimUserAttrbKey BlueItalic
highlight! link vimUserAttrb Red
highlight! link vimAutoCmdSfxList Orange
highlight! link vimSynType Orange
highlight! link vimHiBang Orange
highlight! link vimSet BlueItalic
highlight! link vimSetSep Grey
" syn_end }}}
" syn_begin: make {{{
highlight! link makeIdent Purple
highlight! link makeSpecTarget BlueItalic
highlight! link makeTarget Orange
highlight! link makeCommands Red
" syn_end }}}
" syn_begin: cmake {{{
highlight! link cmakeCommand Red
highlight! link cmakeKWconfigure_package_config_file BlueItalic
highlight! link cmakeKWwrite_basic_package_version_file BlueItalic
highlight! link cmakeKWExternalProject Purple
highlight! link cmakeKWadd_compile_definitions Purple
highlight! link cmakeKWadd_compile_options Purple
highlight! link cmakeKWadd_custom_command Purple
highlight! link cmakeKWadd_custom_target Purple
highlight! link cmakeKWadd_definitions Purple
highlight! link cmakeKWadd_dependencies Purple
highlight! link cmakeKWadd_executable Purple
highlight! link cmakeKWadd_library Purple
highlight! link cmakeKWadd_link_options Purple
highlight! link cmakeKWadd_subdirectory Purple
highlight! link cmakeKWadd_test Purple
highlight! link cmakeKWbuild_command Purple
highlight! link cmakeKWcmake_host_system_information Purple
highlight! link cmakeKWcmake_minimum_required Purple
highlight! link cmakeKWcmake_parse_arguments Purple
highlight! link cmakeKWcmake_policy Purple
highlight! link cmakeKWconfigure_file Purple
highlight! link cmakeKWcreate_test_sourcelist Purple
highlight! link cmakeKWctest_build Purple
highlight! link cmakeKWctest_configure Purple
highlight! link cmakeKWctest_coverage Purple
highlight! link cmakeKWctest_memcheck Purple
highlight! link cmakeKWctest_run_script Purple
highlight! link cmakeKWctest_start Purple
highlight! link cmakeKWctest_submit Purple
highlight! link cmakeKWctest_test Purple
highlight! link cmakeKWctest_update Purple
highlight! link cmakeKWctest_upload Purple
highlight! link cmakeKWdefine_property Purple
highlight! link cmakeKWdoxygen_add_docs Purple
highlight! link cmakeKWenable_language Purple
highlight! link cmakeKWenable_testing Purple
highlight! link cmakeKWexec_program Purple
highlight! link cmakeKWexecute_process Purple
highlight! link cmakeKWexport Purple
highlight! link cmakeKWexport_library_dependencies Purple
highlight! link cmakeKWfile Purple
highlight! link cmakeKWfind_file Purple
highlight! link cmakeKWfind_library Purple
highlight! link cmakeKWfind_package Purple
highlight! link cmakeKWfind_path Purple
highlight! link cmakeKWfind_program Purple
highlight! link cmakeKWfltk_wrap_ui Purple
highlight! link cmakeKWforeach Purple
highlight! link cmakeKWfunction Purple
highlight! link cmakeKWget_cmake_property Purple
highlight! link cmakeKWget_directory_property Purple
highlight! link cmakeKWget_filename_component Purple
highlight! link cmakeKWget_property Purple
highlight! link cmakeKWget_source_file_property Purple
highlight! link cmakeKWget_target_property Purple
highlight! link cmakeKWget_test_property Purple
highlight! link cmakeKWif Purple
highlight! link cmakeKWinclude Purple
highlight! link cmakeKWinclude_directories Purple
highlight! link cmakeKWinclude_external_msproject Purple
highlight! link cmakeKWinclude_guard Purple
highlight! link cmakeKWinstall Purple
highlight! link cmakeKWinstall_files Purple
highlight! link cmakeKWinstall_programs Purple
highlight! link cmakeKWinstall_targets Purple
highlight! link cmakeKWlink_directories Purple
highlight! link cmakeKWlist Purple
highlight! link cmakeKWload_cache Purple
highlight! link cmakeKWload_command Purple
highlight! link cmakeKWmacro Purple
highlight! link cmakeKWmark_as_advanced Purple
highlight! link cmakeKWmath Purple
highlight! link cmakeKWmessage Purple
highlight! link cmakeKWoption Purple
highlight! link cmakeKWproject Purple
highlight! link cmakeKWqt_wrap_cpp Purple
highlight! link cmakeKWqt_wrap_ui Purple
highlight! link cmakeKWremove Purple
highlight! link cmakeKWseparate_arguments Purple
highlight! link cmakeKWset Purple
highlight! link cmakeKWset_directory_properties Purple
highlight! link cmakeKWset_property Purple
highlight! link cmakeKWset_source_files_properties Purple
highlight! link cmakeKWset_target_properties Purple
highlight! link cmakeKWset_tests_properties Purple
highlight! link cmakeKWsource_group Purple
highlight! link cmakeKWstring Purple
highlight! link cmakeKWsubdirs Purple
highlight! link cmakeKWtarget_compile_definitions Purple
highlight! link cmakeKWtarget_compile_features Purple
highlight! link cmakeKWtarget_compile_options Purple
highlight! link cmakeKWtarget_include_directories Purple
highlight! link cmakeKWtarget_link_directories Purple
highlight! link cmakeKWtarget_link_libraries Purple
highlight! link cmakeKWtarget_link_options Purple
highlight! link cmakeKWtarget_precompile_headers Purple
highlight! link cmakeKWtarget_sources Purple
highlight! link cmakeKWtry_compile Purple
highlight! link cmakeKWtry_run Purple
highlight! link cmakeKWunset Purple
highlight! link cmakeKWuse_mangled_mesa Purple
highlight! link cmakeKWvariable_requires Purple
highlight! link cmakeKWvariable_watch Purple
highlight! link cmakeKWwrite_file Purple
" syn_end }}}
" syn_begin: json {{{
highlight! link jsonKeyword Red
highlight! link jsonString Green
highlight! link jsonBoolean Blue
highlight! link jsonNoise Grey
highlight! link jsonQuote Grey
highlight! link jsonBraces Fg
" syn_end }}}
" syn_begin: yaml {{{
highlight! link yamlKey Red
highlight! link yamlConstant BlueItalic
highlight! link yamlString Green
" syn_end }}}
" syn_begin: toml {{{
call amora#highlight('tomlTable', s:palette.purple, s:palette.none, 'bold')
highlight! link tomlKey Red
highlight! link tomlBoolean Blue
highlight! link tomlString Green
highlight! link tomlTableArray tomlTable
" syn_end }}}
" syn_begin: gitcommit {{{
highlight! link gitcommitSummary Red
highlight! link gitcommitUntracked Grey
highlight! link gitcommitDiscarded Grey
highlight! link gitcommitSelected Grey
highlight! link gitcommitUnmerged Grey
highlight! link gitcommitOnBranch Grey
highlight! link gitcommitArrow Grey
highlight! link gitcommitFile Purple
" syn_end }}}
" syn_begin: dosini {{{
call amora#highlight('dosiniHeader', s:palette.red, s:palette.none, 'bold')
highlight! link dosiniLabel Blue
highlight! link dosiniValue Red
highlight! link dosiniNumber Red
" syn_end }}}
" syn_begin: help {{{
call amora#highlight('helpNote', s:palette.purple, s:palette.none, 'bold')
call amora#highlight('helpHeadline', s:palette.red, s:palette.none, 'bold')
call amora#highlight('helpHeader', s:palette.orange, s:palette.none, 'bold')
call amora#highlight('helpURL', s:palette.green, s:palette.none, 'underline')
call amora#highlight('helpHyperTextEntry', s:palette.blue, s:palette.none, 'bold')
highlight! link helpHyperTextJump Blue
highlight! link helpCommand Yellow
highlight! link helpExample Red
highlight! link helpSpecial Purple
highlight! link helpSectionDelim Grey
" syn_end }}}
" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
