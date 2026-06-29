-- Palette builder.
--
-- Takes a table of seed colors (raw lush hsl objects) and derives the full
-- palette from them: the bright ANSI hues, the bg/fg/grey ladders, the light
-- mode values, selection/cursor colors, and the muted terminal ANSI set.
--
-- Every derived value uses the `M.x = M.x or <derivation>` form so a variant
-- may override any derived color by supplying it as a seed; otherwise it is
-- computed from the variant's base seeds. This is what lets a variant recolor
-- the whole theme by setting only a handful of seeds (bg1, fg2, black, accents).

---@param seeds table<string, table> seed colors (lush hsl objects)
---@return table palette
return function(seeds)
  local M = {}
  for k, v in pairs(seeds) do
    M[k] = v
  end

  -- Neutral grey ladder (from black)
  M.bright_black = M.bright_black or M.black.lighten(46).saturate(9).rotate(1)
  M.med_black = M.med_black or M.black.lighten(15).saturate(2).rotate(1)

  -- Bright ANSI hues
  M.bright_red = M.bright_red or M.red.lighten(10)
  M.bright_green = M.bright_green or M.green.lighten(10)
  M.bright_yellow = M.bright_yellow or M.yellow.lighten(10)
  M.bright_blue = M.bright_blue or M.blue.lighten(10)
  M.bright_magenta = M.bright_magenta or M.magenta.lighten(10)
  M.bright_cyan = M.bright_cyan or M.cyan.lighten(10)

  -- Muted / deep purple shades, derived from the base accent hues.
  M.muted_anise = M.muted_anise or M.anise.desaturate(86).darken(28).rotate(17)
  M.deep_anise = M.deep_anise or M.anise.desaturate(68).darken(42).rotate(8)
  M.muted_velvet = M.muted_velvet or M.velvet.desaturate(72).darken(18).rotate(-12)

  -- Background ladder, darkest -> brightest (bg1 is the Normal background)
  M.bg0 = M.bg0 or M.bg1.darken(10)
  M.bg2 = M.bg2 or M.bg1.lighten(13)
  M.bg3 = M.bg3 or M.bg1.lighten(20)

  -- Foreground ladder, dimmest -> brightest (fg2 is the main text color)
  M.fg1 = M.fg1 or M.fg2.darken(4)
  M.fg0 = M.fg0 or M.fg2.desaturate(62).darken(25).rotate(-2)
  M.fg3 = M.fg3 or M.bright_white

  -- Light mode (deferred; currently consumed only by the dms light theme).
  -- Will be unified with the numeric ladder when the mode system lands.
  M.light_bg = M.light_bg or M.bright_white
  M.light_bg_med = M.light_bg_med or M.light_bg.darken(5)
  M.light_bg_dark = M.light_bg_dark or M.light_bg.darken(10)
  M.light_fg = M.light_fg or M.black.lighten(5)
  M.light_fg_dim = M.light_fg_dim or M.light_fg.lighten(20)

  M.selection_fg = M.selection_fg or M.fg2
  M.selection_bg = M.selection_bg or M.bg1.lighten(30)

  M.cursor_fg = M.cursor_fg or M.fg2
  M.cursor_bg = M.cursor_bg or M.bg1
  M.cursor_border = M.cursor_border or M.bg3

  -- Muted ANSI colors for terminal emulators.
  -- Softer than the raw palette to match the neovim theme's aesthetic.
  M.ansi = M.ansi
    or {
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
end
