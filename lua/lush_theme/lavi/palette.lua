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

M.bright_black = hsl("#8977A8")
M.bright_red = M.red.lighten(10)
M.bright_green = M.green.lighten(10)
M.bright_yellow = M.yellow.lighten(10)
M.bright_blue = M.blue.lighten(10)
M.bright_magenta = M.magenta.lighten(10)
M.bright_cyan = M.cyan.lighten(10)
M.bright_white = hsl("#ffffff")

M.med_black = hsl("#4C435C")

M.dark_bg = hsl("#25213B")
M.dark_bg_dark = M.dark_bg.darken(10)
M.dark_bg_med = M.dark_bg.lighten(13)
M.dark_bg_bright = M.dark_bg.lighten(20)

M.light_bg = M.bright_white
M.light_bg_med = M.light_bg.darken(5)
M.light_bg_dark = M.light_bg.darken(10)
M.light_bg_bright = M.light_bg.lighten(20)

M.light_fg = M.black.lighten(5)
M.light_fg_dim = M.light_fg.lighten(20)
M.light_fg_nc = M.light_fg.lighten(40)

M.dark_fg = hsl("#ede7fe")
M.dark_fg_dim = hsl("#DED4FD")
M.dark_fg_nc = hsl("#A89CCF")

M.fg = M.dark_fg
M.fg_dim = M.dark_fg_dim
M.fg_nc = M.dark_fg_nc
M.fg_bright = M.bright_white

M.bg = M.dark_bg
M.bg_dark = M.dark_bg_dark
M.bg_med = M.dark_bg_med
M.bg_bright = M.dark_bg_bright

M.selection_fg = M.fg
M.selection_bg = M.dark_bg.lighten(30)

-- TODO: light mode
-- local function set_fg_bg()
--   local dark_mode = vim.g.colors_name == "lavi"
--   M.fg = dark_mode and M.dark_fg or M.light_fg
--   M.fg_dim = dark_mode and M.dark_fg_dim or M.light_fg_dim
--   M.fg_nc = dark_mode and M.dark_fg_nc or M.light_fg_nc
--
--   M.bg = dark_mode and M.dark_bg or M.light_bg
--   M.bg_dark = dark_mode and M.dark_bg_dark or M.light_bg_dark
--   M.bg_med = dark_mode and M.dark_bg_med or M.light_bg_med
--   M.bg_bright = dark_mode and M.dark_bg_bright or M.light_bg_bright
-- end

-- set_fg_bg()

M.cursor_fg = M.dark_fg
M.cursor_bg = M.dark_bg
M.cursor_border = M.dark_bg_bright

M.orange = hsl("#ff9969")
M.indigo = hsl("#9074FF")
M.violet = hsl("#DC91FF")
M.skyblue = hsl("#3FC4C4")

M.bright_indigo = M.indigo.lighten(10)
M.oceanblue = hsl("#80BDFF")
M.med_violet = hsl("#9385F8")
M.bright_violet = hsl("#B891FF")

M.straw = hsl("#fffacf")

M.tofu = hsl("#fdf6e3")
M.cashew = hsl("#e6dac3")
M.walnut = hsl("#CEB999")
M.almond = hsl("#a6875a")
M.cocoa = hsl("#3b290e")

M.licorice = hsl("#483270")
M.lavender = hsl("#A872FB")
M.velvet = hsl("#B29EED")
M.anise = hsl("#7F7DEE")
M.anise_dark = hsl("#7E7490")
M.hydrangea = hsl("#fb72fa")
M.blush = hsl("#EBBBF9")
M.powder = hsl("#EAC6F5")
M.dust = hsl("#EAD2F1")
M.mistyrose = hsl("#ffe4e1")
M.rebeccapurple = hsl("#3C2C74")

M.matcha = hsl("#9fdfb4")

M.snow = hsl("#e4fffe")
M.ice = hsl("#a4e2e0")
M.mint = hsl("#a2e0ca")

M.nectar = hsl("#f0f070")
M.cayenne = hsl("#FF7D90")
M.yam = hsl("#e86f54")
M.pumpkin = hsl("#ff9969")
M.rose = hsl("#b32e29")

M.grey2 = hsl("#222222")
M.grey5 = hsl("#777777")
M.grey6 = hsl("#aaaaaa")
M.grey7 = hsl("#cccccc")
M.grey8 = hsl("#dddddd")

M.mid_velvet = hsl("#6E6EA3")

M.deep_lavender = hsl("#38265A")
M.deep_licorice = M.dark_bg
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
