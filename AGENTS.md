# AGENTS.md

Lavi is a Neovim colorscheme with theme generators for terminal emulators and CLI tools. The palette is defined once in Lua using [lush.nvim](https://github.com/rktjmp/lush.nvim) and compiled into output files for each supported application.

## Project Structure

```
lavi/
├── lua/lush_theme/lavi/         # SOURCE - edit these files
│   ├── palette/                 # Canonical color palette (variant-aware)
│   │   ├── init.lua             #   Resolver: picks the active variant and builds it
│   │   ├── build.lua            #   Builder: derives the full palette from seed colors
│   │   └── variants/            #   Per-variant seed colors
│   │       ├── lavi.lua         #     Default variant (the base seed set)
│   │       ├── deep.lua         #     Dark, low-contrast slate neutral treatment
│   │       └── deep-ember.lua   #     deep + sodium-style accents (extends deep.lua)
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
│   ├── pi.lua
│   ├── textmate.lua
│   ├── wezterm.lua
│   ├── zellij.lua
│   └── base16.lua
│
├── lua/lavi/                    # SOURCE - runtime support files
│   ├── init.lua                 # Module annotations
│   ├── setup.lua                # Colorscheme setup (applies config + highlight groups)
│   └── types.lua                # Type definitions (lavi.Config)
│
│                                # NOTE: the default "lavi" variant writes the
│                                # unsuffixed paths below; other variants write
│                                # "-<variant>" siblings (e.g. colors/lavi-deep.lua,
│                                # contrib/ghostty/lavi-deep-ember.conf).
├── colors/lavi.lua              # GENERATED - compiled neovim colorscheme
├── colors/lavi_dev.lua          # SOURCE - development colorscheme loader (uses lush at runtime)
├── lua/lavi/palette.lua         # GENERATED - compiled palette (plain hex strings, no lush)
├── lua/lualine/themes/lavi.lua  # GENERATED - compiled lualine theme
├── contrib/                     # GENERATED - theme files + READMEs for each app
│   ├── alacritty/
│   │   ├── lavi.toml
│   │   └── README.md            # Generated from docs metadata in build.lua
│   ├── base16/lavi.yaml
│   ├── bottom/
│   │   ├── lavi.toml
│   │   └── README.md
│   ├── btop/
│   │   ├── lavi.theme
│   │   └── README.md
│   ├── clipse/
│   │   ├── lavi.json
│   │   └── README.md
│   ├── dank-material-shell/
│   │   ├── lavi.json
│   │   └── README.md
│   ├── foot/
│   │   ├── lavi.ini
│   │   └── README.md
│   ├── ghostty/
│   │   ├── lavi.conf
│   │   └── README.md
│   ├── kitty/
│   │   ├── lavi.conf
│   │   └── README.md
│   ├── opencode/
│   │   ├── lavi.json
│   │   └── README.md
│   ├── textmate/
│   │   ├── lavi.tmTheme
│   │   └── README.md
│   ├── wezterm/
│   │   ├── lavi.toml
│   │   └── README.md
│   ├── windows_terminal/
│   │   ├── lavi.json
│   │   └── README.md
│   └── zellij/
│       ├── lavi.kdl
│       └── README.md
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
- `contrib/` - theme files and READMEs for external apps
- `nix/themes/` - nix expressions

Every generated artifact is produced once per variant (see [Variants](#variants)).
The default `lavi` variant keeps the unsuffixed paths above; other variants get
`-<variant>` siblings (`colors/lavi-deep.lua`, `contrib/ghostty/lavi-deep-ember.conf`,
`nix/themes/alacritty-deep.nix`, `lua/lavi/palette-deep.lua`, ...).

CI will auto-regenerate and commit these on pushes to main. PRs will fail if generated files are stale.

## Build System

The build pipeline uses [lush.nvim](https://github.com/rktjmp/lush.nvim) for color manipulation and [shipwright.nvim](https://github.com/rktjmp/shipwright.nvim) for running build transforms.

### How it works

`build.lua` defines the `LaviBuild` command. When lush + shipwright are already on the runtime path (as Nix provides), it uses them directly; otherwise it bootstraps them via lazy.nvim. `LaviBuild` builds **every [variant](#variants) in a loop** — for each variant it selects that variant's seeds, invalidates the `lush_theme.lavi.*` module cache so the palette rebuilds, and writes variant-suffixed outputs (the default `lavi` variant keeps the unsuffixed paths). Contrib themes are registered with the `build_contrib` wrapper:

```lua
build_contrib({
  runs = {
    { module.colors, transforms.compile_palette, module.transform, { overwrite, "contrib/app/file" } },
    { module.colors, transforms.compile_palette, module.transform_nix, { overwrite, "nix/themes/app.nix" } }, -- optional
  },
  docs = {
    name = "App Name",
    url = "https://github.com/...",
    tagline = "Short description",
    contrib_dir = "app",           -- directory under contrib/
    steps = { "Step 1", "Step 2" },
    -- Optional fields:
    subtitle = nil,                -- shown after name in <summary>
    id = nil,                      -- anchor id inside <details> for deep linking
    screenshots = {},              -- list of URLs; first in main README, all in contrib README
    body = nil,                    -- raw markdown (replaces url+tagline+steps)
    extra = nil,                   -- raw markdown appended after steps
  },
})
```

The wrapper runs all `builder.run()` pipelines and collects the `docs` metadata. After all themes are built, it:

1. Generates the "Other Programs" section in `README.md` between `<!-- LAVI_PROGRAMS_OPEN -->` and `<!-- LAVI_PROGRAMS_CLOSE -->` markers
2. Generates `contrib/<app>/README.md` for each theme with a `contrib_dir`

Themes are sorted alphabetically by name in the generated README.

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

The palette is **variant-aware**. `palette/init.lua` resolves the active variant (via `vim.g.lavi_build_variant`, defaulting to `lavi`), loads that variant's seed colors from `palette/variants/<name>.lua`, and passes them to `palette/build.lua`, which derives the full palette. `require("lush_theme.lavi.palette")` returns the built palette for the active variant, so highlight groups and generators are variant-agnostic.

- **Seeds** (`palette/variants/*.lua`) are the raw `hsl()` inputs — the ANSI hues, the `bg1`/`fg2`/`black` bases, and the accents. A variant only lists the seeds that differ from the default and inherits the rest (via `vim.tbl_extend`).
- **`palette/build.lua`** derives everything else from the seeds: the `bg0..bg3` and `fg0..fg3` ladders, the bright ANSI hues, the grey and purple shades, the light-mode values, selection/cursor colors, and the muted terminal ANSI set. Each derived value uses `M.x = M.x or <derivation>`, so a variant can override any derived color by supplying it as a seed.

Colors are lush hsl objects and support manipulation methods:

```lua
p.red.lighten(10)
p.cyan.desaturate(20).darken(5)
p.bg1.mix(p.green, 15)
p.blue.rotate(20).saturate(30)
```

The background/foreground ladders are numeric and luminance-ascending: `bg0` (darkest) → `bg3` (brightest) with `bg1` the Normal background; `fg0` (dimmest) → `fg3` (brightest) with `fg2` the main text color.

## Variants

A variant is a set of seed-color overrides on top of the default `lavi` palette; the shared builder + highlight groups + generators carry that recoloring through every output. The current variants:

| Variant      | Seed file                         | Description                                                                                                                   |
| ------------ | --------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| `lavi`       | `palette/variants/lavi.lua`       | The default: the full base seed set                                                                                           |
| `deep`       | `palette/variants/deep.lua`       | A dark, low-contrast slate neutral treatment (darker/compressed bg + grey ladders, muted text); accents inherited from `lavi` |
| `deep-ember` | `palette/variants/deep-ember.lua` | `deep` neutrals + sodium-style accents (orange primary, indigo secondary, lavender outline); `extends` `deep.lua`             |

Variants can **compose**: a seed file can `require` another variant's seeds and extend them (`deep-ember` layers accents onto `deep`).

The active variant is chosen at **build time** via `vim.g.lavi_build_variant`; `build.lua` loops over the registered variants, invalidating the `lush_theme.lavi.*` module cache between each so the palette rebuilds. The compiled colorschemes are plain hex (no lush at runtime), so nothing reads the resolver at runtime — neovim picks a variant by name (`:colorscheme lavi-deep`), and apps read the variant's generated file.

### Adding a variant

1. Create `palette/variants/<name>.lua`. Return a seed table — extend the base (or another variant) and override only what differs:

   ```lua
   local hsl = require("lush").hsl
   local base = require("lush_theme.lavi.palette.variants.lavi")
   return vim.tbl_extend("force", base, {
     bg1 = hsl("#..."), -- override seeds; derived colors follow, or override them too
   })
   ```

2. Register it in `build.lua`'s `variants` list (`{ name = "<name>", suffix = "-<name>" }`).
3. Add it to the flake's `lib.variants` map and the `lavi.variant` enum in the home-manager module.
4. Run `just build` — it generates `*-<name>` siblings for every output. Some generators branch on `vim.g.lavi_build_variant` for variant-specific behaviour (e.g. `dank-material-shell.lua` uses a compressed container mapping for non-default variants); mirror that pattern if a generator needs it.

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
build_contrib({
  runs = {
    { app.colors, transforms.compile_palette, app.transform, { overwrite, "contrib/<app>/lavi.<ext>" } },
    -- If transform_nix exists:
    { app.colors, transforms.compile_palette, app.transform_nix, { overwrite, "nix/themes/<app>.nix" } },
  },
  docs = {
    name = "App Name",
    url = "https://github.com/...",
    tagline = "Short description of the app",
    contrib_dir = "<app>",
    steps = {
      "Copy [`contrib/<app>/lavi.<ext>`](./contrib/<app>/lavi.<ext>) to `~/.config/<app>/themes/lavi.<ext>`",
      "Set the theme in your config",
    },
  },
})
```

### 4. Add to `flake.nix`

Add to the `mkThemes` helper (it backs both `lib.themes` and the per-variant `lib.variants`):

```nix
<app> = builtins.readFile (./contrib/<app> + "/lavi${sfx}.<ext>");
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

### 6. Build and verify

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

| Output                            | Description                                                            |
| --------------------------------- | ---------------------------------------------------------------------- |
| `packages.<system>.lavi-nvim`     | Minimal Neovim plugin (no lush dependency)                             |
| `packages.<system>.lavi-nvim-dev` | Full source including lush theme files                                 |
| `packages.<system>.lavi-themes`   | All files from `contrib/`                                              |
| `packages.<system>.lavi-build`    | Build script (`lavi-build` command)                                    |
| `lib.themes.<app>`                | Raw theme content as strings (default `lavi` variant)                  |
| `lib.variants.<variant>.<app>`    | Raw theme content per variant (`lavi`, `deep`, `deep-ember`)           |
| `lib.base16`                      | Base16 color scheme for Stylix                                         |
| `homeManagerModules.lavi`         | Home-manager module with per-app `enable` options + a `variant` option |
| `devShells.<system>.default`      | Dev shell with build tools                                             |
| `checks.themes-up-to-date`        | Verifies committed files match generated output                        |

## CI

`.github/workflows/generate.yml`:

- **Push to main**: regenerates themes, auto-commits if changed
- **PRs**: fails if generated files are stale

Always run `just build` (or `nix develop -c lavi-build`) before committing.
