-- Shared transform utilities for theme generation

local M = {}

-- Check if a value is a lush color object
function M.is_lush_color(v)
  return type(v) == "table" and type(v.hsl) == "table"
end

-- Compile a palette table, converting lush colors to hex strings
function M.compile_palette(palette)
  return vim.iter(pairs(palette)):fold({}, function(acc, k, v)
    if type(v) == "table" then
      if M.is_lush_color(v) then
        acc[k] = tostring(v)
      else
        acc[k] = M.compile_palette(v)
      end
    else
      acc[k] = v
    end
    return acc
  end)
end

-- Transform to Lua table format
function M.to_lua(theme)
  local lines = vim.split(vim.inspect(vim.json.decode(vim.json.encode(theme, { sort_keys = true })), {}), "\n")
  lines[1] = "return {"
  return lines
end

-- Helper to convert a Lua value to JSON with sorted keys (deterministic output)
local function lua_to_json(value, indent)
  indent = indent or ""
  local next_indent = indent .. "  "

  if type(value) == "string" then
    -- Escape special characters in strings
    local escaped = value:gsub("\\", "\\\\"):gsub('"', '\\"'):gsub("\n", "\\n"):gsub("\r", "\\r"):gsub("\t", "\\t")
    return string.format('"%s"', escaped)
  elseif type(value) == "number" then
    return tostring(value)
  elseif type(value) == "boolean" then
    return value and "true" or "false"
  elseif value == vim.NIL or value == nil then
    return "null"
  elseif M.is_lush_color(value) then
    return string.format('"%s"', tostring(value))
  elseif type(value) == "table" then
    -- Check if it's an array (sequential integer keys starting at 1)
    local is_array = #value > 0
    if is_array then
      local items = {}
      for _, v in ipairs(value) do
        table.insert(items, next_indent .. lua_to_json(v, next_indent))
      end
      return "[\n" .. table.concat(items, ",\n") .. "\n" .. indent .. "]"
    else
      -- It's an object - sort keys for deterministic output
      local items = {}
      local keys = vim.tbl_keys(value)
      table.sort(keys)
      for _, k in ipairs(keys) do
        local v = value[k]
        table.insert(items, string.format('%s"%s": %s', next_indent, k, lua_to_json(v, next_indent)))
      end
      return "{\n" .. table.concat(items, ",\n") .. "\n" .. indent .. "}"
    end
  else
    return '""' -- fallback
  end
end

-- Transform to JSON format with deterministic key ordering
function M.to_json(theme)
  return vim.split(lua_to_json(theme), "\n")
end

-- Transform to KDL format
function M.to_kdl(theme, top_level)
  top_level = top_level == nil or top_level
  local indent = top_level and "" or "  "
  local theme_items = vim.iter(vim.deepcopy(theme)):totable()

  table.sort(theme_items, function(a, b)
    local a_key, a_val = a[1], a[2]
    local b_key, b_val = b[1], b[2]
    if M.is_lush_color(a_val) and not M.is_lush_color(b_val) then
      return true
    elseif not M.is_lush_color(a_val) and M.is_lush_color(b_val) then
      return false
    end
    return a_key < b_key
  end)

  return vim.iter(theme_items):fold({}, function(acc, e)
    local k, v = unpack(e)
    local lines = {}
    if type(v) == "table" and (type(v.hex) ~= "string") then
      table.insert(lines, k .. " {")
      vim.list_extend(lines, M.to_kdl(v, false))
      table.insert(lines, "}")
    else
      table.insert(lines, k .. ' "' .. tostring(v) .. '"')
    end
    vim.list_extend(
      acc,
      vim
        .iter(lines)
        :map(function(line)
          return indent .. line
        end)
        :totable()
    )
    return acc
  end)
end

-- Transform to TOML format
function M.to_toml(theme, prefix)
  prefix = prefix or ""
  local lines = {}

  -- Separate tables from simple values
  local simple_values = {}
  local tables = {}
  local arrays = {}

  for k, v in pairs(theme) do
    if type(v) == "table" then
      if v[1] ~= nil then
        -- It's an array
        arrays[k] = v
      elseif M.is_lush_color(v) then
        simple_values[k] = tostring(v)
      elseif v.color or v.bg_color or v.bold ~= nil then
        -- Inline table for text styling
        simple_values[k] = v
      else
        tables[k] = v
      end
    else
      simple_values[k] = v
    end
  end

  -- Write simple values first
  local sorted_keys = vim.tbl_keys(simple_values)
  table.sort(sorted_keys)
  for _, k in ipairs(sorted_keys) do
    local v = simple_values[k]
    if type(v) == "table" then
      -- Inline table (text styling)
      local parts = {}
      if v.color then
        table.insert(parts, string.format('color = "%s"', tostring(v.color)))
      end
      if v.bg_color then
        table.insert(parts, string.format('bg_color = "%s"', tostring(v.bg_color)))
      end
      if v.bold ~= nil then
        table.insert(parts, string.format("bold = %s", tostring(v.bold)))
      end
      table.insert(lines, string.format("%s = { %s }", k, table.concat(parts, ", ")))
    else
      table.insert(lines, string.format('%s = "%s"', k, v))
    end
  end

  -- Write arrays
  local sorted_array_keys = vim.tbl_keys(arrays)
  table.sort(sorted_array_keys)
  for _, k in ipairs(sorted_array_keys) do
    local arr = arrays[k]
    local items = {}
    for _, item in ipairs(arr) do
      table.insert(items, string.format('"%s"', tostring(item)))
    end
    table.insert(lines, string.format("%s = [\n  %s,\n]", k, table.concat(items, ",\n  ")))
  end

  -- Write nested tables
  local sorted_table_keys = vim.tbl_keys(tables)
  table.sort(sorted_table_keys)
  for _, k in ipairs(sorted_table_keys) do
    local section = prefix ~= "" and (prefix .. "." .. k) or k
    table.insert(lines, "")
    table.insert(lines, string.format("[%s]", section))
    vim.list_extend(lines, M.to_toml(tables[k], section))
  end

  return lines
