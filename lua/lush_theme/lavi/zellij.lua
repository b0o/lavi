local p = require("lush_theme.lavi.palette")
local transforms = require("lush_theme.lavi.transforms")

local colors = {
  themes = {
    lavi = {
      bg = p.bg,
      fg = p.fg,
      red = p.red,
      green = p.green,
      blue = p.blue,
      yellow = p.yellow,
      magenta = p.magenta,
      orange = p.orange,
      cyan = p.cyan,
      black = p.dark_bg,
      white = p.fg,

      text_unselected = {
        base = p.fg,
        background = p.bg,
        emphasis_0 = p.orange,
        emphasis_1 = p.green,
        emphasis_2 = p.yellow,
        emphasis_3 = p.blue,
      },

      text_selected = {
        base = p.bright_white,
        background = p.med_black,
        emphasis_0 = p.cayenne.lighten(5),
        emphasis_1 = p.bright_green,
        emphasis_2 = p.bright_yellow,
        emphasis_3 = p.oceanblue,
      },

      ribbon_unselected = {
        base = p.fg_dim,
        background = p.deep_lavender,
        emphasis_0 = p.red,
        emphasis_1 = p.green,
        emphasis_2 = p.yellow,
        emphasis_3 = p.blue,
      },

      ribbon_selected = {
        base = p.bg,
        background = p.green.mix(p.yellow, 30).mix(p.bright_white, 45),
        emphasis_0 = p.cayenne.lighten(5),
        emphasis_1 = p.bright_green,
        emphasis_2 = p.bright_yellow,
        emphasis_3 = p.oceanblue,
      },

      table_title = {
        base = p.bright_white,
        background = p.licorice,
        emphasis_0 = p.violet,
        emphasis_1 = p.cyan,
        emphasis_2 = p.yellow,
        emphasis_3 = p.blue,
      },

      table_cell_unselected = {
        base = p.fg_nc,
        background = p.bg,
        emphasis_0 = p.red,
        emphasis_1 = p.green,
        emphasis_2 = p.yellow,
        emphasis_3 = p.oceanblue,
      },

      table_cell_selected = {
        base = p.bright_white,
        background = p.deep_anise,
        emphasis_0 = p.cayenne.lighten(5),
        emphasis_1 = p.bright_green,
        emphasis_2 = p.bright_yellow,
        emphasis_3 = p.oceanblue,
      },

      list_unselected = {
        base = p.fg_dim,
        background = p.bg,
        emphasis_0 = p.red,
        emphasis_1 = p.green,
        emphasis_2 = p.yellow,
        emphasis_3 = p.oceanblue,
      },

      list_selected = {
        base = p.bright_white,
        background = p.deep_anise,
        emphasis_0 = p.cayenne.lighten(5),
        emphasis_1 = p.bright_green,
        emphasis_2 = p.bright_yellow,
        emphasis_3 = p.oceanblue,
      },

      frame_unselected = {
        base = p.bright_black.darken(10),
        background = p.bg,
        emphasis_0 = p.red,
        emphasis_1 = p.green,
        emphasis_2 = p.bright_violet,
        emphasis_3 = p.oceanblue,
      },

      frame_selected = {
        base = p.blue,
        background = p.bg,
        emphasis_0 = p.red,
        emphasis_1 = p.green,
        emphasis_2 = p.bright_violet,
        emphasis_3 = p.oceanblue,
      },

      frame_highlight = {
        base = p.green.mix(p.yellow, 30).mix(p.bright_white, 45),
        background = p.black,
        emphasis_0 = p.red,
        emphasis_1 = p.green,
        emphasis_2 = p.yellow,
        emphasis_3 = p.oceanblue,
      },

      exit_code_success = {
        base = p.green,
        background = p.bg,
        emphasis_0 = p.red,
        emphasis_1 = p.cyan,
        emphasis_2 = p.yellow,
        emphasis_3 = p.oceanblue,
      },

      exit_code_error = {
        base = p.cayenne.lighten(5),
        background = p.bg,
        emphasis_0 = p.red,
        emphasis_1 = p.green,
        emphasis_2 = p.yellow,
        emphasis_3 = p.oceanblue,
      },

      multiplayer_user_colors = {
        player_1 = p.blue,
        player_2 = p.lavender,
        player_3 = p.cyan,
        player_4 = p.green,
        player_5 = p.violet,
        player_6 = p.skyblue,
        player_7 = p.yellow,
        player_8 = p.orange,
        player_9 = p.red,
        player_10 = p.bright_violet,
      },
    },
  },
}

-- Transform for contrib/zellij/lavi.kdl
local function transform(compiled)
  return transforms.to_kdl(compiled)
end

return {
  colors = colors,
  transform = transform,
}
