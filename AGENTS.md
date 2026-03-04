# AGENTS.md

Lavi is a Neovim colorscheme with theme generators for terminal emulators and CLI tools. The palette is defined once in Lua using [lush.nvim](https://github.com/rktjmp/lush.nvim) and compiled into output files for each supported application.

## Project Structure

```
lavi/
├── lua/lush_theme/lavi/         # SOURCE - edit these files
│   ├── palette.lua              # Canonical color palette (lush hsl colors)
│   ├── lavi.lua                 # Neovim highlight groups
│   ├── init.lua                 # Entry point (returns lavi.lua)
│   ├── lualine.lua              # Lualine statusline theme
│   ├── transforms.lua           # Shared build helpers (to_json, to_nix, to_toml, to_kdl, compile_palette)
│   ├── alacritty.lua            # Theme generators for external apps
│   ├── bottom.lua               #   Each exports: colors, transform, [transform_nix]
│   ├── btop.lua
│   ├── clipse.lua
│   ├── dank-material-shell.lua
│   ├── foot.lua
│   ├── ghostty.lua
│   ├── kitty.lua
│   ├── opencode.lua
│   ├── wezterm.lua
│   ├── zellij.lua
│   └── base16.lua
│
├── lua/lavi/                    # SOURCE - runtime support files
│   ├── init.lua                 # Module annotations
│   ├── setup.lua                # Colorscheme setup (applies config + highlight groups)
│   └── types.lua                # Type definitions (lavi.Config)
│
├── colors/lavi.lua              # GENERATED - compiled neovim colorscheme
├── colors/lavi_dev.lua          # SOURCE - development colorscheme loader (uses lush at runtime)
├── lua/lavi/palette.lua         # GENERATED - compiled palette (plain hex strings, no lush)
├── lua/lualine/themes/lavi.lua  # GENERATED - compiled lualine theme
├── contrib/                     # GENERATED - theme files for each app
│   ├── alacritty/lavi.toml
│   ├── base16/lavi.yaml
│   ├── bottom/lavi.toml
│   ├── btop/lavi.theme
│   ├── clipse/lavi.json
│   ├── dank-material-shell/lavi.json
│   ├── foot/lavi.ini
│   ├── ghostty/lavi.conf
│   ├── kitty/lavi.conf
│   ├── opencode/lavi.json
│   ├── wezterm/lavi.toml
│   ├── windows_terminal/lavi.json
│   └── zellij/lavi.kdl
├── nix/themes/                  # GENERATED - nix expressions for home-manager
│   ├── alacritty.nix
│   ├── bottom.nix
│   ├── clipse.nix
│   ├── foot.nix
│   └── ghostty.nix
│
├── build.lua                    # Build orchestrator
├── justfile                     # Build commands
├── flake.nix                    # Nix flake (packages, home-manager module, dev shell)
└── nix/homeManagerModules/
    └── default.nix              # Home-manager module with per-app enable options
```

## Source vs Generated Files

Source files live in two locations:

- `lua/lush_theme/lavi/` - palette, highlight groups, and theme generators
- `lua/lavi/` - runtime support (setup, types, module annotations)
- `colors/lavi_dev.lua` - development colorscheme loader

Generated files (do not edit directly):

- `colors/lavi.lua` - compiled neovim colorscheme
- `lua/lavi/palette.lua` - compiled palette (plain hex strings, no lush)
- `lua/lualine/themes/` - compiled lualine theme
- `contrib/` - theme files for external apps
- `nix/themes/` - nix expressions

CI will auto-regenerate and commit these on pushes to main. PRs will fail if generated files are stale.

## Build System

The build pipeline uses [lush.nvim](https://github.com/rktjmp/lush.nvim) for color manipulation and [shipwright.nvim](https://github.com/rktjmp/shipwright.nvim) for running build transforms.

### How it works

`build.lua` bootstraps lazy.nvim, loads lush + shipwright, and defines the `LaviBuild` command. Each theme generator is registered with `builder.run()`:

```lua
builder.run(
  module.colors,                    -- table of lush color objects
  transforms.compile_palette,       -- converts lush hsl -> hex strings
  module.transform,                 -- app-specific formatter -> array of lines
  { overwrite, "contrib/app/file" } -- writes lines to output file
)
```

Some generators have a second `builder.run()` call for the nix output using `transform_nix`.

### Build commands

Both methods generate themes and format in a single step:

```bash
# With just (requires neovim, stylua, dprint):
just build

# With nix:
nix develop -c lavi-build

# Verify generated files match source:
nix flake check
```

## Color Palette

The palette is defined in `lua/lush_theme/lavi/palette.lua` using lush's `hsl()` function. Colors support manipulation methods:

```lua
p.red.lighten(10)
p.cyan.desaturate(20).darken(5)
p.bg.mix(p.green, 15)
p.blue.rotate(20).saturate(30)
```

## Adding a New Theme Generator

### 1. Create the generator

Create `lua/lush_theme/lavi/<app>.lua`. Reference the neovim highlight groups and use color manipulation rather than raw palette values:

```lua
local p = require("lush_theme.lavi.palette")
local lavi = require("lush_theme.lavi")
local transforms = require("lush_theme.lavi.transforms")

local colors = {
  bg = lavi.Normal.bg,
  fg = lavi.Normal.fg,
  accent = lavi.Statement.fg,
  dimmed = lavi.Comment.fg,
  highlight = p.cyan.desaturate(10).lighten(50),
  -- ...
}

local function transform(compiled)
  -- compiled contains hex strings (after compile_palette)
  -- return an array of lines in the app's config format
  return transforms.to_json(compiled) -- or to_toml, custom formatting, etc.
end

-- Optional: only needed if home-manager has structured settings for this app
local function transform_nix(compiled)
  return transforms.to_nix(compiled, {
    header = {
      "Auto-generated by build.lua - do not edit manually",
      "For use with home-manager's programs.<app>.settings",
    },
  })
end

return {
  colors = colors,
  transform = transform,
  transform_nix = transform_nix, -- omit if not needed
}
```

Look at existing generators for patterns:

- **Simple flat JSON**: `clipse.lua`, `dank-material-shell.lua`
- **Nested structure with nix**: `bottom.lua`, `alacritty.lua`, `foot.lua`
- **Custom format**: `btop.lua` (key=value), `kitty.lua` / `ghostty.lua` (conf), `zellij.lua` (KDL)
- **Raw color table** (no module wrapper): `opencode.lua` — returns a plain table, registered directly in `build.lua` with `transforms.to_json`

### 2. Create the output directory

```bash
mkdir -p contrib/<app>
```

### 3. Register in `build.lua`

```lua
local app = require("lush_theme.lavi.<app>")
builder.run(
  app.colors,
  transforms.compile_palette,
  app.transform,
  { require("shipwright.transform.overwrite"), "contrib/<app>/lavi.<ext>" }
)
-- If transform_nix exists:
builder.run(
  app.colors,
  transforms.compile_palette,
  app.transform_nix,
  { require("shipwright.transform.overwrite"), "nix/themes/<app>.nix" }
)
```

### 4. Add to `flake.nix`

Add to the `lib.themes` attrset:

```nix
<app> = builtins.readFile ./contrib/<app>/lavi.<ext>;
```

### 5. Add to home-manager module

In `nix/homeManagerModules/default.nix`:

Add the option:

```nix
<app>.enable = lib.mkEnableOption "Lavi theme for <App>";
```

Add the config (choose the appropriate strategy):

```nix
# Structured nix import (when you have a nix/themes/<app>.nix):
(lib.mkIf cfg.<app>.enable {
  programs.<app>.settings = import ../themes/<app>.nix;
})

# File copy (when the app reads a theme file from disk):
(lib.mkIf cfg.<app>.enable {
  xdg.configFile."<app>/themes/lavi.<ext>".source = ../../contrib/<app>/lavi.<ext>;
})

# Extra config (for apps with an extraConfig option):
(lib.mkIf cfg.<app>.enable {
  programs.<app>.extraConfig = builtins.readFile ../../contrib/<app>/lavi.<ext>;
})

# From JSON (for apps with a JSON-typed attrset option):
(lib.mkIf cfg.<app>.enable {
  programs.<app>.themes.lavi = builtins.fromJSON (
    builtins.readFile ../../contrib/<app>/lavi.json
  );
})
```

Check the app's home-manager module to determine which strategy fits.

### 6. Add to README.md

Add a collapsible section under "Other Programs" in alphabetical order.

### 7. Build and verify

```bash
just build
```

Commit both the source file and all generated output.

## Shared Transforms

`lua/lush_theme/lavi/transforms.lua` provides:

| Function                          | Purpose                                                |
| --------------------------------- | ------------------------------------------------------ |
| `compile_palette(tbl)`            | Recursively converts lush hsl objects to hex strings   |
| `to_lua(tbl)`                     | Formats as a Lua table (`return { ... }`)              |
| `to_json(tbl)`                    | Formats as JSON with sorted keys                       |
| `to_nix(tbl, opts)`               | Formats as a Nix attrset with optional header comments |
| `to_toml(tbl, prefix)`            | Formats as TOML with nested sections                   |
| `to_kdl(tbl, top_level)`          | Formats as KDL                                         |
| `lua_to_nix(value, indent, opts)` | Low-level Nix value formatter                          |
| `is_lush_color(v)`                | Returns true if value is a lush color object           |

## Nix Outputs

| Output                            | Description                                       |
| --------------------------------- | ------------------------------------------------- |
| `packages.<system>.lavi-nvim`     | Minimal Neovim plugin (no lush dependency)        |
| `packages.<system>.lavi-nvim-dev` | Full source including lush theme files            |
| `packages.<system>.lavi-themes`   | All files from `contrib/`                         |
| `packages.<system>.lavi-build`    | Build script (`lavi-build` command)               |
| `lib.themes.<app>`                | Raw theme content as strings                      |
| `lib.base16`                      | Base16 color scheme for Stylix                    |
| `homeManagerModules.lavi`         | Home-manager module with per-app `enable` options |
| `devShells.<system>.default`      | Dev shell with build tools                        |
| `checks.themes-up-to-date`        | Verifies committed files match generated output   |

## CI

`.github/workflows/generate.yml`:

- **Push to main**: regenerates themes, auto-commits if changed
- **PRs**: fails if generated files are stale

Always run `just build` (or `nix develop -c lavi-build`) before committing.
