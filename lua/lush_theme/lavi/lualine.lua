local lavi = require("lush_theme.lavi.palette")
local lavi_b = { bg = lavi.bg_bright.hex, fg = lavi.bg.lighten(80).hex }
local lavi_c = { bg = lavi.bg.hex, fg = lavi.bg.lighten(70).hex }

return {
  normal = {
    a = { bg = lavi.bg_bright.lighten(30).hex, fg = lavi.bright_white.hex, gui = "bold" },
    b = lavi_b,
    c = lavi_c,
  },
  insert = {
    a = { bg = lavi.violet.hex, fg = lavi.bright_white.hex, gui = "bold" },
    b = lavi_b,
    c = lavi_c,
  },
  visual = {
    a = { bg = lavi.orange.hex, fg = lavi.bright_white.hex, gui = "bold" },
    b = lavi_b,
    c = lavi_c,
  },
  replace = {
    a = { bg = lavi.bright_red.hex, fg = lavi.bright_white.hex, gui = "bold" },
    b = lavi_b,
    c = lavi_c,
  },
  command = {
    a = { bg = lavi.blue.hex, fg = lavi.bright_white.hex, gui = "bold" },
    b = lavi_b,
    c = lavi_c,
  },
  inactive = {
    a = { bg = lavi.bg.hex, fg = lavi.bright_white.hex, gui = "bold" },
    b = lavi_b,
    c = lavi_c,
  },
}
