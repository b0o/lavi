---@type lavi.ConfigBase
local default_config = {
  transparent = false,
}

---@param colors table
---@param config? lavi.Config
local setup = function(dev, colors, config)
  local cfg = vim.tbl_deep_extend("force", default_config, config or vim.g.lavi_config or {})
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
  vim.g.colors_name = dev and "lavi_dev" or "lavi"

  if dev then
    require("lush")(colors)
  else
    for group, attrs in pairs(colors) do
      vim.api.nvim_set_hl(0, group, attrs)
    end
  end
end

return setup
