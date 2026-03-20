local p = require("lush_theme.lavi.palette")
local lavi = require("lush_theme.lavi")

return {
  ["$schema"] = "https://opencode.ai/theme.json",
  theme = {
    primary = {
      dark = p.bright_violet.darken(5).desaturate(30),
      light = p.orange.darken(5).desaturate(30),
    },
    secondary = {
      dark = p.blue,
      light = p.blue,
    },
    accent = {
      dark = p.blush,
      light = p.blush,
    },
    error = {
      dark = p.bright_red,
      light = p.bright_red,
    },
    warning = {
      dark = p.orange,
      light = p.orange,
    },
    success = {
      dark = p.green,
      light = p.green,
    },
    info = {
      dark = p.oceanblue,
      light = p.blue,
    },
    text = {
      dark = lavi.Normal.fg,
      light = lavi.Normal.fg,
    },
    textMuted = {
      dark = p.fg_nc,
      light = p.fg_nc,
    },
    placeholderText = {
      dark = p.anise_dark,
      light = p.med_black,
    },
    background = {
      dark = p.dark_bg,
      light = p.bright_white,
    },
    backgroundPanel = {
      dark = p.bg_med,
      light = p.bright_white,
    },
    backgroundElement = {
      dark = p.bg_med,
      light = p.bright_white,
    },
    backgroundMenu = {
      dark = p.dark_bg_bright,
      light = p.bright_white,
    },
    border = {
      dark = p.med_black,
      light = p.bright_black,
    },
    borderActive = {
      dark = p.bright_black,
      light = p.med_black,
    },
    borderSubtle = {
      dark = p.med_black,
      light = p.bright_black,
    },
    diffAdded = {
      dark = lavi.DiffAddBright.fg,
      light = lavi.DiffAddBright.fg,
    },
    diffRemoved = {
      dark = lavi.DiffDeleteBright.fg,
      light = lavi.DiffDeleteBright.fg,
    },
    diffContext = {
      dark = lavi.DiffTextBright.fg,
      light = lavi.DiffTextBright.fg,
    },
    diffHunkHeader = {
      dark = lavi.NeogitHunkHeader.fg,
      light = lavi.NeogitHunkHeader.fg,
    },
    diffHighlightAdded = {
      dark = lavi.DiffAddBright.fg,
      light = lavi.DiffAddBright.fg,
    },
    diffHighlightRemoved = {
      dark = lavi.DiffDeleteBright.fg,
      light = lavi.DiffDeleteBright.fg,
    },
    diffAddedBg = {
      dark = lavi.NeogitDiffAdd.bg,
      light = lavi.NeogitDiffAdd.bg,
    },
    diffRemovedBg = {
      dark = lavi.NeogitDiffDelete.bg,
      light = lavi.NeogitDiffDelete.bg,
    },
    diffContextBg = {
      dark = lavi.DiffText.bg,
      light = lavi.DiffText.bg,
    },
    diffLineNumber = {
      dark = lavi.LineNr.fg,
      light = lavi.LineNr.fg,
    },
    diffAddedLineNumberBg = {
      dark = lavi.NeogitDiffAddHighlight.bg,
      light = lavi.NeogitDiffAddHighlight.bg,
    },
    diffRemovedLineNumberBg = {
      dark = lavi.NeogitDiffDeleteHighlight.bg,
      light = lavi.NeogitDiffDeleteHighlight.bg,
    },
    markdownText = {
      dark = p.white,
      light = p.white,
    },
    markdownHeading = {
      dark = lavi.RenderMarkdownH2.fg.saturate(20).darken(5),
      light = lavi.RenderMarkdownH2.fg.saturate(20).darken(5),
    },
    markdownLink = {
      dark = lavi.RenderMarkdownLink.fg,
      light = lavi.RenderMarkdownLink.fg,
    },
    markdownLinkText = {
      dark = lavi.RenderMarkdownLink.fg,
      light = lavi.RenderMarkdownLink.fg,
    },
    markdownCode = {
      dark = p.fg_nc,
      light = p.fg_nc,
    },
    markdownBlockQuote = {
      dark = lavi.RenderMarkdownQuote.fg,
      light = lavi.RenderMarkdownQuote.fg,
    },
    markdownEmph = {
      dark = lavi.RenderMarkdownHint.fg,
      light = lavi.RenderMarkdownHint.fg,
    },
    markdownStrong = {
      dark = lavi.RenderMarkdownWarn.fg,
      light = lavi.RenderMarkdownWarn.fg,
    },
    markdownHorizontalRule = {
      dark = lavi.RenderMarkdownSign.fg,
      light = lavi.RenderMarkdownSign.fg,
    },
    markdownListItem = {
      dark = lavi.RenderMarkdownBullet.fg,
      light = lavi.RenderMarkdownBullet.fg,
    },
    markdownListEnumeration = {
      dark = lavi.RenderMarkdownBullet.fg,
      light = lavi.RenderMarkdownBullet.fg,
    },
    selectedListItemText = {
      dark = lavi.Normal.fg,
      light = lavi.Normal.fg,
    },
    markdownImage = {
      dark = lavi.RenderMarkdownLink.fg,
      light = lavi.RenderMarkdownLink.fg,
    },
    markdownImageText = {
      dark = lavi.RenderMarkdownLink.fg,
      light = lavi.RenderMarkdownLink.fg,
    },
    markdownCodeBlock = {
      dark = p.fg_nc,
      light = p.fg_nc,
    },
    syntaxComment = {
      dark = lavi.Comment.fg,
      light = lavi.Comment.fg,
    },
    syntaxKeyword = {
      dark = lavi.Keyword.fg,
      light = lavi.Keyword.fg,
    },
    syntaxFunction = {
      dark = lavi.Function.fg,
      light = lavi.Function.fg,
    },
    syntaxVariable = {
      dark = lavi.Identifier.fg,
      light = lavi.Identifier.fg,
    },
    syntaxString = {
      dark = lavi.String.fg,
      light = lavi.String.fg,
    },
    syntaxNumber = {
      dark = lavi.Number.fg,
      light = lavi.Number.fg,
    },
    syntaxType = {
      dark = lavi.Type.fg,
      light = lavi.Type.fg,
    },
    syntaxOperator = {
      dark = lavi.Operator.fg,
      light = lavi.Operator.fg,
    },
    syntaxPunctuation = {
      dark = lavi.Delimiter.fg,
      light = lavi.Delimiter.fg,
    },
  },
}
