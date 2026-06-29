---@type lavi.ConfigBase
local default_config = {
  transparent = false,
}

---@param dev boolean Whether this is the runtime (lush) dev colorscheme
---@param colors table
---@param name? string Colorscheme name (e.g. "lavi-sodium"); defaults per variant
local setup = function(dev, colors, name)
  local cfg = vim.tbl_deep_extend("force", default_config, vim.g.lavi_config or {})
  if cfg.transparent then
    for _, group in pairs({
      "Normal",
      "NormalNC",
      "NormalFloat",
      "NormalFloatNC",
      "NvimTreeNormal",
      "NvimTreeNormalNC",
      "FylerNormal",
      "FylerNormalNC",
    }) do
      colors[group].bg = "NONE"
    end
  end

  vim.cmd.highlight("clear")

  vim.o.background = "dark"
  vim.g.colors_name = name or (dev and "lavi_dev" or "lavi")

  if dev then
    require("lush")(colors)
  else
    for group, attrs in pairs(colors) do
      vim.api.nvim_set_hl(0, group, attrs)
    end
  end
end

return setup
