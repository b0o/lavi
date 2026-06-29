local lavi = require("lush_theme.lavi.palette")
local lavi_b = { bg = lavi.bg3.hex, fg = lavi.bg1.lighten(80).hex }
local lavi_c = { bg = lavi.bg1.hex, fg = lavi.bg1.lighten(70).hex }

return {
  normal = {
    a = { bg = lavi.bg3.lighten(30).hex, fg = lavi.bright_white.hex, gui = "bold" },
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
    a = { bg = lavi.bg1.hex, fg = lavi.bright_white.hex, gui = "bold" },
    b = lavi_b,
    c = lavi_c,
  },
}
