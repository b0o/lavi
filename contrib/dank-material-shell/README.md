# Lavi for Dank Material Shell

<a href="https://github.com/AvengeMedia/DankMaterialShell">Dank Material Shell</a>: Desktop shell for wayland compositors

## Installation

1. Copy [`lavi.json`](./lavi.json) to `~/.config/DankMaterialShell/themes/lavi.json`
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

---

Part of [Lavi](https://github.com/b0o/lavi), a soft and sweet colorscheme.
