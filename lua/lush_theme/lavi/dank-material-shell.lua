local p = require("lush_theme.lavi.palette")
local lavi = require("lush_theme.lavi")
local transforms = require("lush_theme.lavi.transforms")

-- Surface elevation model. lavi's default is "raised": container surfaces get
-- progressively lighter than the base. Some variants (e.g. ember) instead use
-- a "recessed" elevation, where containers sit at or below the base, matching
-- matugen's scheme-fidelity look.
local variant = vim.g.lavi_build_variant or "lavi"
local recessed = ({ ember = true })[variant] or false

local dark_containers = recessed
    and {
      surfaceContainer = lavi.NormalNC.bg.darken(4),
      surfaceContainerHigh = lavi.NormalNC.bg,
      surfaceContainerHighest = p.bg0,
    }
  or {
    surfaceContainer = lavi.Normal.bg,
    surfaceContainerHigh = lavi.Normal.bg.lighten(5),
    surfaceContainerHighest = lavi.Normal.bg.lighten(25),
  }

local colors = {
  dark = {
    name = "Lavi Dark",

    primary = p.iris.desaturate(20),
    primaryText = lavi.NormalNC.bg,
    primaryContainer = p.selection_bg,

    secondary = p.blue.desaturate(20),

    surface = p.bg0,
    surfaceText = p.fg1,

    surfaceVariant = lavi.Normal.bg,
    surfaceVariantText = lavi.Normal.fg,

    surfaceTint = p.blue,

    background = lavi.NormalNC.bg,
    backgroundText = lavi.NormalNC.fg,

    outline = p.muted_anise,

    surfaceContainer = dark_containers.surfaceContainer,
    surfaceContainerHigh = dark_containers.surfaceContainerHigh,
    surfaceContainerHighest = dark_containers.surfaceContainerHighest,

    error = p.red.desaturate(15).darken(5),
    warning = p.yellow.desaturate(10).darken(5),
    info = p.oceanblue,

    matugen_type = "scheme-fidelity",
  },
  light = {
    name = "Lavi Light",

    primary = p.iris.desaturate(20).darken(10),
    primaryText = p.bright_white,
    primaryContainer = p.lavender.lighten(70).rotate(5),

    secondary = p.blue.desaturate(20).darken(10),

    surface = p.bright_white,
    surfaceText = p.light_fg_dim,

    surfaceVariant = p.light_bg_med,
    surfaceVariantText = p.light_fg,

    surfaceTint = p.blue,

    background = p.light_bg,
    backgroundText = p.light_fg,

    outline = p.muted_anise.lighten(15),

    surfaceContainer = p.light_bg_med,
    surfaceContainerHigh = p.light_bg_dark,
    surfaceContainerHighest = p.light_bg_dark.darken(5),

    error = p.red.desaturate(15).darken(10),
    warning = p.yellow.desaturate(10).darken(10),
    info = p.oceanblue.darken(10),

    matugen_type = "scheme-fidelity",
  },
}

local function transform(compiled)
  return transforms.to_json(compiled)
end

return {
  colors = colors,
  transform = transform,
}
