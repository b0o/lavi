# Lavi 🪻

A soft and sweet colorscheme

![Screenshot](https://github.com/user-attachments/assets/a7873a70-4b90-4e92-a11c-f262d9653f29)

## Installation

### Neovim

With [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  'b0o/lavi',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'lavi'
  end,
},
```

With Nix flakes (see [Nix](#nix) section for more options):

```nix
programs.neovim.plugins = [
  inputs.lavi.packages.${pkgs.system}.lavi-nvim
];
```

### Configuration

Lavi can be configured by setting `vim.g.lavi_config` before loading the colorscheme:

```lua
vim.g.lavi_config = {
  transparent = false, -- set to true for a transparent background
}
vim.cmd.colorscheme 'lavi'
```

With [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  'b0o/lavi',
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.lavi_config = {
      transparent = true,
    }
    vim.cmd.colorscheme 'lavi'
  end,
},
```

#### Options

| Option        | Type    | Default | Description            |
| ------------- | ------- | ------- | ---------------------- |
| `transparent` | boolean | `false` | Transparent background |

### Other Programs

<details>
<summary><b>Alacritty</b></summary>

<a href="https://github.com/alacritty/alacritty">Alacritty</a>: Cross-platform, GPU-accelerated terminal emulator

1. Copy [`contrib/alacritty/lavi.toml`](./contrib/alacritty/lavi.toml) to `~/.config/alacritty/lavi.toml`
2. Import into your Alacritty config:
   ```toml
   general.import = [
     "~/.config/alacritty/lavi.toml",
   ]
   ```

</details>

<details>
<summary><b>bat</b></summary>

<a href="https://github.com/sharkdp/bat">bat</a>: A cat clone with syntax highlighting and Git integration

1. Copy [`contrib/textmate/lavi.tmTheme`](./contrib/textmate/lavi.tmTheme) to `~/.config/bat/themes/lavi.tmTheme`
2. Rebuild bat's theme cache:
   ```bash
   bat cache --build
   ```
3. Use the theme:
   ```bash
   bat --theme=lavi file.rs
   ```
   Or set it permanently via `BAT_THEME=lavi` in your environment, or add `--theme="lavi"` to `~/.config/bat/config`.

</details>

<details>
<summary><b>Bottom</b></summary>

<a href="https://github.com/ClementTsang/bottom">Bottom</a>: Graphical process/system monitor for the terminal

1. Copy the contents of [`contrib/bottom/lavi.toml`](./contrib/bottom/lavi.toml) into your `~/.config/bottom/bottom.toml`

</details>

<details>
<summary><b>Btop</b></summary>

<a href="https://github.com/aristocratos/btop">Btop</a>: Resource monitor with a customizable interface

1. Copy [`contrib/btop/lavi.theme`](./contrib/btop/lavi.theme) to `~/.config/btop/themes/lavi.theme`
2. Set `color_theme = "lavi"` in your `~/.config/btop/btop.conf` or select it from the options menu

</details>

<details>
<summary><b>Clipse</b></summary>

<a href="https://github.com/savedra1/clipse">Clipse</a>: Configurable TUI clipboard manager for Unix

1. Copy [`contrib/clipse/lavi.json`](./contrib/clipse/lavi.json) to `~/.config/clipse/custom_theme.json`
2. Set `"themeFile": "custom_theme.json"` in your `~/.config/clipse/config.json`

</details>

<details>
<summary><b>Dank Material Shell</b></summary>

<a href="https://github.com/AvengeMedia/DankMaterialShell">Dank Material Shell</a>: Desktop shell for wayland compositors

1. Copy [`contrib/dank-material-shell/lavi.json`](./contrib/dank-material-shell/lavi.json) to `~/.config/DankMaterialShell/themes/lavi.json`
2. In Settings → Theme & Colors, select **Custom** and set the theme file path to the copied file
3. Alternatively, set `"currentThemeName": "custom"` and `"customThemeFile": "/path/to/lavi.json"` in `~/.config/DankMaterialShell/settings.json`

**Nix/Home-Manager:**

Requires the [DMS home-manager module](https://github.com/AvengeMedia/DankMaterialShell) from the DMS flake:

```nix
# flake.nix inputs:
inputs.dms.url = "github:AvengeMedia/DankMaterialShell/stable";

# home-manager config:
imports = [
  inputs.dms.homeModules.dank-material-shell
  inputs.lavi.homeManagerModules.lavi
];

lavi.dank-material-shell.enable = true;
```

This writes the theme file to `~/.config/DankMaterialShell/themes/lavi.json` and sets `programs.dank-material-shell.settings` to use it as the active custom theme.

</details>

<details>
<summary><b>Foot</b></summary>

<a href="https://codeberg.org/dnkl/foot">Foot</a>: Fast, lightweight Wayland terminal emulator

1. Copy the contents of [`contrib/foot/lavi.ini`](./contrib/foot/lavi.ini) into your `~/.config/foot/foot.ini`

</details>

<details>
<summary><b>Ghostty</b></summary>

<a href="https://github.com/ghostty-org/ghostty">Ghostty</a>: Fast, native terminal emulator with platform-native UI

1. Copy [`contrib/ghostty/lavi.conf`](./contrib/ghostty/lavi.conf) to `~/.config/ghostty/themes/lavi.conf`
2. Set `theme = lavi.conf` in your `~/.config/ghostty/config`

</details>

<details>
<summary><b>Kitty</b></summary>

<a href="https://github.com/kovidgoyal/kitty">Kitty</a>: GPU-accelerated terminal emulator

1. Copy the contents of [`contrib/kitty/lavi.conf`](./contrib/kitty/lavi.conf) into your `~/.config/kitty/themes/lavi.conf`
2. Run `kitty +kitten themes --reload-in=all lavi` to set the theme

</details>

<details>
<summary><b>Opencode</b></summary>

<a href="https://github.com/opencode-ai/opencode">Opencode</a>: TUI for coding with LLMs from the terminal

1. Copy [`contrib/opencode/lavi.json`](./contrib/opencode/lavi.json) to `~/.config/opencode/themes/lavi.json`
2. Set `{ "theme": "lavi" }` in your `~/.config/opencode/opencode.jsonc` or select it from the UI theme picker

</details>

<details>
<summary><b>TextMate Theme</b> (bat, Sublime Text, TextMate, VS Code)</summary>

Lavi provides a `.tmTheme` file at [`contrib/textmate/lavi.tmTheme`](./contrib/textmate/lavi.tmTheme) that works with any application supporting the TextMate theme format. This includes:

- **[bat](https://github.com/sharkdp/bat)** — see the [bat](#other-programs) section above for specific instructions
- **[Sublime Text](https://www.sublimetext.com/)** — copy `lavi.tmTheme` to your `Packages/User/` directory, then select it from Preferences → Color Scheme
- **[TextMate](https://macromates.com/)** — double-click `lavi.tmTheme` to install, or copy it to `~/Library/Application Support/TextMate/Themes/`
- **[VS Code](https://code.visualstudio.com/)** — tmTheme files can be used via the [TmTheme Editor](https://marketplace.visualstudio.com/items?itemName=Youssef.theme-converter) extension or as a base for a [color theme extension](https://code.visualstudio.com/api/extension-guides/color-theme)

</details>

<details>
<summary><b>Wezterm</b></summary>

<a href="https://github.com/wez/wezterm">Wezterm</a>: GPU-accelerated terminal emulator and multiplexer

1. Copy [`contrib/wezterm/lavi.toml`](./contrib/wezterm/lavi.toml) to `~/.config/wezterm/colors/lavi.toml`
2. Set `config.color_scheme = "lavi"` in your Wezterm config

</details>

<details>
<summary><b>Windows Terminal</b></summary>

<a href="https://github.com/microsoft/terminal">Windows Terminal</a>: Modern terminal application for Windows

1. Open the Windows Terminal settings (`ctrl+,`)
2. Select **Open JSON file** at the bottom left corner (`ctrl+shift+,`)
3. Copy the contents of [`contrib/windows_terminal/lavi.json`](./contrib/windows_terminal/lavi.json) inside of the `schemes` array
   ```jsonc
   {
     "schemes": [
       // paste the contents of lavi.json here
     ],
   }
   ```
4. Save and exit
5. In the **Settings** panel under **Profiles**, select the profile you want to use the theme in, then select **Appearance** and choose **lavi** from the **Color scheme** dropdown

</details>

<details>
<summary><b>Zellij</b></summary>

<a href="https://github.com/zellij-org/zellij">Zellij</a>: Terminal workspace and multiplexer

1. Copy [`contrib/zellij/lavi.kdl`](./contrib/zellij/lavi.kdl) to `~/.config/zellij/themes/lavi.kdl`
2. Set `theme "lavi"` in your `~/.config/zellij/config.kdl`

</details>

### Nix

Lavi provides a Nix flake with multiple outputs for flexible integration.

#### Flake Outputs

| Output                            | Description                                               |
| --------------------------------- | --------------------------------------------------------- |
| `packages.<system>.lavi-nvim`     | Minimal Neovim plugin (runtime only, no lush dependency)  |
| `packages.<system>.lavi-nvim-dev` | Full Neovim plugin with lush sources for customization    |
| `packages.<system>.lavi-themes`   | All theme files from `contrib/`                           |
| `lib.themes.<app>`                | Raw theme content as strings (e.g., `lib.themes.ghostty`) |
| `lib.base16`                      | Base16 color scheme for Stylix integration                |
| `homeManagerModules.lavi`         | Home-manager module with per-app options                  |

#### Home-Manager Module

Add to your flake inputs:

```nix
inputs.lavi.url = "github:b0o/lavi";
```

Import and configure:

```nix
{ inputs, pkgs, ... }:
{
  imports = [ inputs.lavi.homeManagerModules.lavi ];

  lavi = {
    neovim.enable = true;    # Adds lavi-nvim to programs.neovim.plugins
    ghostty.enable = true;   # Configures programs.ghostty.themes.lavi
    alacritty.enable = true; # Merges colors into programs.alacritty.settings
    bat.enable = true;       # Installs tmTheme and sets bat theme to Lavi
    kitty.enable = true;     # Appends to programs.kitty.extraConfig
    foot.enable = true;      # Merges into programs.foot.settings
    btop.enable = true;      # Writes theme file and sets color_theme
    bottom.enable = true;    # Merges styles into programs.bottom.settings
    clipse.enable = true;    # Merges theme into services.clipse.theme
    dank-material-shell.enable = true; # Configures programs.dank-material-shell custom theme
    opencode.enable = true;  # Configures programs.opencode.themes.lavi
    wezterm.enable = true;   # Writes theme to wezterm/colors/
    zellij.enable = true;    # Configures programs.zellij.themes.lavi
  };
}
```

#### Stylix Integration

Lavi provides a base16 color scheme for [Stylix](https://github.com/danth/stylix):

```nix
{ inputs, ... }:
{
  stylix.base16Scheme = inputs.lavi.lib.base16;
}
```

This applies the Lavi color palette across all Stylix-supported programs automatically.

#### Manual Installation

For users who manage their own config files:

```nix
# Symlink theme files
home.file.".config/ghostty/themes/lavi.conf".source =
  "${inputs.lavi.packages.${pkgs.system}.lavi-themes}/ghostty/lavi.conf";

# Or use raw content
xdg.configFile."ghostty/themes/lavi.conf".text = inputs.lavi.lib.themes.ghostty;
```

#### Development Shell

For contributing or modifying themes:

```bash
nix develop github:b0o/lavi
lavi-build  # Generate themes and format
```

#### Verifying Themes

To verify committed theme files match what would be generated:

```bash
nix flake check
```

This runs automatically in CI. On pushes to main, themes are auto-regenerated and committed if needed. PRs will fail if themes are out of date.

## Contributing

This colorscheme is built with [Lush.nvim](https://github.com/rktjmp/lush.nvim), ensure you have it installed.

Themes are generated from the palette and highlight definitions in `lua/lush_theme/lavi/`.
The files in `contrib/`, `nix/themes/`, `colors/`, and `lua/lavi/` are automatically generated - don't edit them directly.

Re-generate themes and format with:

- `just build` (requires [just](https://github.com/casey/just), [StyLua](https://github.com/JohnnyMorganz/StyLua), and [dprint](https://dprint.dev/)), or
- `nix develop -c lavi-build`

## License

MIT License
