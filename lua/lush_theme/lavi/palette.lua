local lush = require("lush")
local hsl = lush.hsl

local M = {}

M.black = hsl("#2F2A38")
M.red = hsl("#F2637E")
M.green = hsl("#7CF89C")
M.yellow = hsl("#FFD080")
M.blue = hsl("#7583FF")
M.magenta = hsl("#B98AFF")
M.cyan = hsl("#2BEDC0")
M.white = hsl("#EEE6FF")

M.bright_black = M.black.lighten(46).saturate(9).rotate(1)
M.bright_red = M.red.lighten(10)
M.bright_green = M.green.lighten(10)
M.bright_yellow = M.yellow.lighten(10)
M.bright_blue = M.blue.lighten(10)
M.bright_magenta = M.magenta.lighten(10)
M.bright_cyan = M.cyan.lighten(10)
M.bright_white = hsl("#ffffff")

M.med_black = M.black.lighten(15).saturate(2).rotate(1)

-- Background ladder, darkest -> brightest (bg1 is the Normal background)
M.bg1 = hsl("#25213B")
M.bg0 = M.bg1.darken(10)
M.bg2 = M.bg1.lighten(13)
M.bg3 = M.bg1.lighten(20)

-- Foreground ladder, dimmest -> brightest (fg2 is the main text color)
M.fg2 = hsl("#ede7fe")
M.fg1 = M.fg2.darken(4)
M.fg0 = M.fg2.desaturate(62).darken(25).rotate(-2)
M.fg3 = M.bright_white

-- Light mode (deferred; currently consumed only by the dms light theme).
-- Will be unified with the numeric ladder when the variant/mode system lands.
M.light_bg = M.bright_white
M.light_bg_med = M.light_bg.darken(5)
M.light_bg_dark = M.light_bg.darken(10)

M.light_fg = M.black.lighten(5)
M.light_fg_dim = M.light_fg.lighten(20)

M.selection_fg = M.fg2
M.selection_bg = M.bg1.lighten(30)

M.cursor_fg = M.fg2
M.cursor_bg = M.bg1
M.cursor_border = M.bg3

M.orange = hsl("#ff9969")
M.violet = hsl("#DC91FF")
M.skyblue = hsl("#3FC4C4")

M.oceanblue = hsl("#80BDFF")
M.med_violet = hsl("#9385F8")
M.bright_violet = hsl("#B891FF")

M.licorice = hsl("#483270")
M.lavender = hsl("#A872FB")
M.velvet = hsl("#B29EED")
M.anise = hsl("#7F7DEE")
M.anise_dark = hsl("#7E7490")
M.blush = hsl("#EBBBF9")
M.dust = hsl("#EAD2F1")

M.matcha = hsl("#9fdfb4")

M.mint = hsl("#a2e0ca")

M.cayenne = hsl("#FF7D90")

M.deep_lavender = hsl("#38265A")
M.deep_anise = hsl("#564D82")
M.deep_velvet = hsl("#8F8FB3")

M.light_lavender = hsl("#EAD6FF")

-- Muted ANSI colors for terminal emulators
-- Softer than the raw palette to match the neovim theme's aesthetic
M.ansi = {
  normal = {
    black = M.black,
    red = M.red.desaturate(15).darken(5),
    green = M.green.desaturate(25).darken(10),
    yellow = M.yellow.desaturate(10).darken(5),
    blue = M.blue.desaturate(10),
    magenta = M.velvet,
    cyan = M.cyan.desaturate(20).darken(5),
    white = M.white,
  },
  bright = {
    black = M.bright_black,
    red = M.bright_red.desaturate(10),
    green = M.bright_green.desaturate(20).darken(5),
    yellow = M.bright_yellow.desaturate(10),
    blue = M.bright_blue.desaturate(5),
    magenta = M.bright_magenta.desaturate(15),
    cyan = M.bright_cyan.desaturate(15),
    white = M.bright_white,
  },
}

return setmetatable(M, {
  __index = function(_, key)
    error("Invalid key: " .. key)
  end,
})
