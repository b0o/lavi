-- Seed colors for the "deep-ember" variant.
--
-- The "deep" neutral treatment with ember's accent treatment layered on top.
-- Ember shifts the cool accents toward sodium's indigo/lavender character
-- (deeper, more indigo blue for the secondary/tint accents) while keeping the
-- purple primary and the functional warm colors sparing. Only accent seeds
-- differ from deep; the neutral band and everything else come from deep.

local hsl = require("lush").hsl
local deep = require("lush_theme.lavi.palette.variants.deep")

return vim.tbl_extend("force", deep, {
  -- Deeper, more indigo blue. Sodium's secondary (#584ef1) and surfaceTint
  -- leaned indigo; this nudges lavi's blue that direction. Note: `blue` is also
  -- a syntax color (Function, etc.), so this shifts syntax too.
  blue = hsl("#6A6CF3"),
})
