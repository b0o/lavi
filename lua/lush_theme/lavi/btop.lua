local p = require("lush_theme.lavi.palette")

-- btop theme with muted colors matching the nvim theme aesthetic
local colors = {
  -- Main background, empty for terminal default
  main_bg = p.bg1,

  -- Main text color
  main_fg = p.fg0,

  -- Title color for boxes
  title = p.fg1,

  -- Highlight color for keyboard shortcuts
  hi_fg = p.yellow.lighten(20).desaturate(20),

  -- Background color of selected items
  selected_bg = p.deep_anise,

  -- Foreground color of selected items
  selected_fg = p.bright_white,

  -- Color of inactive/disabled text
  inactive_fg = p.bright_black.darken(20),

  -- Color of text appearing on top of graphs
  graph_text = p.bright_black.darken(10),

  -- Background color of the percentage meters
  meter_bg = p.med_black,

  -- Misc colors for processes box
  proc_misc = p.matcha,

  -- Box outline colors (matching zellij frame_unselected)
  cpu_box = p.bright_black.darken(10),
  mem_box = p.bright_black.darken(10),
  net_box = p.bright_black.darken(10),
  proc_box = p.bright_black.darken(10),

  -- Box divider line
  div_line = p.med_black,

  -- Temperature graph colors (cool to hot)
  temp_start = p.oceanblue.desaturate(20),
  temp_mid = p.velvet,
  temp_end = p.cayenne.lighten(10).desaturate(10),

  -- CPU graph colors (low to high: green -> blue -> purple)
  cpu_start = p.matcha,
  cpu_mid = p.oceanblue.desaturate(10),
  cpu_end = p.lavender,

  -- Mem/Disk free meter (green)
  free_start = p.matcha.darken(30),
  free_mid = "",
  free_end = p.matcha,

  -- Mem/Disk cached meter (blue)
  cached_start = p.oceanblue.darken(20).desaturate(10),
  cached_mid = "",
  cached_end = p.oceanblue.desaturate(10),

  -- Mem/Disk available meter (purple)
  available_start = p.velvet.darken(20),
  available_mid = "",
  available_end = p.velvet,

  -- Mem/Disk used meter (purple -> yellow hint)
  used_start = p.lavender.darken(20),
  used_mid = "",
  used_end = p.yellow.lighten(20).desaturate(20),

  -- Download graph colors (blue -> cyan)
  download_start = p.anise.lighten(10).desaturate(20),
  download_mid = p.oceanblue.desaturate(10),
  download_end = p.cyan.desaturate(20).lighten(20),

  -- Upload graph colors (purple -> pink)
  upload_start = p.velvet.darken(10),
  upload_mid = p.lavender,
  upload_end = p.blush,

  -- Process box color gradient (green -> blue -> purple)
  process_start = p.matcha,
  process_mid = p.oceanblue.desaturate(10),
  process_end = p.lavender,
}

-- Key order for btop theme file format
local key_order = {
  "main_bg",
  "main_fg",
  "title",
  "hi_fg",
  "selected_bg",
  "selected_fg",
  "inactive_fg",
  "graph_text",
  "meter_bg",
  "proc_misc",
  "cpu_box",
  "mem_box",
  "net_box",
  "proc_box",
  "div_line",
  "temp_start",
  "temp_mid",
  "temp_end",
  "cpu_start",
  "cpu_mid",
  "cpu_end",
  "free_start",
  "free_mid",
  "free_end",
  "cached_start",
  "cached_mid",
  "cached_end",
  "available_start",
  "available_mid",
  "available_end",
  "used_start",
  "used_mid",
  "used_end",
  "download_start",
  "download_mid",
  "download_end",
  "upload_start",
  "upload_mid",
  "upload_end",
  "process_start",
  "process_mid",
  "process_end",
}

-- Transform for contrib/btop/lavi.theme
local function transform(compiled)
  local lines = {
    "# Lavi theme for btop",
    "# https://github.com/b0o/lavi.nvim",
    "",
  }

  for _, k in ipairs(key_order) do
    local v = compiled[k]
    if v ~= nil then
      local value = type(v) == "string" and v or tostring(v)
      table.insert(lines, string.format('theme[%s]="%s"', k, value))
    end
  end

  return lines
end

return {
  colors = colors,
  transform = transform,
}
