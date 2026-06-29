local p = require("lush_theme.lavi.palette")
local lavi = require("lush_theme.lavi")
local transforms = require("lush_theme.lavi.transforms")

local colors = {
  ["$schema"] = "https://raw.githubusercontent.com/earendil-works/pi/main/packages/coding-agent/src/modes/interactive/theme/theme-schema.json",
  name = "lavi",
  vars = {
    primary = p.blue.desaturate(10),
    secondary = p.bright_violet.darken(5).desaturate(30),
    accent = p.blush.darken(5).desaturate(10),
    success = p.green.desaturate(25).darken(10),
    error = p.red.desaturate(15).darken(5),
    warning = p.orange.desaturate(10).darken(5),
    info = p.oceanblue.desaturate(10),

    textMuted = p.fg0,
    placeholderText = p.muted_anise,

    background = p.bg1,
    backgroundPanel = lavi.Normal.bg,
    backgroundMenu = p.bg2,
    border = p.med_black,
    borderActive = p.bright_black,
    borderSubtle = p.med_black,
  },
  colors = {
    -- Core UI
    accent = "primary",
    border = "border",
    borderAccent = "borderActive",
    borderMuted = "borderSubtle",
    success = "success",
    error = "error",
    warning = "warning",
    muted = "textMuted",
    dim = "placeholderText",
    text = "",
    thinkingText = "textMuted",

    -- Backgrounds & content
    selectedBg = "backgroundMenu",
    userMessageBg = "backgroundPanel",
    userMessageText = "",
    customMessageBg = "backgroundPanel",
    customMessageText = "",
    customMessageLabel = "primary",
    toolPendingBg = p.bg2.lighten(10),
    toolSuccessBg = p.bg2,
    toolErrorBg = lavi.NeogitDiffDelete.bg,
    toolTitle = p.fg0,
    toolOutput = "",

    -- Markdown
    mdHeading = lavi.RenderMarkdownH2.fg.saturate(20).darken(5),
    mdLink = lavi.RenderMarkdownLink.fg,
    mdLinkUrl = "textMuted",
    mdCode = "textMuted",
    mdCodeBlock = "",
    mdCodeBlockBorder = "borderSubtle",
    mdQuote = lavi.RenderMarkdownQuote.fg,
    mdQuoteBorder = lavi.RenderMarkdownQuote.fg,
    mdHr = lavi.RenderMarkdownSign.fg,
    mdListBullet = lavi.RenderMarkdownBullet.fg,

    -- Tool diffs
    toolDiffAdded = lavi.DiffAddBright.fg,
    toolDiffRemoved = lavi.DiffDeleteBright.fg,
    toolDiffContext = p.fg0.lighten(20).desaturate(10),

    -- Syntax highlighting
    syntaxComment = lavi.Comment.fg,
    syntaxKeyword = lavi.Keyword.fg,
    syntaxFunction = lavi.Function.fg,
    syntaxVariable = lavi.Identifier.fg,
    syntaxString = lavi.String.fg,
    syntaxNumber = lavi.Number.fg,
    syntaxType = lavi.Type.fg,
    syntaxOperator = lavi.Operator.fg,
    syntaxPunctuation = lavi.Delimiter.fg,

    -- Thinking level borders
    thinkingOff = p.blue.saturate(-50),
    thinkingMinimal = p.blue.saturate(-25),
    thinkingLow = p.blue,
    thinkingMedium = p.blue.saturate(10).mix(p.red, 20),
    thinkingHigh = p.blue.saturate(10).mix(p.red, 40),
    thinkingXhigh = p.blue.mix(p.red, 75),

    -- Bash mode
    bashMode = "warning",
  },
  export = {
    pageBg = "background",
    cardBg = "backgroundPanel",
    infoBg = "backgroundMenu",
  },
}

local function transform(compiled)
  return transforms.to_json(compiled)
end

return {
  colors = colors,
  transform = transform,
}
