{
  config,
  lib,
  pkgs,
  options,
  ...
}: let
  cfg = config.lavi;

  # Build the lavi-nvim plugin using the same logic as flake.nix
  lavi-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "lavi.nvim";
    version = "0.1.0";
    src = pkgs.lib.cleanSourceWith {
      src = ../..;
      filter = path: type: let
        name = baseNameOf path;
        excluded = [
          "lush_theme"
          "lavi_dev.lua"
          "build.lua"
          "build"
          "contrib"
          "nix"
          "docs"
          "justfile"
          "dprint.json"
          ".gitignore"
          "flake.nix"
          "flake.lock"
        ];
      in
        !(builtins.elem name excluded);
    };
    meta = {
      description = "Lavi - a soft and sweet colorscheme for Neovim";
      homepage = "https://github.com/b0o/lavi.nvim";
      license = pkgs.lib.licenses.mit;
    };
  };
in {
  options.lavi = {
    alacritty.enable = lib.mkEnableOption "Lavi theme for Alacritty";
    bat.enable = lib.mkEnableOption "Lavi theme for bat (TextMate)";
    bottom.enable = lib.mkEnableOption "Lavi theme for Bottom";
    btop.enable = lib.mkEnableOption "Lavi theme for Btop";
    clipse.enable = lib.mkEnableOption "Lavi theme for Clipse";
    dank-material-shell.enable = lib.mkEnableOption "Lavi theme for Dank Material Shell";
    foot.enable = lib.mkEnableOption "Lavi theme for Foot";
    ghostty.enable = lib.mkEnableOption "Lavi theme for Ghostty";
    kitty.enable = lib.mkEnableOption "Lavi theme for Kitty";
    opencode.enable = lib.mkEnableOption "Lavi theme for Opencode";
    wezterm.enable = lib.mkEnableOption "Lavi theme for Wezterm";
    zellij.enable = lib.mkEnableOption "Lavi theme for Zellij";

    neovim = {
      enable = lib.mkEnableOption "Lavi colorscheme for Neovim";
      package = lib.mkOption {
        type = lib.types.package;
        default = lavi-nvim;
        defaultText = lib.literalExpression "lavi-nvim";
        description = "The lavi.nvim package to use.";
      };
    };
  };

  config = lib.mkMerge [
    # Alacritty - merge colors into settings
    (lib.mkIf cfg.alacritty.enable {
      programs.alacritty.settings = import ../themes/alacritty.nix;
    })

    # Bat - install TextMate theme for bat
    (lib.mkIf cfg.bat.enable {
      programs.bat = {
        config.theme = "lavi";
        themes.lavi.src = ../../contrib/textmate/lavi.tmTheme;
      };
    })

    # Btop - file-based theme, write file and set color_theme
    (lib.mkIf cfg.btop.enable {
      programs.btop.settings.color_theme = "lavi";
      xdg.configFile."btop/themes/lavi.theme".source = ../../contrib/btop/lavi.theme;
    })

    # Clipse - merge theme settings
    (lib.mkIf cfg.clipse.enable {
      services.clipse.theme = import ../themes/clipse.nix;
    })

    # Dank Material Shell - writes theme file and configures custom theme in settings
    # Requires DMS home-manager module: github:AvengeMedia/DankMaterialShell#homeModules.dank-material-shell
    (lib.mkIf cfg.dank-material-shell.enable (
      {
        xdg.configFile."DankMaterialShell/themes/lavi.json".source =
          ../../contrib/dank-material-shell/lavi.json;
      }
      // lib.optionalAttrs (options ? programs.dank-material-shell) {
        programs.dank-material-shell.settings = {
          currentThemeName = "custom";
          customThemeFile = "${config.xdg.configHome}/DankMaterialShell/themes/lavi.json";
        };
      }
    ))

    # Foot - merge settings
    (lib.mkIf cfg.foot.enable {
      programs.foot.settings = import ../themes/foot.nix;
    })

    # Ghostty - uses themes attrset
    (lib.mkIf cfg.ghostty.enable {
      programs.ghostty.themes.lavi = import ../themes/ghostty.nix;
    })

    # Kitty - extraConfig with raw content
    (lib.mkIf cfg.kitty.enable {
      programs.kitty.extraConfig = builtins.readFile ../../contrib/kitty/lavi.conf;
    })

    # Neovim - add plugin to programs.neovim.plugins
    (lib.mkIf cfg.neovim.enable {
      programs.neovim.plugins = [cfg.neovim.package];
    })

    # Bottom - merge settings (styles section)
    (lib.mkIf cfg.bottom.enable {
      programs.bottom.settings = import ../themes/bottom.nix;
    })

    # Wezterm - extraConfig with color scheme reference
    # Note: Wezterm uses Lua config, so we write the theme file and reference it
    (lib.mkIf cfg.wezterm.enable {
      xdg.configFile."wezterm/colors/lavi.toml".source = ../../contrib/wezterm/lavi.toml;
    })

    # Opencode - themes (expects attrset, converted to JSON)
    (lib.mkIf cfg.opencode.enable {
      programs.opencode.themes.lavi = builtins.fromJSON (
        builtins.readFile ../../contrib/opencode/lavi.json
      );
    })

    # Zellij - themes (expects KDL string)
    (lib.mkIf cfg.zellij.enable {
      programs.zellij.themes.lavi = builtins.readFile ../../contrib/zellij/lavi.kdl;
    })
  ];
}
