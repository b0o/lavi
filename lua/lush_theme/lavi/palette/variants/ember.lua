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

-- Slate-blue Normal background, tuned to sodium.json's surfaceVariant (#25273b).
local bg1 = hsl("#23283C")

return vim.tbl_extend("force", lavi, {
  bg1 = bg1,

  -- Recessed elevation. lavi's default ladder raises elevated surfaces
  -- (bg2/bg3 lighter than the base); ember flips this so every step sits below
  -- the base, giving the recessed surface progression of sodium's matugen
  -- palette. The base (bg1, Normal) is the lightest surface; panels, floats,
  -- containers and cursorline all recess beneath it. Because generators read
  -- these ladder steps, every app recesses consistently.
  --   bg0 (deepest) < bg2 < bg3 < bg1 (base)
  bg0 = bg1.darken(30),
  bg2 = bg1.darken(20),
  bg3 = bg1.darken(11),

  -- Slate grey-ladder base (vs lavi's purple-grey #2F2A38). med_black /
  -- bright_black derive from this.
  black = hsl("#2A2D3C"),

  -- Bright lavender main text (sodium surfaceVariantText #ede8fd).
  fg2 = hsl("#EDE8FD"),

  -- Muted lavender-grey dim text (sodium surfaceText #b7b7eb). Overrides the
  -- derived fg1 so dim text reads greyer, matching the sodium vibe instead of
  -- lavi's brighter dim step.
  fg1 = hsl("#B7B7EB"),
})
