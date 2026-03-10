{
  description = "Lavi - a soft and sweet colorscheme";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    let
      # System-independent outputs
      systemIndependent = {
        # Home-manager module
        homeManagerModules.default = import ./nix/homeManagerModules;
        homeManagerModules.lavi = self.homeManagerModules.default;

        # Raw theme content as strings for programmatic access
        # Uses pre-committed files for fast evaluation (no build needed)
        lib.themes = {
          alacritty = builtins.readFile ./contrib/alacritty/lavi.toml;
          base16 = builtins.readFile ./contrib/base16/lavi.yaml;
          bottom = builtins.readFile ./contrib/bottom/lavi.toml;
          btop = builtins.readFile ./contrib/btop/lavi.theme;
          clipse = builtins.readFile ./contrib/clipse/lavi.json;
          dank-material-shell = builtins.readFile ./contrib/dank-material-shell/lavi.json;
          foot = builtins.readFile ./contrib/foot/lavi.ini;
          ghostty = builtins.readFile ./contrib/ghostty/lavi.conf;
          kitty = builtins.readFile ./contrib/kitty/lavi.conf;
          opencode = builtins.readFile ./contrib/opencode/lavi.json;
          textmate = builtins.readFile ./contrib/textmate/lavi.tmTheme;
          wezterm = builtins.readFile ./contrib/wezterm/lavi.toml;
          windows_terminal = builtins.readFile ./contrib/windows_terminal/lavi.json;
          zellij = builtins.readFile ./contrib/zellij/lavi.kdl;
        };

        # Base16 color scheme for Stylix integration
        # See: https://github.com/chriskempson/base16/blob/main/styling.md
        lib.base16 = {
          scheme = "Lavi";
          author = "Maddison Hellstrom (https://github.com/b0o)";
          base00 = "25213B"; # Default Background
          base01 = "2E2A37"; # Lighter Background (status bars, line numbers)
          base02 = "584F8C"; # Selection Background
          base03 = "8876A7"; # Comments, Invisibles
          base04 = "A79BCF"; # Dark Foreground (status bars)
          base05 = "EDE7FE"; # Default Foreground
          base06 = "EEE5FF"; # Light Foreground
          base07 = "FFFFFF"; # Light Background
          base08 = "F2637E"; # Variables, XML Tags, Diff Deleted (red)
          base09 = "FF9A6B"; # Integers, Boolean, Constants (orange)
          base0A = "FFD080"; # Classes, Search Highlight (yellow)
          base0B = "7CF89B"; # Strings, Diff Inserted (green)
          base0C = "2CEDC0"; # Support, Regex, Escape Characters (cyan)
          base0D = "7583FF"; # Functions, Methods (blue)
          base0E = "B98AFF"; # Keywords, Storage (magenta)
          base0F = "EAB9F9"; # Deprecated, Embedded Language Tags (blush/pink)
        };
      };

      # System-dependent outputs
      systemDependent = flake-utils.lib.eachDefaultSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};

          # Lush.nvim plugin for building themes
          lush-nvim = pkgs.vimUtils.buildVimPlugin {
            pname = "lush.nvim";
            version = "2024-02-04";
            src = pkgs.fetchFromGitHub {
              owner = "rktjmp";
              repo = "lush.nvim";
              rev = "9c60ec2279d62487d942ce095e49006af28eed6e";
              hash = "sha256-ZDC2oirfDe/GqNx6+hivvNqdLutAxlBnSk51lf1yKqM=";
            };
            doCheck = false;
          };

          # Shipwright.nvim for theme building
          shipwright-nvim = pkgs.vimUtils.buildVimPlugin {
            pname = "shipwright.nvim";
            version = "2024-02-04";
            src = pkgs.fetchFromGitHub {
              owner = "rktjmp";
              repo = "shipwright.nvim";
              rev = "e596ab48328c31873f4f4d2e070243bf9de16ff3";
              hash = "sha256-xh/2m//Cno5gPucjOYih79wVZj3X1Di/U3/IQhKXjc0=";
            };
            doCheck = false;
          };

          # Theme files package - uses pre-committed files (fast for consumers)
          lavi-themes = pkgs.stdenvNoCC.mkDerivation {
            pname = "lavi-themes";
            version = "0.1.0";
            src = ./contrib;
            installPhase = ''
              runHook preInstall
              mkdir -p $out
              cp -r . $out/
              runHook postInstall
            '';
            meta = {
              description = "Lavi - a soft and sweet colorscheme";
              homepage = "https://github.com/b0o/lavi.nvim";
              license = pkgs.lib.licenses.mit;
            };
          };

          # Theme files built from source (for verification)
          lavi-themes-generated = pkgs.stdenvNoCC.mkDerivation {
            pname = "lavi-themes-generated";
            version = "0.1.0";
            src = ./.;

            nativeBuildInputs = [ pkgs.neovim ];

            buildPhase = ''
              runHook preBuild

              # Set up minimal config directory
              export HOME=$(mktemp -d)
              export XDG_CONFIG_HOME=$HOME/.config
              export XDG_DATA_HOME=$HOME/.local/share
              export XDG_STATE_HOME=$HOME/.local/state
              mkdir -p $XDG_CONFIG_HOME $XDG_DATA_HOME $XDG_STATE_HOME

              # Run the build with lush and shipwright on runtimepath
              nvim --headless --clean \
                --cmd "set rtp+=${lush-nvim}" \
                --cmd "set rtp+=${shipwright-nvim}" \
                --cmd "set rtp+=$(pwd)" \
                -u NONE \
                -c "lua dofile('build.lua')" \
                -c "LaviBuild" \
                -c "qa!"

              runHook postBuild
            '';

            installPhase = ''
              runHook preInstall
              mkdir -p $out/contrib $out/nix
              cp -r contrib/* $out/contrib/
              cp -r nix/themes $out/nix/
              runHook postInstall
            '';

            meta = {
              description = "Lavi themes built from source (for verification)";
              homepage = "https://github.com/b0o/lavi.nvim";
              license = pkgs.lib.licenses.mit;
            };
          };

          # Check that committed files match generated files
          lavi-themes-check = pkgs.runCommand "lavi-themes-check" { } ''
            echo "Checking that committed theme files match generated output..."

            # Compare contrib directories
            if ! diff -r ${./contrib} ${lavi-themes-generated}/contrib; then
              echo ""
              echo "ERROR: Committed contrib/ files don't match generated output!"
              echo "Run 'just build' or 'nix develop -c lavi-build' and commit the changes."
              exit 1
            fi

            # Compare nix/themes directories
            if ! diff -r ${./nix/themes} ${lavi-themes-generated}/nix/themes; then
              echo ""
              echo "ERROR: Committed nix/themes/ files don't match generated output!"
              echo "Run 'just build' or 'nix develop -c lavi-build' and commit the changes."
              exit 1
            fi

            echo "All theme files are up to date!"
            touch $out
          '';

          # Neovim plugin - minimal runtime (no lush dependency)
          lavi-nvim = pkgs.vimUtils.buildVimPlugin {
            pname = "lavi.nvim";
            version = "0.1.0";
            src = pkgs.lib.cleanSourceWith {
              src = ./.;
              filter =
                path: type:
                let
                  name = baseNameOf path;
                  # Exclude dev-only files that require lush
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

          # Neovim plugin - full source for development/customization (requires lush.nvim)
          lavi-nvim-dev = pkgs.vimUtils.buildVimPlugin {
            pname = "lavi.nvim-dev";
            version = "0.1.0";
            src = ./.;
            # Disable require check - lush_theme modules require lush.nvim
            doCheck = false;
            meta = {
              description = "Lavi - a soft and sweet colorscheme for Neovim (development version with lush sources)";
              homepage = "https://github.com/b0o/lavi.nvim";
              license = pkgs.lib.licenses.mit;
            };
          };

          # Build dependencies for theme generation (dev shell)
          buildDeps = with pkgs; [
            neovim
            stylua
            dprint
          ];

          lavi-build = pkgs.writeShellScriptBin "lavi-build" ''
            set -e
            cd "$(git rev-parse --show-toplevel)"
            nvim --headless -u build.lua +LaviBuild +q
            stylua .
            dprint fmt
            echo "Build complete"
          '';
        in
        {
          packages = {
            default = lavi-themes;
            inherit
              lavi-themes
              lavi-themes-generated
              lavi-nvim
              lavi-nvim-dev
              lavi-build
              ;
          };

          # Flake check to verify committed files are up to date
          checks = {
            themes-up-to-date = lavi-themes-check;
          };

          devShells.default = pkgs.mkShell {
            buildInputs = buildDeps ++ [
              lavi-build
            ];

            shellHook = ''
              echo "Lavi development shell"
              echo ""
              echo "Commands:"
              echo "  lavi-build          - Generate themes and format"
              echo "  nvim -u build.lua   - Open Neovim with Lush for interactive development"
              echo ""
              echo "Run 'nix flake check' to verify committed files match generated output."
              echo ""
            '';
          };
        }
      );
    in
    systemIndependent // systemDependent;
}
