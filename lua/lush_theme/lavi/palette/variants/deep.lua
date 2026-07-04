-- Seed colors for the "deep" variant (the neutral treatment).
--
-- A dark, low-contrast, slate-blue take on lavi. The neutral backgrounds and
-- grey ladder shift from purple toward slate-blue and sit in a tight, dark
-- band; the accents and functional warm colors (String, Number, diagnostics)
-- are inherited from the default lavi variant. This is the base other "deep-*"
-- variants layer their accent treatments on top of. Only the seeds that differ
-- are listed here; everything else, and all derived ladders/shades, comes from
-- the lavi base via palette.build.

local hsl = require("lush").hsl
local lavi = require("lush_theme.lavi.palette.variants.lavi")

-- Dark slate-blue base. Darker than lavi and than the first pass; the whole
-- neutral band sits low and tight.
local bg1 = hsl("#1D2130")

return vim.tbl_extend("force", lavi, {
  bg1 = bg1,

  -- Keep lavi's raised elevation (panels lighter than the base) but compress
  -- the ladder so the layers sit close together, giving the flat, low-contrast
  -- feel of sodium's matugen surfaces. Default lavi steps are lighten(13)/(20);
  -- deep uses smaller ones.
  bg2 = bg1.lighten(3),
  bg3 = bg1.lighten(6),

  -- Slate grey-ladder base, darkened to sit with the low neutral band.
  -- med_black / bright_black derive from this.
  black = hsl("#20232F"),

  -- Bright lavender main text (sodium surfaceVariantText #ede8fd).
  fg2 = hsl("#EDE8FD"),

  -- Muted lavender-grey dim text (sodium surfaceText #b7b7eb). Overrides the
  -- derived fg1 so dim text reads greyer, matching the sodium vibe instead of
  -- lavi's brighter dim step.
  fg1 = hsl("#B7B7EB"),
})
