-- Palette resolver.
--
-- Selects a variant's seed colors and builds the full palette from them.
-- The active variant is chosen by `vim.g.lavi_build_variant` (set per-variant
-- by build.lua at build time); it defaults to "lavi". At runtime the compiled
-- colorscheme is plain hex and never loads this module, so the default is only
-- ever seen by the dev colorscheme.
--
-- Preserves the historic `require("lush_theme.lavi.palette")` entry point.

local build = require("lush_theme.lavi.palette.build")
local name = vim.g.lavi_build_variant or "lavi"
local seeds = require("lush_theme.lavi.palette.variants." .. name)

return build(seeds)
