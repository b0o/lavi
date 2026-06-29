-- Seed colors for the default "lavi" variant.
--
-- These are the raw inputs the palette builder derives everything else from.
-- A new variant is a copy of this table (or a partial override of it) with
-- different seeds; see palette/init.lua for how a variant is selected.

local hsl = require("lush").hsl

return {
  -- ANSI base hues
  black = hsl("#2F2A38"),
  red = hsl("#F2637E"),
  green = hsl("#7CF89C"),
  yellow = hsl("#FFD080"),
  blue = hsl("#7583FF"),
  magenta = hsl("#B98AFF"),
  cyan = hsl("#2BEDC0"),
  white = hsl("#EEE6FF"),
  bright_white = hsl("#ffffff"),

  -- Structural bases (the bg/fg ladders derive from these)
  bg1 = hsl("#25213B"),
  fg2 = hsl("#ede7fe"),

  -- Accents
  orange = hsl("#ff9969"),
  violet = hsl("#DC91FF"),
  skyblue = hsl("#3FC4C4"),
  oceanblue = hsl("#80BDFF"),
  iris = hsl("#9385F8"),
  amethyst = hsl("#B891FF"),
  lavender = hsl("#A872FB"),
  velvet = hsl("#B29EED"),
  anise = hsl("#7F7DEE"),
  blush = hsl("#EBBBF9"),
  dust = hsl("#EAD2F1"),
  matcha = hsl("#9fdfb4"),
  mint = hsl("#a2e0ca"),
  cayenne = hsl("#FF7D90"),
}
