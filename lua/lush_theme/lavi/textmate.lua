local p = require("lush_theme.lavi.palette")
local lavi = require("lush_theme.lavi")
local transforms = require("lush_theme.lavi.transforms")

local plist = transforms.plist

local colors = {
  -- Editor settings
  fg = lavi.Normal.fg,
  bg = p.bg,
  caret = lavi.Statement.fg,
  gutter_fg = p.bright_black,
  invisibles = p.med_black,
  line_highlight = p.deep_lavender,
  selection = p.deep_anise,
  selection_fg = p.white,

  -- Syntax
  comment = lavi.Comment.fg,
  punctuation = lavi.Delimiter.fg,
  string = lavi.String.fg,
  number = lavi.Number.fg,
  constant_builtin = lavi.Constant.fg,
  constant_library = p.yellow,
  variable = lavi.Identifier.fg,
  property = p.oceanblue.lighten(15),
  parameter = lavi.Identifier.fg,
  keyword = lavi.Statement.fg,
  storage = p.velvet,
  entity_name = p.blue.desaturate(15).lighten(12),
  inherited_class = p.blue,
  library_type = p.lavender,
  func = lavi.Function.fg,
  html_tag = p.dust.desaturate(15),
  tag_name = p.skyblue,
  tag_attribute = p.oceanblue,
  markup_heading = lavi.Statement.fg,
  markup_link = p.oceanblue,
  markup_code = lavi.Constant.fg,
  diff_added = lavi.DiffAddBright.fg,
  diff_removed = p.red,
  diff_modified = p.yellow,
  invalid_bg = p.cayenne.lighten(5),
  invalid_fg = lavi.Normal.fg,
  deprecated_bg = p.red,
  deprecated_fg = p.oceanblue,
}

-- Helper to create a scope rule entry
local function scope_rule(name, scope, settings)
  return plist.dict({ name = name, scope = scope, settings = settings })
end

-- Helper for settings with foreground and optional fontStyle
local function styled(color, style)
  if color and style then
    return plist.dict({ foreground = color, fontStyle = style })
  elseif color then
    return plist.dict({ foreground = color })
  else
    return plist.dict({ fontStyle = style or "" })
  end
end