end

-- Helper to convert a Lua value to Nix syntax
-- Options:
--   strip_hash: remove leading # from hex color strings
--   quote_keys: wrap keys in quotes (for keys with special chars like "end")
function M.lua_to_nix(value, indent, opts)
  indent = indent or ""
  opts = opts or {}
  local next_indent = indent .. "  "

  if type(value) == "string" then
    local str = value
    if opts.strip_hash then
      str = str:gsub("^#", "")
    end
    return string.format('"%s"', str)
  elseif type(value) == "number" then
    return tostring(value)
  elseif type(value) == "boolean" then
    return value and "true" or "false"
  elseif M.is_lush_color(value) then
    local str = tostring(value)
    if opts.strip_hash then
      str = str:gsub("^#", "")
    end
    return string.format('"%s"', str)
  elseif type(value) == "table" then
    -- Check if it's an array (sequential integer keys starting at 1)
    local is_array = #value > 0
    if is_array then
      local items = {}
      for _, v in ipairs(value) do
        table.insert(items, next_indent .. M.lua_to_nix(v, next_indent, opts))
      end
      return "[\n" .. table.concat(items, "\n") .. "\n" .. indent .. "]"
    else
      -- It's an object/attrset
      local items = {}
      local keys = vim.tbl_keys(value)
      table.sort(keys)
      for _, k in ipairs(keys) do
        local v = value[k]
        -- Quote keys that need it (contain special chars or are reserved words)
        local key_str = k
        if k:match("[^%w_]") or k == "end" or k == "if" or k == "then" or k == "else" then
          key_str = string.format('"%s"', k)
        end
        table.insert(items, string.format("%s%s = %s;", next_indent, key_str, M.lua_to_nix(v, next_indent, opts)))
      end
      return "{\n" .. table.concat(items, "\n") .. "\n" .. indent .. "}"
    end
  else
    return '""' -- fallback
  end
end

-- Transform a Lua table to Nix format, returning lines
-- Options:
--   header: string or table of strings to add as comments at the top
--   strip_hash: remove leading # from hex color strings
function M.to_nix(theme, opts)
  opts = opts or {}
  local lines = {}

  -- Add header comment(s)
  if opts.header then
    if type(opts.header) == "string" then
      table.insert(lines, "# " .. opts.header)
    else
      for _, h in ipairs(opts.header) do
        table.insert(lines, "# " .. h)
      end
    end
  end

  -- Convert the theme to Nix
  local nix_str = M.lua_to_nix(theme, "", { strip_hash = opts.strip_hash })
  vim.list_extend(lines, vim.split(nix_str, "\n"))

  return lines
end

-- Plist XML generation utilities
M.plist = {}

local plist_array_mt = {}

-- Create a plist dict from a table
-- Usage: plist.dict({ key1 = val1, key2 = val2, ... })
-- Keys are sorted alphabetically in the output for deterministic generation.
function M.plist.dict(tbl)
  return tbl
end

-- Create a plist array
-- Usage: plist.array(val1, val2, ...)
function M.plist.array(...)
  return setmetatable({ ... }, plist_array_mt)
end

-- Escape special XML characters
local function xml_escape(s)
  return s:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub('"', "&quot;")
end

-- Serialize a value to plist XML lines
local function plist_serialize(value, indent)
  indent = indent or ""
  local next_indent = indent .. "  "

  if type(value) == "table" then
    if getmetatable(value) == plist_array_mt then
      local lines = { indent .. "<array>" }
      for _, item in ipairs(value) do
        vim.list_extend(lines, plist_serialize(item, next_indent))
      end
      table.insert(lines, indent .. "</array>")
      return lines
    elseif M.is_lush_color(value) then
      return { indent .. "<string>" .. tostring(value) .. "</string>" }
    else
      -- Dict: sorted keys for deterministic output
      local lines = { indent .. "<dict>" }
      local keys = vim.tbl_keys(value)
      table.sort(keys)
      for _, k in ipairs(keys) do
        table.insert(lines, next_indent .. "<key>" .. xml_escape(tostring(k)) .. "</key>")
        vim.list_extend(lines, plist_serialize(value[k], next_indent))
      end
      table.insert(lines, indent .. "</dict>")
      return lines
    end
  elseif type(value) == "string" then
    return { indent .. "<string>" .. xml_escape(value) .. "</string>" }
  elseif type(value) == "number" then
    if math.floor(value) == value then
      return { indent .. "<integer>" .. tostring(value) .. "</integer>" }
    else
      return { indent .. "<real>" .. tostring(value) .. "</real>" }
    end
  elseif type(value) == "boolean" then
    return { indent .. (value and "<true/>" or "<false/>") }
  else
    return { indent .. "<string>" .. xml_escape(tostring(value)) .. "</string>" }
  end
end

-- Generate a complete plist XML document from a plist value
-- Returns an array of lines
function M.plist.to_xml(value)
  local lines = {
    '<?xml version="1.0" encoding="UTF-8"?>',
    '<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">',
    '<plist version="1.0">',
  }
  vim.list_extend(lines, plist_serialize(value, "  "))
  table.insert(lines, "</plist>")
  return lines
end

return M
