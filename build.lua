vim.env.LAZY_STDPATH = "build/.nvim"
load(vim.fn.system("curl -s https://raw.githubusercontent.com/folke/lazy.nvim/main/bootstrap.lua"))()

local function project_root()
  return vim.fn.fnamemodify(debug.getinfo(2, "S").source:sub(2):match("(.*/)"), ":p:h")
end

require("lazy.minit").setup({
  spec = {
    "rktjmp/lush.nvim",
    "rktjmp/shipwright.nvim",
  },
})

vim.opt.rtp:prepend(project_root())

-- Import shared transforms
local transforms = require("lush_theme.lavi.transforms")

vim.api.nvim_create_user_command("LaviBuild", function()
  local builder = require("shipwright.builder")
  local palette = require("lush_theme.lavi.palette")

  -- TODO: vivid
  -- TODO: delta

  -- Neovim theme
  builder.run(
    require("lush_theme.lavi"),
    require("shipwright.transform.lush").to_lua,
    { require("shipwright.transform.patchwrite"), "colors/lavi.lua", "-- PATCH_OPEN", "-- PATCH_CLOSE" }
  )

  -- Compiled palette for consumers
  builder.run(
    palette,
    transforms.compile_palette,
    transforms.to_lua,
    { require("shipwright.transform.overwrite"), "lua/lavi/palette.lua" }
  )

  -- Lualine theme
  builder.run(
    require("lush_theme.lavi.lualine"),
    transforms.to_lua,
    { require("shipwright.transform.overwrite"), "lua/lualine/themes/lavi.lua" }
  )

  -- Alacritty
  local alacritty = require("lush_theme.lavi.alacritty")
  builder.run(
    alacritty.colors,
    transforms.compile_palette,
    alacritty.transform,
    { require("shipwright.transform.overwrite"), "contrib/alacritty/lavi.toml" }
  )
  builder.run(
    alacritty.colors,
    transforms.compile_palette,
    alacritty.transform_nix,
    { require("shipwright.transform.overwrite"), "nix/themes/alacritty.nix" }
  )

  -- Foot
  local foot = require("lush_theme.lavi.foot")
  builder.run(
    foot.colors,
    transforms.compile_palette,
    foot.transform,
    { require("shipwright.transform.overwrite"), "contrib/foot/lavi.ini" }
  )
  builder.run(
    foot.colors,
    transforms.compile_palette,
    foot.transform_nix,
    { require("shipwright.transform.overwrite"), "nix/themes/foot.nix" }
  )

  -- Ghostty
  local ghostty = require("lush_theme.lavi.ghostty")
  builder.run(
    ghostty.colors,
    transforms.compile_palette,
    ghostty.transform,
    { require("shipwright.transform.overwrite"), "contrib/ghostty/lavi.conf" }
  )
  builder.run(
    ghostty.colors,
    transforms.compile_palette,
    ghostty.transform_nix,
    { require("shipwright.transform.overwrite"), "nix/themes/ghostty.nix" }
  )

  -- Kitty
  local kitty = require("lush_theme.lavi.kitty")
  builder.run(
    kitty.colors,
    transforms.compile_palette,
    kitty.transform,
    { require("shipwright.transform.overwrite"), "contrib/kitty/lavi.conf" }
  )

  -- Wezterm
  local wezterm = require("lush_theme.lavi.wezterm")
  builder.run(
    wezterm.colors,
    transforms.compile_palette,
    wezterm.transform,
    { require("shipwright.transform.overwrite"), "contrib/wezterm/lavi.toml" }
  )

  -- Windows Terminal (uses shipwright's built-in transform, needs flat palette)
  local wt_palette = vim.tbl_extend("force", { name = "lavi" }, palette)
  wt_palette.ansi = nil
  builder.run(
    wt_palette,
    require("shipwright.transform.contrib.windows_terminal"),
    { require("shipwright.transform.overwrite"), "contrib/windows_terminal/lavi.json" }
  )

  -- Bottom
  local bottom = require("lush_theme.lavi.bottom")
  builder.run(
    bottom.colors,
    transforms.compile_palette,
    bottom.transform,
    { require("shipwright.transform.overwrite"), "contrib/bottom/lavi.toml" }
  )
  builder.run(
    bottom.colors,
    transforms.compile_palette,
    bottom.transform_nix,
    { require("shipwright.transform.overwrite"), "nix/themes/bottom.nix" }
  )

  -- Btop
  local btop = require("lush_theme.lavi.btop")
  builder.run(
    btop.colors,
    transforms.compile_palette,
    btop.transform,
    { require("shipwright.transform.overwrite"), "contrib/btop/lavi.theme" }
  )

  -- OpenCode
  builder.run(
    require("lush_theme.lavi.opencode"),
    transforms.compile_palette,
    transforms.to_json,
    { require("shipwright.transform.overwrite"), "contrib/opencode/lavi.json" }
  )

  -- Zellij
  local zellij = require("lush_theme.lavi.zellij")
  builder.run(zellij.colors, zellij.transform, { require("shipwright.transform.overwrite"), "contrib/zellij/lavi.kdl" })

  -- Dank Material Shell
  local dms = require("lush_theme.lavi.dank-material-shell")
  builder.run(
    dms.colors,
    transforms.compile_palette,
    dms.transform,
    { require("shipwright.transform.overwrite"), "contrib/dank-material-shell/lavi.json" }
  )

  -- Clipse
  local clipse = require("lush_theme.lavi.clipse")
  builder.run(
    clipse.colors,
    transforms.compile_palette,
    clipse.transform,
    { require("shipwright.transform.overwrite"), "contrib/clipse/lavi.json" }
  )
  builder.run(
    clipse.colors,
    transforms.compile_palette,
    clipse.transform_nix,
    { require("shipwright.transform.overwrite"), "nix/themes/clipse.nix" }
  )

  -- TextMate (for bat and other TextMate-compatible apps)
  local textmate = require("lush_theme.lavi.textmate")
  builder.run(
    textmate.colors,
    transforms.compile_palette,
    textmate.transform,
    { require("shipwright.transform.overwrite"), "contrib/textmate/lavi.tmTheme" }
  )

  -- Base16 (for Stylix)
  local base16 = require("lush_theme.lavi.base16")
  builder.run(
    base16.colors,
    transforms.compile_palette,
    base16.transform,
    { require("shipwright.transform.overwrite"), "contrib/base16/lavi.yaml" }
  )
end, {})
