-- Seed colors for the "ember" variant.
--
-- A cool, slate-blue take on lavi. The neutral backgrounds and grey ladder
-- shift from purple toward slate-blue; the purple/blue accents and the
-- functional warm colors (String, Number, diagnostics) are inherited from the
-- default lavi variant, so warm stays sparing and the accent identity remains
-- purple/blue. Only the seeds that differ are listed here; everything else,
-- and all derived ladders/shades, comes from the lavi base via palette.build.

local hsl = require("lush").hsl
local lavi = require("lush_theme.lavi.palette.variants.lavi")

return vim.tbl_extend("force", lavi, {
  -- Cool slate-blue base (vs lavi's purple #25213B). The bg ladder derives.
  bg1 = hsl("#1C2436"),

  -- Slate grey-ladder base (vs lavi's purple-grey #2F2A38). med_black /
  -- bright_black derive from this.
  black = hsl("#2A2D3C"),

  -- Text kept lavender, nudged slightly cooler to match the slate mood.
  fg2 = hsl("#E9E7FD"),
})
