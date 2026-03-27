--# selene: allow(undefined_variable)
---@diagnostic disable: undefined-global
local lush = require("lush")
local p = require("lush_theme.lavi.palette")

local theme = lush(function(injected_functions)
  local sym = injected_functions.sym
  return {
    -- stylua: ignore start
    ---- General highlight groups
    Normal           { fg = p.dark_fg, bg = p.dark_bg.lighten(1).saturate(1) }, -- Normal text
    NormalNC         { fg = p.dark_fg, bg = p.dark_bg_dark.darken(10) }, -- normal text in non-current windows
    NormalFloat      { fg = p.dark_fg, bg = p.dark_bg }, -- Normal text in floating windows.
    NormalFloatNC    { fg = p.dark_fg, bg = p.dark_bg_dark }, -- Normal text in non-current floating windows.
    ColorColumn      { bg = p.black }, -- Columns set with 'colorcolumn'
    Conceal          { fg = p.green, bg = p.dark_bg_med }, -- Placeholder characters substituted for concealed text (see 'conceallevel')
    Cursor           { bg = p.dark_fg, fg = p.dark_bg }, -- Character under the cursor
    -- lCursor          { }, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
    -- CursorIM         { }, -- Like Cursor, but used when in IME mode |CursorIM|
    CursorColumn     { bg = p.black }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorLine       { bg = p.dark_bg_med }, -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
    CursorLineNC     { bg = p.dark_bg.lighten(6) }, -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
    Directory        { fg = p.bright_violet.lighten(50).desaturate(10) }, -- Directory names (and other special names in listings)

    EndOfBuffer      { fg = p.black }, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
    -- TermCursor       { }, -- Cursor in a focused terminal
    TermCursorNC     { bg = p.black }, -- Cursor in an unfocused terminal
    ErrorMsg         { fg = p.bright_white, bg = p.bright_red }, -- Error messages on the command line
    WinSeparator     { fg = p.med_black }, -- Column separating vertically split windows
    VertSplit        { WinSeparator },
    Folded           { fg = p.bright_black, bg = p.black, gui = 'bold' }, -- Line used for closed folds
    FoldColumn       { fg = p.bright_black }, -- 'foldcolumn'
    SignColumn       { fg = p.black }, -- Column where |signs| are displayed
    IncSearch        { fg = p.bright_white, bg = p.violet, gui = 'underline' }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    -- Substitute       { }, -- |:substitute| replacement text highlighting
    LineNr           { fg = p.bright_black }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    -- LineNrAbove      { }, -- Line number for when the 'relativenumber' option is set, above the cursor line
    -- LineNrBelow      { }, -- Line number for when the 'relativenumber' option is set, below the cursor line
    CursorLineNr     { fg = p.dark_fg }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    CursorLineNrNC   { fg = p.dark_fg }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line in non-current windows.
    -- CursorLineFold   { }, -- Like FoldColumn when 'cursorline' is set for the cursor line
    -- CursorLineSign   { }, -- Like SignColumn when 'cursorline' is set for the cursor line
    MatchParen       { bg = p.cyan, fg = p.black }, -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    ModeMsg          { fg = p.dark_fg }, -- 'showmode' message (e.g., "-- INSERT -- ")
    -- MsgArea          { }, -- Area for messages and cmdline
    -- MsgSeparator     { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    MoreMsg          { fg = p.dark_fg }, -- |more-prompt|
    NonText          { fg = p.med_black }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    FloatBorder      { fg = p.med_black }, -- Border of floating windows.
    -- FloatTitle       { }, -- Title of floating windows.
    Pmenu            { fg = p.dark_fg, bg = p.dark_bg.lighten(30) }, -- Popup menu: Normal item.
    PmenuSel         { fg = p.cyan, bg = p.bright_black }, -- Popup menu: Selected item.
    -- PmenuKind        { }, -- Popup menu: Normal item "kind"
    -- PmenuKindSel     { }, -- Popup menu: Selected item "kind"
    -- PmenuExtra       { }, -- Popup menu: Normal item "extra text"
    -- PmenuExtraSel    { }, -- Popup menu: Selected item "extra text"
    PmenuSbar        { fg = p.dark_fg, bg = p.dark_bg.lighten(30) }, -- Popup menu: Scrollbar.
    PmenuThumb       { fg = p.violet.lighten(70).saturate(90), bg = p.dark_bg.lighten(50) }, -- Popup menu: Thumb of the scrollbar.
    Question         { fg = p.dark_fg }, -- |hit-enter| prompt and yes/no questions
    -- QuickFixLine     { }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    Search           { fg = p.blush }, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
    CurSearch        { bg = p.blush, fg = p.dark_bg }, -- Highlighting a search pattern under the cursor (see 'hlsearch').
    SpecialKey       { fg = p.bright_black }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
    SpellBad         { gui = 'undercurl' }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    SpellCap         { gui = 'undercurl' }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    SpellLocal       { gui = 'undercurl' }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    SpellRare        { gui = 'undercurl' }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
    StatusLine       { bg = p.dark_bg_dark, fg = p.med_black }, -- Status line of current window
    StatusLineNC     { StatusLine }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    StatusLineTerm   { StatusLine }, -- Status line of current window
    StatusLineTermNC { StatusLineNC }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    -- StatusLine       { fg = g.cyan, bg = p.black_bright }, -- Status line of current window
    -- StatusLineNC     { fg = g.fg, bg = p.black_bright }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    -- StatusLineTerm   { fg = g.cyan, bg = p.black_bright }, -- Status line of current window
    -- StatusLineTermNC { fg = g.fg, bg = p.black_bright }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    TabLine          { fg = p.dark_fg, bg = p.black }, -- Tab pages line, not active tab page label
    TabLineFill      { fg = p.dark_fg, bg = p.black }, -- Tab pages line, where there are no labels
    TabLineSel       { fg = p.cyan, bg = p.bright_black }, -- Tab pages line, active tab page label
    Title            { fg = p.dark_fg }, -- Titles for output from ":set all", ":autocmd" etc.
    Visual           { bg = p.selection_bg }, -- Visual mode selection
    VisualNOS        { bg = p.med_black }, -- Visual mode selection when vim is "Not Owning the Selection".
    WarningMsg       { fg = p.black, bg = p.yellow }, -- Warning messages
    -- Whitespace       { }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    -- Winseparator     { }, -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
    WildMenu         { fg = p.cyan, bg = p.black }, -- Current match in 'wildmenu' completion
    WinBar           { StatusLine }, -- Window bar of current window
    WinBarNC         { StatusLineNC }, -- Window bar of not-current windows

    LocListNormal       { fg = p.dark_fg, bg = p.dark_bg.lighten(5).saturate(10).rotate(-20) }, -- Location list
    LocListNormalNC     { fg = p.dark_fg, bg = p.dark_bg.saturate(5).rotate(-20) }, -- Location list (non-current window)
    LocListCursorLine   { bg = p.dark_bg.lighten(20).saturate(10).rotate(-20) }, -- Location list cursor line
    LocListCursorLineNC { bg = p.dark_bg.saturate(15).rotate(-20) }, -- Location list cursor line (non-current window)

    QFListNormal       { Normal }, -- Quickfix list
    QFListNormalNC     { NormalNC }, -- Quickfix list (non-current window)
    -- QFListNormal       { fg = p.dark_fg, bg = p.dark_bg.lighten(5).saturate(10).rotate(20) }, -- Quickfix list
    -- QFListNormalNC     { fg = p.dark_fg, bg = p.dark_bg.saturate(5).rotate(20) }, -- Quickfix list (non-current window)
    QFListCursorLine   { bg = p.dark_bg.lighten(20).saturate(10).rotate(20) }, -- Quickfix list cursor line
    QFListCursorLineNC { bg = p.dark_bg.saturate(15).rotate(20) }, -- Quickfix list cursor line (non-current window)

    DiffAdd          { bg = p.bg.mix(p.green, 15).saturate(5) }, -- Diff mode: Added line |diff.txt|
    DiffChange       { bg = p.bg.mix(p.skyblue, 10) }, -- Diff mode: Changed line |diff.txt|
    DiffDelete       { fg = p.med_black }, -- Diff mode: Deleted line |diff.txt|
    DiffText         { bg = p.bg.mix(p.blue, 20) }, -- Diff mode: Changed text within a changed line |diff.txt|

    DiffAddBright     { fg = p.bright_green }, -- Diff mode: Added line |diff.txt|
    DiffChangeBright  { fg = p.bright_yellow  }, -- Diff mode: Changed line |diff.txt|
    DiffDeleteBright  { fg = p.bright_red.lighten(10)  }, -- Diff mode: Deleted line |diff.txt|
    DiffTextBright    { fg = p.oceanblue.lighten(10)  }, -- Diff mode: Changed text within a changed line |diff.txt|

    ---- Standard syntax highlighting
    -- Common vim syntax groups used for all kinds of code and markup.
    -- Commented-out groups should chain up to their preferred (*) group
    -- by default.
    --
    -- See :h group-name
    --
    -- Uncomment and edit if you want more specific syntax highlighting.

    Comment          { fg = p.anise_dark, gui = 'italic,bold' }, -- Any comment

    Constant         { fg = p.cyan }, -- (*) Any constant
    String           { fg = p.yellow.lighten(40).rotate(50).saturate(10) }, --   A string constant: "this is a string"
    Character        { String }, --   A character constant: 'c', '\n'
    Number           { fg = p.pumpkin }, --   A number constant: 234, 0xff
    Float            { Number }, --   A floating point constant: 2.3e10
    Boolean          { fg = p.cyan.lighten(30) }, --   A boolean constant: TRUE, false

    Identifier       { fg = p.anise.lighten(85).saturate(100) }, -- (*) Any variable name
    Function         { fg = p.cyan.desaturate(10).lighten(50) }, --   Function name (also: methods for classes)

    Statement        { fg = p.velvet.rotate(5).lighten(10) }, -- (*) Any statement
    Conditional      { Statement }, --   if, then, else, endif, switch, etc.
    Repeat           { Statement }, --   for, do, while, etc.
    Label            { Statement }, --   case, default, etc.
    Operator         { Statement }, --   "sizeof", "+", "*", etc.
    Keyword          { Statement }, --   any other keyword
    Exception        { Statement }, --   try, catch, throw

    PreProc          { Statement }, -- (*) Generic Preprocessor
    Include          { PreProc }, --   Preprocessor #include
    Define           { PreProc }, --   Preprocessor #define
    Macro            { PreProc }, --   Same as Define
    PreCondit        { PreProc }, --   Preprocessor #if, #else, #endif, etc.

    Type             {  fg = p.violet.rotate(-55) }, -- (*) int, long, char, etc.
    StorageClass     { Type }, --   static, register, volatile, etc.
    Structure        { Type }, --   struct, union, enum, etc.
    Typedef          { Type }, --   A typedef

    Special          { Identifier }, -- (*) Any special symbol
    SpecialChar      { fg = p.orange }, --   Special character in a constant
    Tag              { fg = p.dust }, --   You can use CTRL-] on this
    Delimiter        { fg = p.deep_velvet.lighten(40).saturate(30) }, --   Character that needs attention
    SpecialComment   { fg = p.dark_fg }, --   Special things inside a comment (e.g. '\n')
    -- Debug            { }, --   Debugging statements

    -- Underlined       { gui = "underline" }, -- Text that stands out, HTML links
    -- Ignore           { }, -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
    Error            { fg = p.dark_bg_bright, bg = p.bright_red }, -- Any erroneous construct
    Todo             { fg = p.yellow }, -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    ---- LSP
    -- These groups are for the native LSP client and diagnostic system. Some
    -- other LSP clients may use these groups, or use their own. Consult your
    -- LSP client's documentation.

    -- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
    --
    LspReferenceText            {  bg = p.dark_bg.lighten(20) } , -- Used for highlighting "text" references
    -- LspReferenceRead            { } , -- Used for highlighting "read" references
    -- LspReferenceWrite           { } , -- Used for highlighting "write" references
    -- LspCodeLens                 { } , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
    -- LspCodeLensSeparator        { } , -- Used to color the seperator between two or more code lens.
    LspSignatureActiveParameter { fg = p.anise.lighten(40).saturate(60) }, -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.
    LspInlayHint                { Comment }, -- Used for inline hint virtual text

    ---- Diagnostics
    -- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
    --
    -- DiagnosticError            { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticWarn             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticInfo             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticHint             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticOk               { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticVirtualTextError { } , -- Used for "Error" diagnostic virtual text.
    -- DiagnosticVirtualTextWarn  { } , -- Used for "Warn" diagnostic virtual text.
    -- DiagnosticVirtualTextInfo  { } , -- Used for "Info" diagnostic virtual text.
    -- DiagnosticVirtualTextHint  { } , -- Used for "Hint" diagnostic virtual text.
    -- DiagnosticVirtualTextOk    { } , -- Used for "Ok" diagnostic virtual text.
    -- DiagnosticUnderlineError   { } , -- Used to underline "Error" diagnostics.
    -- DiagnosticUnderlineWarn    { } , -- Used to underline "Warn" diagnostics.
    -- DiagnosticUnderlineInfo    { } , -- Used to underline "Info" diagnostics.
    -- DiagnosticUnderlineHint    { } , -- Used to underline "Hint" diagnostics.
    -- DiagnosticUnderlineOk      { } , -- Used to underline "Ok" diagnostics.
    -- DiagnosticFloatingError    { } , -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
    -- DiagnosticFloatingWarn     { } , -- Used to color "Warn" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingInfo     { } , -- Used to color "Info" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingHint     { } , -- Used to color "Hint" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingOk       { } , -- Used to color "Ok" diagnostic messages in diagnostics float.
    -- DiagnosticSignError        { } , -- Used for "Error" signs in sign column.
    -- DiagnosticSignWarn         { } , -- Used for "Warn" signs in sign column.
    -- DiagnosticSignInfo         { } , -- Used for "Info" signs in sign column.
    -- DiagnosticSignHint         { } , -- Used for "Hint" signs in sign column.
    -- DiagnosticSignOk           { } , -- Used for "Ok" signs in sign column.

    ---- Tree-Sitter syntax groups.
    --
    -- See :h treesitter-highlight-groups, some groups may not be listed,
    -- submit a PR fix to lush-template!
    --
    -- Tree-Sitter groups are defined with an "@" symbol, which must be
    -- specially handled to be valid lua code, we do this via the special
    -- sym function. The following are all valid ways to call the sym function,
    -- for more details see https://www.lua.org/pil/5.html
    --
    -- sym("@text.literal")
    -- sym('@text.literal')
    -- sym"@text.literal"
    -- sym'@text.literal'
    --
    -- For more information see https://github.com/rktjmp/lush.nvim/issues/109

    -- sym"@text.literal"      { }, -- Comment
    -- sym"@text.reference"    { }, -- Identifier
    -- sym"@text.title"        { }, -- Title
    -- sym"@text.uri"          { }, -- Underlined
    -- sym"@text.underline"    { }, -- Underlined
    -- sym"@text.todo"         { }, -- Todo
    sym"@text.diff.add"     { DiffAdd }, -- tree-sitter-diff Add
    sym"@text.diff.delete"  { DiffDelete }, -- tree-sitter-diff Delete
    -- sym"@comment"           { }, -- Comment
    -- sym"@punctuation"       { }, -- Delimiter
    -- sym"@constant"          { }, -- Constant
    -- sym"@constant.builtin"  { }, -- Special
    -- sym"@constant.macro"    { }, -- Define
    -- sym"@define"            { }, -- Define
    -- sym"@macro"             { }, -- Macro
    -- sym"@string"            { }, -- String
    -- sym"@string.escape"     { }, -- SpecialChar
    -- sym"@string.special"    { }, -- SpecialChar
    -- sym"@character"         { }, -- Character
    -- sym"@character.special" { }, -- SpecialChar
    -- sym"@number"            { }, -- Number
    -- sym"@boolean"           { }, -- Boolean
    -- sym"@float"             { }, -- Float
    -- sym"@function"          { }, -- Function
    -- sym"@function.builtin"  { }, -- Special
    -- sym"@function.macro"    { }, -- Macro
    -- sym"@parameter"         { }, -- Identifier
    -- sym"@method"            { }, -- Function
    -- sym"@field"             { }, -- Identifier
    -- sym"@property"          { }, -- Identifier
    -- sym"@constructor"       { }, -- Special
    -- sym"@conditional"       { }, -- Conditional
    -- sym"@repeat"            { }, -- Repeat
    -- sym"@label"             { }, -- Label
    -- sym"@operator"          { }, -- Operator
    -- sym"@keyword"           { }, -- Keyword
    -- sym"@exception"         { }, -- Exception
    -- sym"@variable"          { }, -- Identifier
    -- sym"@type"              { }, -- Type
    -- sym"@type.definition"   { }, -- Typedef
    -- sym"@storageclass"      { }, -- StorageClass
    -- sym"@structure"         { }, -- Structure
    -- sym"@namespace"         { }, -- Identifier
    -- sym"@include"           { }, -- Include
    -- sym"@preproc"           { }, -- PreProc
    -- sym"@debug"             { }, -- Debug
    -- sym"@tag"               { }, -- Tag

    ------ Generic Groups
    ActivePopupBorder         { fg = p.anise.desaturate(60).darken(20) },

    ------ Plugin Support
    ---- gitsigns.nvim
    GitSignsAdd               { DiffAddBright },
    GitSignsChange            { DiffChangeBright },
    GitSignsDelete            { DiffDeleteBright },
    GitSignsCurrentLineBlame  { fg = p.dark_fg_dim.darken(10).desaturate(10) },
    GitSignsAddPreview        { DiffAddBright },
    GitSignsDeletePreview     { DiffDeleteBright },
    GitSignsChangePreview     { DiffChangeBright },

    ---- Neogit
    NeogitCursorLine          { gui = "nocombine" },
    NeogitHunkHeader          { fg = p.dark_fg_dim, bg = p.dark_bg.lighten(15).saturate(5) },
    NeogitHunkHeaderHighlight { fg = p.white, bg = p.dark_bg.lighten(30).saturate(10) },
    NeogitHunkHeaderCursor    { fg = p.white, bg = p.dark_bg.lighten(45).saturate(10) },
    NeogitDiffAdd             { bg = p.bg.mix(p.green.darken(30), 30) },
    NeogitDiffAddHighlight    { bg = p.bg.mix(p.green.darken(30), 40) },
    NeogitDiffAddInline       { bg = p.bg.mix(p.green.darken(30), 40) },
    NeogitDiffAddCursor       { bg = p.bg.mix(p.green.darken(30), 50) },
    NeogitDiffDelete          { bg = p.bg.mix(p.bright_red.darken(30), 30) },
    NeogitDiffDeleteHighlight { bg = p.bg.mix(p.bright_red.darken(30), 40) },
    NeogitDiffDeleteInline    { bg = p.bg.mix(p.bright_red.darken(30), 40) },
    NeogitDiffDeleteCursor    { bg = p.bg.mix(p.bright_red.darken(30), 50) },
    NeogitFloatBorder         { ActivePopupBorder },

    ---- git-conflict.nvim
    GitConflictCurrent        { bg = p.dark_bg.lighten(13).saturate(05) },
    GitConflictCurrentLabel   { bg = p.dark_bg.lighten(30).saturate(10) },
    GitConflictIncoming       { bg = p.dark_bg.lighten(13).saturate(5).rotate(-80) },
    GitConflictIncomingLabel  { bg = p.dark_bg.lighten(30).saturate(10).rotate(-80) },
    GitConflictAncestor       { bg = p.dark_bg.lighten(13).saturate(5).rotate(-30) },
    GitConflictAncestorLabel  { bg = p.dark_bg.lighten(30).saturate(10).rotate(-30) },

    ---- avante.nvim
    AvanteTitle               { fg = p.black, bg = p.green.lighten(10).saturate(10) },
    AvanteReversedTitle       { fg = p.green.lighten(10).saturate(10) },
    AvanteSubtitle            { fg = p.bright_white, bg = p.blue.lighten(10).saturate(10) },
    AvanteReversedSubtitle    { fg = p.blue.lighten(10).saturate(10) },
    AvanteThirdTitle          { fg = p.black, bg = p.yellow.lighten(10).saturate(10) },
    AvanteReversedThirdTitle  { fg = p.yellow.lighten(10).saturate(10) },

    AvanteConflictCurrent       { GitConflictCurrent },
    AvanteConflictCurrentLabel  { GitConflictCurrentLabel },
    AvanteConflictIncoming      { GitConflictIncoming },
    AvanteConflictIncomingLabel { GitConflictIncomingLabel },
    AvanteConflictAncestor      { GitConflictAncestor },
    AvanteConflictAncestorLabel { GitConflictAncestorLabel },

    AvanteInlineHint            { fg = p.bright_violet.lighten(35).saturate(-10) },

    ---- nvim-tree.lua
    NvimTreeGitDirty          { DiffChangeBright },
    NvimTreeGitStaged         { DiffTextBright },
    NvimTreeGitMerge          { fg = p.bright_violet },
    NvimTreeGitRenamed        { fg = p.orange },
    NvimTreeGitNew            { DiffAddBright },
    NvimTreeGitDeleted        { DiffDeleteBright },
    NvimTreeIndentMarker      { fg = p.bright_black.darken(20) },
    NvimTreeNormal            { Normal, fg = p.bright_black.lighten(70).rotate(-10)  },
    NvimTreeNormalNC          { NormalNC, fg = p.bright_black.lighten(70).rotate(-10)  },
    NvimTreeFolderName        { fg = p.bright_black.lighten(40).saturate(30).rotate(-10)  },
    NvimTreeEmptyFolderName   { NvimTreeFolderName },
    NvimTreeOpenedFolderName  { fg = p.bright_black.lighten(70).saturate(50).rotate(-10)  },
    NvimTreeOpenedHL          { NvimTreeNormal, fg = p.bright_violet.lighten(40).saturate(10)  },
    NvimTreeExecFile          { gui = 'bold,italic' },
    NvimTreeSpecialFile       { gui = 'bold' },

    ---- Neo-tree.nvim
    NeoTreeBufferNumber       { fg = p.bright_black },
    NeoTreeCursorLine         { CursorLine },
    NeoTreeDirectoryIcon      { fg = p.bright_violet.lighten(40).desaturate(50) },
    NeoTreeDirectoryName      { fg = p.bright_violet.lighten(30).desaturate(10) },
    NeoTreeDotfile            { fg = p.anise.lighten(50).desaturate(10) },
    NeoTreeFileIcon           { fg = p.anise.lighten(40).desaturate(60) },
    NeoTreeFileName           { fg = p.anise.lighten(50).desaturate(10) },
    NeoTreeFileNameOpened     { fg = p.anise.lighten(30).saturate(10) },
    NeoTreeFilterTerm         { fg = p.anise.lighten(50).desaturate(10) },
    NeoTreeGitAdded           { fg = p.green.lighten(60) },
    NeoTreeGitConflict        { sp = p.red, gui = 'undercurl' },
    NeoTreeGitDeleted         { fg = p.bright_red.lighten(40) },
    NeoTreeGitIgnored         { fg = p.anise.lighten(20).desaturate(50) },
    NeoTreeGitModified        { fg = p.yellow.lighten(30) },
    NeoTreeGitUnstaged        { fg = p.yellow.lighten(10) },
    NeoTreeGitUntracked       { fg = p.yellow.lighten(60) },
    NeoTreeGitStaged          { DiffTextBright },
    NeoTreeHiddenByName       { fg = p.anise.lighten(20).desaturate(50) },
    NeoTreeIndentMarker       { fg = p.bright_black },

    -- fyler.nvim
    FylerFSDirectoryIcon      { NeoTreeDirectoryIcon },
    FylerFSDirectoryName      { NeoTreeDirectoryName },
    FylerFSFile               { NeoTreeFileName },
    FylerFSLink               { fg = p.anise.lighten(60).desaturate(20) },
    FylerGitAdded             { NeoTreeGitAdded },
    FylerGitConflict          { NeoTreeGitConflict },
    FylerGitDeleted           { NeoTreeGitDeleted },
    FylerGitIgnored           { NeoTreeGitIgnored },
    FylerGitModified          { NeoTreeGitModified },
    FylerGitUnstaged          { NeoTreeGitUnstaged },
    FylerGitUntracked         { NeoTreeGitUntracked },
    FylerGitStaged            { DiffTextBright },
    FylerGitRenamed           { NvimTreeGitRenamed },
    FylerGreen                { fg = p.green },
    FylerGrey                 { fg = p.dark_fg_dim },
    FylerRed                  { fg = p.red },
    FylerYellow               { fg = p.yellow },
    FylerBorder               { FloatBorder },
    FylerIndentMarker         { NeoTreeIndentMarker },
    FylerNormal               { NvimTreeNormal },
    FylerNormalNC             { NvimTreeNormalNC },

    -- Telescope.nvim
    TelescopeBorder           { ActivePopupBorder },
    TelescopeNormal           { Normal },
    TelescopePromptBorder     { TelescopeBorder },
    TelescopePromptNormal     { TelescopeNormal },
    TelescopePromptTitle      { fg = p.anise.desaturate(50).lighten(40) },
    TelescopeResultsBorder    { TelescopeBorder },
    TelescopePreviewBorder    { TelescopeBorder },
    TelescopeMatching         { Search },

    -- ToggleTerm.nvim
    ToggleTermFloatBorder     { FloatBorder },
    ToggleTerm1FloatBorder     { FloatBorder },

    -- noice.nvim
    NoiceCmdlinePopupBorder   { ActivePopupBorder },
    NoiceCmdlinePopupTitle    { fg = p.anise.desaturate(50).lighten(40) },
    NoiceCmdlineIcon          { NoiceCmdlinePopupTitle },

    ---- nvim-cmp
    CmpNormal                 { Normal },
    -- CmpNormal                 { fg = p.fg, bg = p.bg.lighten(10) },
    CmpBorder                 { ActivePopupBorder },
    CmpSel                    { bg = p.dark_bg.saturate(15).lighten(50), fg = p.bright_white, gui = 'bold' },

    CmpItemMenu               { fg = p.dust, gui = "italic" },
    CmpItemAbbr               { fg = p.dark_fg },
    CmpItemAbbrMatch          { Search },
    CmpItemAbbrMatchFuzzy     { Search },

    CmpItemAbbrDeprecated     { fg = p.cayenne, gui = "strikethrough" },

    CmpItemKind               { fg = p.bright_white },

    CmpItemKindMethod         { bg = p.velvet.darken(5), fg = p.bright_white },
    CmpItemKindConstructor    { CmpItemKindMethod },
    CmpItemKindFunction       { CmpItemKindMethod },

    CmpItemKindVariable       { bg = p.blush.darken(5), fg = p.bright_white },
    CmpItemKindConstant       { CmpItemKindVariable },
    CmpItemKindValue          { CmpItemKindVariable },
    CmpItemKindField          { CmpItemKindVariable },
    CmpItemKindProperty       { CmpItemKindVariable },
    CmpItemKindEnumMember     { CmpItemKindVariable },
    CmpItemKindReference      { CmpItemKindVariable },

    CmpItemKindOperator       { bg = p.matcha.darken(5), fg = p.bright_white },
    CmpItemKindKeyword        { CmpItemKindOperator },
    CmpItemKindTypeParameter  { CmpItemKindOperator },

    CmpItemKindModule         { bg = p.yellow.darken(5), fg = p.bright_white },
    CmpItemKindClass          { CmpItemKindModule },
    CmpItemKindInterface      { CmpItemKindModule },
    CmpItemKindStruct         { CmpItemKindModule },
    CmpItemKindEnum           { CmpItemKindModule },

    CmpItemKindEvent          { bg = p.light_lavender.darken(5), fg = p.bright_white },
    CmpItemKindUnit           { CmpItemKindEvent },
    CmpItemKindFile           { CmpItemKindEvent },
    CmpItemKindFolder         { CmpItemKindEvent },

    CmpItemKindText           { bg = p.anise.darken(5), fg = p.bright_white },

    CmpItemKindSnippet        { bg = p.violet, fg = p.bright_white },
    CmpItemKindColor          { bg = p.mint.darken(0), fg = p.bright_white },

    ---- nvim-cmp (neopyter)
    CmpItemKindMagic          { bg = p.orange.desaturate(10).lighten(15), fg = p.bright_white },
    CmpItemKindPath           { CmpItemKindMagic },
    CmpItemKindDictkey        { CmpItemKindMagic },
    CmpItemKindInstance       { CmpItemKindMagic },
    CmpItemKindStatement      { CmpItemKindMagic },

    ---- blink.cmp
    BlinkCmpLabel           { CmpItemAbbr },
    BlinkCmpLabelMatch      { CmpItemAbbrMatch },

    BlinkCmpLabelDeprecated { CmpItemAbbrDeprecated },
    BlinkCmpLabelDetail     { CmpItemMenu },
    BlinkCmpLabelDescription { CmpItemMenu },
    BlinkCmpKind            { CmpItemKind },
    BlinkCmpSource          { CmpItemMenu },

    BlinkCmpKindMethod         { CmpItemKindMethod },
    BlinkCmpKindConstructor    { CmpItemKindMethod },
    BlinkCmpKindFunction       { CmpItemKindMethod },

    BlinkCmpKindVariable       { CmpItemKindVariable },
    BlinkCmpKindConstant       { CmpItemKindVariable },
    BlinkCmpKindValue          { CmpItemKindVariable },
    BlinkCmpKindField          { CmpItemKindVariable },
    BlinkCmpKindProperty       { CmpItemKindVariable },
    BlinkCmpKindEnumMember     { CmpItemKindVariable },
    BlinkCmpKindReference      { CmpItemKindVariable },

    BlinkCmpKindOperator       { CmpItemKindOperator },
    BlinkCmpKindKeyword        { CmpItemKindOperator },
    BlinkCmpKindTypeParameter  { CmpItemKindOperator },

    BlinkCmpKindModule         { CmpItemKindModule },
    BlinkCmpKindClass          { CmpItemKindModule },
    BlinkCmpKindInterface      { CmpItemKindModule },
    BlinkCmpKindStruct         { CmpItemKindModule },
    BlinkCmpKindEnum           { CmpItemKindModule },

    BlinkCmpKindEvent          { CmpItemKindEvent },
    BlinkCmpKindUnit           { CmpItemKindEvent },
    BlinkCmpKindFile           { CmpItemKindEvent },
    BlinkCmpKindFolder         { CmpItemKindEvent },

    BlinkCmpKindText           { CmpItemKindText },

    BlinkCmpKindSnippet        { CmpItemKindSnippet },
    BlinkCmpKindColor          { CmpItemKindColor },

    BlinkCmpScrollBarThumb     { PmenuThumb },
    BlinkCmpScrollBarGutter    { PmenuSbar },

    BlinkCmpGhostText          { Comment },

    BlinkCmpMenu               { CmpNormal },
    BlinkCmpMenuBorder         { CmpBorder },
    BlinkCmpMenuSelection      { CmpSel },

    BlinkCmpDoc                { CmpNormal },
    BlinkCmpDocBorder          { CmpBorder },
    BlinkCmpDocCursorLine      { CursorLine },
    --
    BlinkCmpSignatureHelp      { CmpNormal },
    BlinkCmpSignatureHelpBorder { CmpBorder },
    BlinkCmpSignatureHelpActiveParameter { LspSignatureActiveParameter },

    ---- flash.nvim
    FlashBackdrop             { bg = p.dark_bg.lighten(5) },
    FlashMatch                { bg = p.velvet.darken(10), fg = p.white },
    FlashCurrent              { bg = p.blush, fg = p.dark_bg_med },
    FlashLabel                { bg = p.yellow, fg = p.dark_bg_med },
    FlashPrompt               { bg = p.med_violet, fg = p.white },
    FlashPromptIcon           { bg = p.med_violet, fg = p.white },
    FlashCursor               { bg = p.skyblue, fg = p.dark_bg_med },

    ---- nvim-treesitter-context
    TreesitterContext         { bg = p.dark_bg.lighten(15).desaturate(5) },
    TreesitterContextLineNumber { fg = p.bright_black.lighten(10), bg = p.dark_bg.lighten(5) },
    -- TreesitterContextSeparator {},
    -- TreesitterContextBottom    {},

    ---- twoslash-queries.nvim
    TypeVirtualText           { fg = p.blue.lighten(30), bg = p.dark_bg.lighten(15).desaturate(5) },

    ---- aerial.nvim
    AerialLine                { bg = p.dark_bg.lighten(40) },
    AerialLineNC              { bg = p.dark_bg.lighten(20) },

    ---- multiple-cursors.nvim
    MultipleCursorsCursor     { bg = p.dark_bg.lighten(75).saturate(50), fg = p.dark_bg_dark },
    MultipleCursorsVisual     { bg = p.dark_bg.lighten(45) },

    ---- nvim-navic
    NavicIconsFile            { Statement },
    NavicIconsModule          { Type },
    NavicIconsNamespace       { Type },
    NavicIconsPackage         { Type },
    NavicIconsClass           { Type },
    NavicIconsMethod          { Function },
    NavicIconsProperty        { Identifier },
    NavicIconsField           { Identifier },
    NavicIconsConstructor     { Function },
    NavicIconsEnum            { Type },
    NavicIconsInterface       { Type },
    NavicIconsFunction        { Function },
    NavicIconsVariable        { Identifier },
    NavicIconsConstant        { Constant },
    NavicIconsString          { String },
    NavicIconsNumber          { Number },
    NavicIconsBoolean         { Boolean },
    NavicIconsArray           { Type },
    NavicIconsObject          { Type },
    NavicIconsKey             { Identifier },
    NavicIconsNull            { fg = p.bright_black },
    NavicIconsEnumMember      { Identifier },
    NavicIconsStruct          { Type },
    NavicIconsEvent           { Type },
    NavicIconsOperator        { Statement },
    NavicIconsTypeParameter   { Type },
    NavicText                 { Identifier },
    NavicSeparator            { fg = p.bright_black.lighten(10) },

    ---- indent-blankline.nvim
    IblIndent                 { NonText },
    IblScope                  { fg = p.velvet.rotate(15).lighten(25).desaturate(10) },
    IblWhitespace             { Comment },

    ---- snacks.nvim
    SnacksIndent              { IblIndent },
    SnacksIndentScope         { IblScope },
    SnacksIndentBlank         { IblWhitespace },

    ---- nvim-dap
    DapBreakpoint           { fg = p.yellow.darken(20) },
    DapBreakpointCondition  { DapBreakpoint },
    DapLogPoint             { DapBreakpoint },
    DapStopped              { fg = p.pumpkin.darken(5) },
    DapBreakpointRejected   { fg = p.red },

    ---- nvim-dap-ui
    DapUINormal             { Normal },
    DapUIVariable           { Identifier },
    DapUIScope              { Type },
    DapUIType               { Type },
    DapUIValue              { Constant },
    DapUIModifiedValue      { Constant, gui = "bold" },
    DapUIDecoration         { fg = p.green },
    DapUIThread             { fg = p.green },
    DapUIStoppedThread      { fg = p.green, gui = "undercurl" },
    DapUIFrameName          { fg = p.dark_fg },
    DapUISource             { Tag },
    DapUILineNumber         { fg = p.yellow.lighten(30) },
    DapUIFloatNormal        { NormalFloat },
    DapUIFloatBorder        { FloatBorder },
    DapUIWatchesEmpty       { fg = p.cayenne },
    DapUIWatchesValue       { fg = p.bright_violet },
    DapUIWatchesError       { fg = p.red },
    DapUIBreakpointsPath    { fg = p.cyan },
    DapUIBreakpointsInfo    { fg = p.cyan.rotate(20) },
    DapUIBreakpointsCurrentLine { fg = p.cyan.rotate(20), gui = "bold" },
    DapUIBreakpointsLine    { DapUILineNumber },
    DapUIBreakpointsDisabledLine { fg = p.dark_fg_dim },
    DapUICurrentFrameName   { DapUIBreakpointsCurrentLine },
    DapUIStepOver           { fg = p.cyan },
    DapUIStepInto           { fg = p.cyan },
    DapUIStepBack           { fg = p.cyan },
    DapUIStepOut            { fg = p.cyan },
    DapUIStop               { DapStopped },
    DapUIPlayPause          { DapBreakpoint },
    DapUIRestart            { DapBreakpoint },
    DapUIUnavailable        { fg = p.dark_fg_dim },
    DapUIWinSelect          { fg = p.cyan, gui = "bold" },
    DapUIEndofBuffer        { EndOfBuffer },


    --- RenderMarkdown.nvim
    RenderMarkdownH1Bg           { fg = p.bright_white, bg = p.lavender.lighten(20).saturate(-40).mix(p.bg, 35), bold = true },
    RenderMarkdownH2Bg           { fg = p.white.darken(2), bg = p.blue.lighten(-20).saturate(-50).mix(p.bg, 75), bold = true },
    RenderMarkdownH3Bg           { fg = p.white.darken(8).desaturate(15), bg = p.blue.lighten(-20).saturate(-50).mix(p.bg, 90), bold = true },
    RenderMarkdownH4Bg           { fg = p.white.darken(8).desaturate(15), bg = p.blue.lighten(-20).saturate(-50).mix(p.bg, 95), bold = true },
    RenderMarkdownH5Bg           { fg = p.white.darken(8).desaturate(15), bg = p.blue.lighten(-20).saturate(-50).mix(p.bg, 95) },
    RenderMarkdownH6Bg           { fg = p.white.darken(8).desaturate(15), bg = p.blue.lighten(-20).saturate(-50).mix(p.bg, 95) },
    RenderMarkdownH1             { fg = RenderMarkdownH1Bg.fg, bold = true },
    RenderMarkdownH2             { fg = RenderMarkdownH2Bg.fg, bold = true },
    RenderMarkdownH3             { fg = RenderMarkdownH3Bg.fg, bold = true },
    RenderMarkdownH4             { fg = RenderMarkdownH4Bg.fg, bold = true },
    RenderMarkdownH5             { fg = RenderMarkdownH5Bg.fg },
    RenderMarkdownH6             { fg = RenderMarkdownH6Bg.fg },
    RenderMarkdownCode           { bg = p.dark_bg.lighten(5).saturate(10) },
    RenderMarkdownCodeInline     { bg = p.dark_bg.lighten(25).saturate(10) },
    RenderMarkdownInlineHighlight { bg = p.dark_bg.lighten(25).saturate(10).rotate(-40) },
    RenderMarkdownChecked        { String },
    RenderMarkdownUnchecked      { fg = p.blue.lighten(10).saturate(10) },
    RenderMarkdownTodo           { Todo },
    RenderMarkdownLink           { fg = p.blue.lighten(30).saturate(10), underline = true },
    RenderMarkdownWikiLink       { RenderMarkdownLink },
    RenderMarkdownError          { fg = p.bright_red.lighten(10) },
    RenderMarkdownWarn           { fg = p.yellow.lighten(10) },
    RenderMarkdownInfo           { fg = p.cyan.lighten(10) },
    RenderMarkdownHint           { fg = p.blue.lighten(30).saturate(10) },
    RenderMarkdownSuccess        { fg = p.green },
    RenderMarkdownQuote          { fg = p.blue.lighten(30).saturate(10) },
    -- RenderMarkdownSign           { fg = hsl('#565f89') },
    RenderMarkdownSign           { fg = p.deep_velvet.darken(20) },
    RenderMarkdownDash           { fg = p.deep_velvet.darken(20) },
    RenderMarkdownBullet         { fg = p.deep_velvet.lighten(70).saturate(70) },
    RenderMarkdownTableHead      { fg = p.blue.lighten(80).saturate(-30).mix(p.bg, 35) },
    RenderMarkdownTableRow       { RenderMarkdownTableHead },
    RenderMarkdownTableFill      { bg = p.bg },
    RenderMarkdownHtmlComment    { Comment },
    RenderMarkdownMath           { fg = p.blue.lighten(30).saturate(10), italic = true },
    -- stylua: ignore end
  }
end)

-- Return our parsed theme for extension or use elsewhere.
return theme

-- vi:nowrap
