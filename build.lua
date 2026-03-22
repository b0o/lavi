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
  local overwrite = require("shipwright.transform.overwrite")
  local patchwrite = require("shipwright.transform.patchwrite")
  local palette = require("lush_theme.lavi.palette")

  -- TODO: vivid
  -- TODO: delta

  -- Neovim theme
  builder.run(
    require("lush_theme.lavi"),
    require("shipwright.transform.lush").to_lua,
    { patchwrite, "colors/lavi.lua", "-- PATCH_OPEN", "-- PATCH_CLOSE" }
  )

  -- Compiled palette for consumers
  builder.run(palette, transforms.compile_palette, transforms.to_lua, { overwrite, "lua/lavi/palette.lua" })

  -- Lualine theme
  builder.run(require("lush_theme.lavi.lualine"), transforms.to_lua, { overwrite, "lua/lualine/themes/lavi.lua" })

  ---------------------------------------------------------------------------
  -- Contrib themes
  --
  -- Each entry below registers a theme build and its docs metadata. The
  -- build_contrib wrapper runs the normal builder.run pipeline and collects
  -- the docs table for README generation.
  ---------------------------------------------------------------------------

  ---@alias MarkdownStr string|string[] A markdown string, or a list of lines to be joined with newlines

  ---@class ThemeDocs
  ---@field name string Display name (required)
  ---@field url? string Project URL (link target for the name)
  ---@field tagline? string One-line description shown after the link
  ---@field subtitle? string Shown after name in <summary>, e.g. "(bat, Sublime Text, ...)"
  ---@field id? string Anchor id inside <details> for deep linking
  ---@field screenshots? string[] List of screenshot URLs; first shown in main README and at top of contrib README, rest in a "Screenshots" section at bottom of contrib README
  ---@field steps? MarkdownStr[] Numbered install steps (markdown)
  ---@field body? MarkdownStr Raw markdown replacing url+tagline+steps (escape hatch)
  ---@field extra? MarkdownStr Raw markdown appended after steps
  ---@field contrib_dir? string Directory name under contrib/ (for contrib README generation)

  -- Main screenshot shown at the top of the README
  local hero_screenshot = "https://github.com/user-attachments/assets/a7873a70-4b90-4e92-a11c-f262d9653f29"

  local theme_docs = {}

  --- Normalize a MarkdownStr to a plain string.
  ---@param s MarkdownStr
  ---@return string
  local function md(s)
    if type(s) == "table" then
      return table.concat(s, "\n")
    end
    return s
  end

  --- Build a contrib theme and collect its docs for README generation.
  ---@param opts { runs: any[][], docs?: ThemeDocs }
  local function build_contrib(opts)
    for _, run in ipairs(opts.runs) do
      builder.run(unpack(run))
    end
    if opts.docs then
      table.insert(theme_docs, opts.docs)
    end
  end

  -- Alacritty
  local alacritty = require("lush_theme.lavi.alacritty")
  build_contrib({
    runs = {
      {
        alacritty.colors,
        transforms.compile_palette,
        alacritty.transform,
        { overwrite, "contrib/alacritty/lavi.toml" },
      },
      {
        alacritty.colors,
        transforms.compile_palette,
        alacritty.transform_nix,
        { overwrite, "nix/themes/alacritty.nix" },
      },
    },
    docs = {
      name = "Alacritty",
      url = "https://github.com/alacritty/alacritty",
      screenshots = {
        "https://github.com/user-attachments/assets/26c8c477-9483-442b-a13b-a10370ed7214",
      },
      tagline = "Cross-platform, GPU-accelerated terminal emulator",
      contrib_dir = "alacritty",
      steps = {
        "Copy [`%slavi.toml`](./%slavi.toml) to `~/.config/alacritty/lavi.toml`",
        {
          "Import into your Alacritty config:",
          "   ```toml",
          "   general.import = [",
          '     "~/.config/alacritty/lavi.toml",',
          "   ]",
          "   ```",
        },
      },
    },
  })

  -- bat (uses textmate output, no module of its own)
  build_contrib({
    runs = {}, -- built as part of textmate below
    docs = {
      name = "bat",
      url = "https://github.com/sharkdp/bat",
      tagline = "A cat clone with syntax highlighting and Git integration",
      screenshots = {
        "https://github.com/user-attachments/assets/6cd40f2e-2918-4a57-9ab3-292fe644c9e1",
      },
      steps = {
        "Copy [`contrib/textmate/lavi.tmTheme`](./contrib/textmate/lavi.tmTheme) to `~/.config/bat/themes/lavi.tmTheme`",
        {
          "Rebuild bat's theme cache:",
          "   ```bash",
          "   bat cache --build",
          "   ```",
        },
        {
          "Use the theme:",
          "   ```bash",
          "   bat --theme=lavi file.rs",
          "   ```",
          '   Or set it permanently via `BAT_THEME=lavi` in your environment, or add `--theme="lavi"` to `~/.config/bat/config`.',
        },
      },
    },
  })

  -- Bottom
  local bottom = require("lush_theme.lavi.bottom")
  build_contrib({
    runs = {
      { bottom.colors, transforms.compile_palette, bottom.transform, { overwrite, "contrib/bottom/lavi.toml" } },
      { bottom.colors, transforms.compile_palette, bottom.transform_nix, { overwrite, "nix/themes/bottom.nix" } },
    },
    docs = {
      name = "Bottom",
      url = "https://github.com/ClementTsang/bottom",
      tagline = "Graphical process/system monitor for the terminal",
      contrib_dir = "bottom",
      screenshots = {
        "https://github.com/user-attachments/assets/5e13f5a4-5b3f-4d14-87f7-8dc3fd382725",
      },
      steps = {
        "Copy the contents of [`%slavi.toml`](./%slavi.toml) into your `~/.config/bottom/bottom.toml`",
      },
    },
  })

  -- Btop
  local btop = require("lush_theme.lavi.btop")
  build_contrib({
    runs = {
      { btop.colors, transforms.compile_palette, btop.transform, { overwrite, "contrib/btop/lavi.theme" } },
    },
    docs = {
      name = "Btop",
      url = "https://github.com/aristocratos/btop",
      tagline = "Resource monitor with a customizable interface",
      contrib_dir = "btop",
      screenshots = {
        "https://github.com/user-attachments/assets/c55b4f1e-4d6e-4fa9-babf-5aa76777e145",
      },
      steps = {
        "Copy [`%slavi.theme`](./%slavi.theme) to `~/.config/btop/themes/lavi.theme`",
        'Set `color_theme = "lavi"` in your `~/.config/btop/btop.conf` or select it from the options menu',
      },
    },
  })

  -- Clipse
  local clipse = require("lush_theme.lavi.clipse")
  build_contrib({
    runs = {
      { clipse.colors, transforms.compile_palette, clipse.transform, { overwrite, "contrib/clipse/lavi.json" } },
      { clipse.colors, transforms.compile_palette, clipse.transform_nix, { overwrite, "nix/themes/clipse.nix" } },
    },
    docs = {
      name = "Clipse",
      url = "https://github.com/savedra1/clipse",
      tagline = "Configurable TUI clipboard manager for Unix",
      contrib_dir = "clipse",
      steps = {
        "Copy [`%slavi.json`](./%slavi.json) to `~/.config/clipse/custom_theme.json`",
        'Set `"themeFile": "custom_theme.json"` in your `~/.config/clipse/config.json`',
      },
    },
  })

  -- Dank Material Shell
  local dms = require("lush_theme.lavi.dank-material-shell")
  build_contrib({
    runs = {
      { dms.colors, transforms.compile_palette, dms.transform, { overwrite, "contrib/dank-material-shell/lavi.json" } },
    },
    docs = {
      name = "Dank Material Shell",
      url = "https://github.com/AvengeMedia/DankMaterialShell",
      tagline = "Desktop shell for wayland compositors",
      contrib_dir = "dank-material-shell",
      screenshots = {
        "https://github.com/user-attachments/assets/110fe437-85ce-4c5d-bf07-0af2c072630e",
      },
      steps = {
        "Copy [`%slavi.json`](./%slavi.json) to `~/.config/DankMaterialShell/themes/lavi.json`",
        "In Settings → Theme & Colors, select **Custom** and set the theme file path to the copied file",
        'Alternatively, set `"currentThemeName": "custom"` and `"customThemeFile": "/path/to/lavi.json"` in `~/.config/DankMaterialShell/settings.json`',
      },
      extra = {
        "**Nix/Home-Manager:**",
        "",
        "Requires the [DMS home-manager module](https://github.com/AvengeMedia/DankMaterialShell) from the DMS flake:",
        "",
        "```nix",
        "# flake.nix inputs:",
        'inputs.dms.url = "github:AvengeMedia/DankMaterialShell/stable";',
        "",
        "# home-manager config:",
        "imports = [",
        "  inputs.dms.homeModules.dank-material-shell",
        "  inputs.lavi.homeManagerModules.lavi",
        "];",
        "",
        "lavi.dank-material-shell.enable = true;",
        "```",
        "",
        "This writes the theme file to `~/.config/DankMaterialShell/themes/lavi.json` and sets `programs.dank-material-shell.settings` to use it as the active custom theme.",
      },
    },
  })

  -- Foot
  local foot = require("lush_theme.lavi.foot")
  build_contrib({
    runs = {
      { foot.colors, transforms.compile_palette, foot.transform, { overwrite, "contrib/foot/lavi.ini" } },
      { foot.colors, transforms.compile_palette, foot.transform_nix, { overwrite, "nix/themes/foot.nix" } },
    },
    docs = {
      name = "Foot",
      url = "https://codeberg.org/dnkl/foot",
      tagline = "Fast, lightweight Wayland terminal emulator",
      contrib_dir = "foot",
      steps = {
        "Copy the contents of [`%slavi.ini`](./%slavi.ini) into your `~/.config/foot/foot.ini`",
      },
    },
  })

  -- Ghostty
  local ghostty = require("lush_theme.lavi.ghostty")
  build_contrib({
    runs = {
      { ghostty.colors, transforms.compile_palette, ghostty.transform, { overwrite, "contrib/ghostty/lavi.conf" } },
      { ghostty.colors, transforms.compile_palette, ghostty.transform_nix, { overwrite, "nix/themes/ghostty.nix" } },
    },
    docs = {
      name = "Ghostty",
      url = "https://github.com/ghostty-org/ghostty",
      tagline = "Fast, native terminal emulator with platform-native UI",
      contrib_dir = "ghostty",
      screenshots = {
        "https://github.com/user-attachments/assets/8ce786b9-4d5d-4634-b5dc-4eb1afbab977",
      },
      steps = {
        "Copy [`%slavi.conf`](./%slavi.conf) to `~/.config/ghostty/themes/lavi.conf`",
        "Set `theme = lavi.conf` in your `~/.config/ghostty/config`",
      },
    },
  })

  -- Kitty
  local kitty = require("lush_theme.lavi.kitty")
  build_contrib({
    runs = {
      { kitty.colors, transforms.compile_palette, kitty.transform, { overwrite, "contrib/kitty/lavi.conf" } },
    },
    docs = {
      name = "Kitty",
      url = "https://github.com/kovidgoyal/kitty",
      tagline = "GPU-accelerated terminal emulator",
      contrib_dir = "kitty",
      steps = {
        "Copy the contents of [`%slavi.conf`](./%slavi.conf) into your `~/.config/kitty/themes/lavi.conf`",
        "Run `kitty +kitten themes --reload-in=all lavi` to set the theme",
      },
    },
  })

  -- OpenCode (raw color table, handled specially)
  build_contrib({
    runs = {
      {
        require("lush_theme.lavi.opencode"),
        transforms.compile_palette,
        transforms.to_json,
        { overwrite, "contrib/opencode/lavi.json" },
      },
    },
    docs = {
      name = "Opencode",
      url = "https://github.com/opencode-ai/opencode",
      tagline = "TUI for coding with LLMs from the terminal",
      contrib_dir = "opencode",
      id = "opencode-expanded",
      screenshots = {
        "https://github.com/user-attachments/assets/03d3a17c-310f-44fe-b554-b4ab6dfead8d",
      },
      steps = {
        "Copy [`%slavi.json`](./%slavi.json) to `~/.config/opencode/themes/lavi.json`",
        'Set `{ "theme": "lavi" }` in your `~/.config/opencode/tui.jsonc` or select it from the UI theme picker',
      },
    },
  })

  -- TextMate (for bat and other TextMate-compatible apps)
  local textmate = require("lush_theme.lavi.textmate")
  build_contrib({
    runs = {
      {
        textmate.colors,
        transforms.compile_palette,
        textmate.transform,
        { overwrite, "contrib/textmate/lavi.tmTheme" },
      },
    },
    docs = {
      name = "TextMate Theme",
      subtitle = "(bat, Sublime Text, TextMate, VS Code)",
      contrib_dir = "textmate",
      body = {
        "Lavi provides a `.tmTheme` file at [`%slavi.tmTheme`](./%slavi.tmTheme) that works with any application supporting the TextMate theme format. This includes:",
        "",
        "- **[bat](https://github.com/sharkdp/bat)** — see the [bat](#other-programs) section above for specific instructions",
        "- **[Sublime Text](https://www.sublimetext.com/)** — copy `lavi.tmTheme` to your `Packages/User/` directory, then select it from Preferences → Color Scheme",
        "- **[TextMate](https://macromates.com/)** — double-click `lavi.tmTheme` to install, or copy it to `~/Library/Application Support/TextMate/Themes/`",
        "- **[VS Code](https://code.visualstudio.com/)** — tmTheme files can be used via the [TmTheme Editor](https://marketplace.visualstudio.com/items?itemName=Youssef.theme-converter) extension or as a base for a [color theme extension](https://code.visualstudio.com/api/extension-guides/color-theme)",
      },
    },
  })

  -- Wezterm
  local wezterm = require("lush_theme.lavi.wezterm")
  build_contrib({
    runs = {
      { wezterm.colors, transforms.compile_palette, wezterm.transform, { overwrite, "contrib/wezterm/lavi.toml" } },
    },
    docs = {
      name = "Wezterm",
      url = "https://github.com/wez/wezterm",
      tagline = "GPU-accelerated terminal emulator and multiplexer",
      contrib_dir = "wezterm",
      steps = {
        "Copy [`%slavi.toml`](./%slavi.toml) to `~/.config/wezterm/colors/lavi.toml`",
        'Set `config.color_scheme = "lavi"` in your Wezterm config',
      },
    },
  })

  -- Windows Terminal (uses shipwright's built-in transform)
  local wt_palette = vim.tbl_extend("force", { name = "lavi" }, palette)
  wt_palette.ansi = nil
  build_contrib({
    runs = {
      {
        wt_palette,
        require("shipwright.transform.contrib.windows_terminal"),
        { overwrite, "contrib/windows_terminal/lavi.json" },
      },
    },
    docs = {
      name = "Windows Terminal",
      url = "https://github.com/microsoft/terminal",
      tagline = "Modern terminal application for Windows",
      contrib_dir = "windows_terminal",
      steps = {
        "Open the Windows Terminal settings (`ctrl+,`)",
        "Select **Open JSON file** at the bottom left corner (`ctrl+shift+,`)",
        {
          "Copy the contents of [`%slavi.json`](./%slavi.json) inside of the `schemes` array",
          "   ```jsonc",
          "   {",
          '     "schemes": [',
          "       // paste the contents of lavi.json here",
          "     ],",
          "   }",
          "   ```",
        },
        "Save and exit",
        "In the **Settings** panel under **Profiles**, select the profile you want to use the theme in, then select **Appearance** and choose **lavi** from the **Color scheme** dropdown",
      },
    },
  })

  -- Zellij
  local zellij = require("lush_theme.lavi.zellij")
  build_contrib({
    runs = {
      { zellij.colors, zellij.transform, { overwrite, "contrib/zellij/lavi.kdl" } },
    },
    docs = {
      name = "Zellij",
      url = "https://github.com/zellij-org/zellij",
      tagline = "Terminal workspace and multiplexer",
      contrib_dir = "zellij",
      screenshots = {
        "https://github.com/user-attachments/assets/8c02440f-39d1-4173-bdfa-679cd0d72ada",
      },
      steps = {
        "Copy [`%slavi.kdl`](./%slavi.kdl) to `~/.config/zellij/themes/lavi.kdl`",
        'Set `theme "lavi"` in your `~/.config/zellij/config.kdl`',
      },
    },
  })

  -- Base16 (for Stylix) - no docs entry, only referenced in the Nix section
  local base16 = require("lush_theme.lavi.base16")
  builder.run(base16.colors, transforms.compile_palette, base16.transform, { overwrite, "contrib/base16/lavi.yaml" })

  ---------------------------------------------------------------------------
  -- README generation
  ---------------------------------------------------------------------------

  --- Format a MarkdownStr, substituting %s with the contrib path prefix.
  --- Steps are format strings where %s expands to the contrib path prefix.
  --- In the main README this is "contrib/<dir>/", in a contrib README it's "".
  ---@param s MarkdownStr
  ---@param contrib_prefix string
  ---@return string
  local function fmt(s, contrib_prefix)
    local str = md(s)
    -- Only format if the string contains %s to avoid issues with other % chars
    if str:find("%%s") then
      str = str:gsub("%%s", contrib_prefix)
    end
    return str
  end

  --- Render a single theme's <details> block for the main README.
  ---@param docs ThemeDocs
  ---@return string
  local function render_readme_section(docs)
    local lines = {}
    local prefix = docs.contrib_dir and ("contrib/" .. docs.contrib_dir .. "/") or ""

    -- Summary line
    local summary = "<b>" .. docs.name .. "</b>"
    if docs.subtitle then
      summary = summary .. " " .. docs.subtitle
    end
    table.insert(lines, "<details>")
    table.insert(lines, "<summary>" .. summary .. "</summary>")
    table.insert(lines, "")

    if docs.body then
      table.insert(lines, fmt(docs.body, prefix))
    else
      -- Anchor for deep linking
      if docs.id then
        table.insert(lines, '<a id="' .. docs.id .. '"></a>')
      end

      -- Linked name + tagline
      if docs.url and docs.tagline then
        table.insert(lines, '<a href="' .. docs.url .. '">' .. docs.name .. "</a>: " .. docs.tagline)
        table.insert(lines, "")
      end

      -- First screenshot
      if docs.screenshots and docs.screenshots[1] then
        table.insert(lines, "![" .. docs.name .. " screenshot](" .. docs.screenshots[1] .. ")")
        table.insert(lines, "")
      end

      -- Numbered steps
      if docs.steps then
        for i, step in ipairs(docs.steps) do
          table.insert(lines, i .. ". " .. fmt(step, prefix))
        end
      end

      -- Extra content
      if docs.extra then
        table.insert(lines, "")
        table.insert(lines, fmt(docs.extra, prefix))
      end
    end

    table.insert(lines, "")
    table.insert(lines, "</details>")

    return table.concat(lines, "\n")
  end

  --- Render a contrib/<app>/README.md for a theme.
  ---@param docs ThemeDocs
  ---@return string
  local function render_contrib_readme(docs)
    local lines = {}

    table.insert(lines, "# Lavi for " .. docs.name)
    table.insert(lines, "")

    -- First screenshot at the top
    if docs.screenshots and docs.screenshots[1] then
      table.insert(lines, "![" .. docs.name .. " screenshot](" .. docs.screenshots[1] .. ")")
      table.insert(lines, "")
    end

    if docs.body then
      table.insert(lines, fmt(docs.body, ""))
    else
      if docs.url and docs.tagline then
        table.insert(lines, '<a href="' .. docs.url .. '">' .. docs.name .. "</a>: " .. docs.tagline)
        table.insert(lines, "")
      end

      if docs.steps then
        table.insert(lines, "## Installation")
        table.insert(lines, "")
        for i, step in ipairs(docs.steps) do
          table.insert(lines, i .. ". " .. fmt(step, ""))
        end
      end

      if docs.extra then
        table.insert(lines, "")
        table.insert(lines, fmt(docs.extra, ""))
      end
    end

    table.insert(lines, "")
    table.insert(lines, "---")
    table.insert(lines, "")
    table.insert(lines, "Part of [Lavi](https://github.com/b0o/lavi), a soft and sweet colorscheme.")

    -- Additional screenshots section
    if docs.screenshots and #docs.screenshots > 1 then
      table.insert(lines, "")
      table.insert(lines, "## Screenshots")
      table.insert(lines, "")
      for i = 2, #docs.screenshots do
        table.insert(lines, "![" .. docs.name .. " screenshot " .. i .. "](" .. docs.screenshots[i] .. ")")
        table.insert(lines, "")
      end
    end

    table.insert(lines, "")
    return table.concat(lines, "\n")
  end

  -- Sort themes alphabetically by name
  table.sort(theme_docs, function(a, b)
    return a.name:lower() < b.name:lower()
  end)

  -- Generate the "Other Programs" section for the main README
  local sections = {}
  for _, docs in ipairs(theme_docs) do
    table.insert(sections, render_readme_section(docs))
  end
  local programs_content = table.concat(sections, "\n\n")

  --- Patch a section of a file between open/close markers.
  ---@param content string File content
  ---@param open_marker string
  ---@param close_marker string
  ---@param replacement string
  ---@return string? new_content
  local function patch_between(content, open_marker, close_marker, replacement)
    local open_pos = content:find(open_marker, 1, true)
    local close_pos = content:find(close_marker, 1, true)
    if not open_pos or not close_pos then
      return nil
    end
    return content:sub(1, open_pos + #open_marker - 1) .. "\n" .. replacement .. "\n" .. content:sub(close_pos)
  end

  -- Patch README.md
  local readme_path = project_root() .. "/README.md"
  local readme = io.open(readme_path, "r")
  if readme then
    local content = readme:read("*a")
    readme:close()

    -- Patch hero screenshot
    local hero_content = "![Screenshot](" .. hero_screenshot .. ")\n\n[More screenshots](./GALLERY.md)"
    content = patch_between(content, "<!-- LAVI_HERO_OPEN -->", "<!-- LAVI_HERO_CLOSE -->", hero_content) or content

    -- Patch Other Programs section
    content = patch_between(content, "<!-- LAVI_PROGRAMS_OPEN -->", "<!-- LAVI_PROGRAMS_CLOSE -->", programs_content)
      or content

    local out = io.open(readme_path, "w")
    if out then
      out:write(content)
      out:close()
      vim.notify("README.md: updated", vim.log.levels.INFO)
    end
  end

  -- Generate GALLERY.md
  local gallery_path = project_root() .. "/GALLERY.md"
  local gallery_lines = {
    "# Lavi Gallery",
    "",
    "![Neovim](" .. hero_screenshot .. ")",
    "",
  }
  for _, docs in ipairs(theme_docs) do
    if docs.screenshots then
      for _, url in ipairs(docs.screenshots) do
        table.insert(gallery_lines, "### " .. docs.name)
        table.insert(gallery_lines, "")
        table.insert(gallery_lines, "![" .. docs.name .. "](" .. url .. ")")
        table.insert(gallery_lines, "")
      end
    end
  end
  local gallery_out = io.open(gallery_path, "w")
  if gallery_out then
    gallery_out:write(table.concat(gallery_lines, "\n") .. "\n")
    gallery_out:close()
  end

  -- Generate contrib/<app>/README.md files
  for _, docs in ipairs(theme_docs) do
    if docs.contrib_dir then
      local contrib_path = project_root() .. "/contrib/" .. docs.contrib_dir .. "/README.md"
      local out = io.open(contrib_path, "w")
      if out then
        out:write(render_contrib_readme(docs))
        out:close()
      end
    end
  end

  -- TODO: Generate the Nix home-manager config block from theme metadata
end, {})