local function transform(compiled)
  local c = compiled

  local theme = plist.dict({
    name = "lavi",
    uuid = "D8D5E82E-3D5B-46B5-B38E-8C841C21347D",
    colorSpaceName = "sRGB",
    semanticClass = "theme.dark.lavi",
    settings = plist.array(
      -- Global editor settings
      plist.dict({
        settings = plist.dict({
          fontStyle = "",
          foreground = c.fg,
          background = c.bg,
          bracketsOptions = "underline",
          caret = c.caret,
          gutter = c.bg,
          gutterForeground = c.gutter_fg,
          invisibles = c.invisibles,
          lineHighlight = c.line_highlight,
          selection = c.selection,
          selectionBorder = c.selection,
          selectionForeground = c.selection_fg,
          tagsForeground = "",
          tagsOptions = "stippled_underline",
          bracketContentsOptions = "underline",
        }),
      }),

      -- Comments
      scope_rule("Comment", "comment, punctuation.definition.comment", styled(c.comment, "italic bold")),

      -- Punctuation
      scope_rule("Punctuation", "punctuation", styled(c.punctuation)),
      scope_rule(
        "Delimiters",
        "punctuation.definition.parameters, punctuation.section.parameters, punctuation.definition.block, punctuation.section.braces, punctuation.section.brackets, punctuation.section.parens, meta.brace, meta.delimiter, punctuation.definition.arguments, punctuation.definition.list, punctuation.separator, punctuation.terminator",
        styled(c.punctuation)
      ),

      -- Strings
      scope_rule("String", "string, punctuation.definition.string", styled(c.string)),

      -- Numbers and Constants
      scope_rule(
        "Number",
        "constant.numeric, constant.numeric.integer, constant.numeric.float, constant.numeric.decimal, constant.numeric.hex",
        styled(c.number)
      ),
      scope_rule(
        "Built-in constant",
        "constant.language, constant.language.boolean, constant.language.null, constant.language.undefined",
        styled(c.constant_builtin)
      ),
      scope_rule("Library constant", "support.constant", styled(c.constant_library, "")),

      -- Variables and Properties
      scope_rule(
        "Variables, properties, object keys",
        "variable, constant.character, constant.other, variable.other.constant, meta.object-literal.key, meta.object-literal.key, meta.property-name, support.type.property-name, variable.other.property, variable.other.object.property, variable.other.property, variable, meta.object, meta.object-literal, meta.property.object, meta.member, meta.property, meta.object, meta.var.expr",
        styled(c.variable)
      ),
      scope_rule("Variable", "variable", styled(c.variable, "")),
      scope_rule("Library variable", "support.other.variable", styled(nil, "")),
      scope_rule(
        "Object properties",
        "meta.property-name, variable.object.property, entity.name.tag.yaml, support.type.property-name",
        styled(c.property)
      ),
      scope_rule(
        "Function argument",
        "variable.parameter, meta.parameter, entity.name.variable.parameter",
        styled(c.parameter, "italic")
      ),

      -- Keywords and Storage
      scope_rule("Keyword", "keyword", styled(c.keyword)),
      scope_rule("Storage", "storage, storage.modifier", styled(c.storage, "")),
      scope_rule("Storage type", "storage.type", styled(c.storage, "italic")),

      -- Classes and Entities
      scope_rule("Class name", "entity.name", styled(c.entity_name)),
      scope_rule("Inherited class", "entity.other.inherited-class", styled(c.inherited_class, "italic underline")),
      scope_rule("Library class/type", "support.type, support.class", styled(c.library_type)),

      -- Functions
      scope_rule(
        "Function name",
        "entity.name.function, meta.function-call.generic, meta.function-call, support.function, meta.method-call",
        styled(c.func, "")
      ),
      scope_rule("Library function", "support.function, support.macro", styled(c.func, "")),

      -- HTML/XML
      scope_rule("HTML Tag", "entity.name.tag, entity.other.attribute-name", styled(c.html_tag, "")),
      scope_rule("Tag name", "entity.name.tag, meta.tag.sgml, markup.deleted.git_gutter", styled(c.tag_name, "")),
      scope_rule("Tag attribute", "entity.other.attribute-name", styled(c.tag_attribute, "")),

      -- JSON and YAML
      scope_rule("JSON Property Names", "support.type.property-name.json", styled(c.property)),
      scope_rule("YAML Key", "entity.name.tag.yaml", styled(c.property)),

      -- Markup
      scope_rule("Markup Heading", "markup.heading", styled(c.markup_heading, "bold")),
      scope_rule("Markup Bold", "markup.bold", plist.dict({ fontStyle = "bold" })),
      scope_rule("Markup Italic", "markup.italic", plist.dict({ fontStyle = "italic" })),
      scope_rule("Markup Link", "markup.underline.link", styled(c.markup_link)),
      scope_rule("Markup Code", "markup.raw.inline, markup.raw.block", styled(c.markup_code)),

      -- Diff
      scope_rule("Diff Added", "markup.inserted.diff, meta.diff.header.to-file", styled(c.diff_added)),
      scope_rule("Diff Removed", "markup.deleted.diff, meta.diff.header.from-file", styled(c.diff_removed)),
      scope_rule("Diff Modified", "markup.changed.diff", styled(c.diff_modified)),

      -- Invalid
      scope_rule(
        "Invalid",
        "invalid",
        plist.dict({ background = c.invalid_bg, fontStyle = "", foreground = c.invalid_fg })
      ),
      scope_rule(
        "Invalid deprecated",
        "invalid.deprecated",
        plist.dict({ background = c.deprecated_bg, foreground = c.deprecated_fg })
      )
    ),
  })

  return plist.to_xml(theme)
end

return {
  colors = colors,
  transform = transform,
}
