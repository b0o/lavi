local p = require("lush_theme.lavi.palette")

local colors = {
  fg = p.fg,
  bg = p.bg,
  selection_fg = p.selection_fg,
  selection_bg = p.selection_bg,
  cursor_fg = p.cursor_fg,
  cursor_bg = p.cursor_bg,

  black = p.ansi.normal.black,
  red = p.ansi.normal.red,
  green = p.ansi.normal.green,
  yellow = p.ansi.normal.yellow,
  blue = p.ansi.normal.blue,
  magenta = p.ansi.normal.magenta,
  cyan = p.ansi.normal.cyan,
  white = p.ansi.normal.white,

  bright_black = p.ansi.bright.black,
  bright_red = p.ansi.bright.red,
  bright_green = p.ansi.bright.green,
  bright_yellow = p.ansi.bright.yellow,
  bright_blue = p.ansi.bright.blue,
  bright_magenta = p.ansi.bright.magenta,
  bright_cyan = p.ansi.bright.cyan,
  bright_white = p.ansi.bright.white,
}

-- Transform for contrib/kitty/lavi.conf
local function transform(compiled)
  local lines = {
    "# vim:ft=kitty",
    string.format("foreground                      %s", compiled.fg),
    string.format("background                      %s", compiled.bg),
    string.format("selection_foreground            %s", compiled.selection_fg),
    string.format("selection_background            %s", compiled.selection_bg),
    "# Cursor colors",
    string.format("cursor                          %s", compiled.cursor_bg),
    string.format("cursor_text_color               %s", compiled.cursor_fg),
    "# URL underline color when hovering with mouse",
    "# kitty window border colors",
    "# OS Window titlebar colors",
    "# Tab bar colors",
    "# Colors for marks (marked text in the terminal)",
    "# The basic 16 colors",
    "# black",
    string.format("color0 %s", compiled.black),
    string.format("color8 %s", compiled.bright_black),
    "# red",
    string.format("color1 %s", compiled.red),
    string.format("color9 %s", compiled.bright_red),
    "# green",
    string.format("color2  %s", compiled.green),
    string.format("color10 %s", compiled.bright_green),
    "# yellow",
    string.format("color3  %s", compiled.yellow),
    string.format("color11 %s", compiled.bright_yellow),
    "# blue",
    string.format("color4  %s", compiled.blue),
    string.format("color12 %s", compiled.bright_blue),
    "# magenta",
    string.format("color5  %s", compiled.magenta),
    string.format("color13 %s", compiled.bright_magenta),
    "# cyan",
    string.format("color6  %s", compiled.cyan),
    string.format("color14 %s", compiled.bright_cyan),
    "# white",
    string.format("color7  %s", compiled.white),
    string.format("color15 %s", compiled.bright_white),
    "# You can set the remaining 240 colors as color16 to color255.",
  }
  return lines
end

return {
  colors = colors,
  transform = transform,
}
