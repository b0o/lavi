-- Seed colors for the "deep-ember" variant.
--
-- The "deep" neutral treatment with ember's accent treatment layered on top,
-- taken from the original sodium.json theme. Only accent seeds differ from
-- deep; the neutral band and everything else come from deep.
--
-- Mapping (via dms.lua): primary <- iris, secondary/surfaceTint <- blue,
-- outline <- muted_anise. Note `blue` is also a syntax color (Function, etc.),
-- so the indigo shift recolors syntax too.

local hsl = require("lush").hsl
local deep = require("lush_theme.lavi.palette.variants.deep")

return vim.tbl_extend("force", deep, {
  -- sodium primary: orange (the one warm accent, used sparingly)
  iris = hsl("#FE9F2F"),

  -- sodium secondary / surfaceTint: indigo
  blue = hsl("#584EF1"),

  -- sodium outline: lavender (also recolors Comment, which shares muted_anise)
  muted_anise = hsl("#8582C0"),
})
