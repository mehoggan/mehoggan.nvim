-- jungle.lua — high-contrast jungle colorscheme for Neovim (0.9+)
-- Deep forest-floor background with vivid canopy accents.
-- Install: drop this in ~/.config/nvim/colors/jungle.lua, then `:colorscheme jungle`

vim.cmd.highlight("clear")
if vim.g.syntax_on then
  vim.cmd.syntax("reset")
end
vim.o.background = "dark"
vim.g.colors_name = "jungle"

local c = {
  bg = "#071409", -- forest floor
  bg_dark = "#040d05", -- statusline / inactive
  bg_alt = "#0c1f11", -- pmenu / statusline active
  bg_float = "#0a1a0e", -- floating windows
  bg_hl = "#12261a", -- cursorline / columns
  bg_sel = "#234a2c", -- visual selection

  fg = "#e8ffe8", -- pale leaf
  fg_dim = "#b6d7b0", -- punctuation / operators
  comment = "#5e8b6a", -- mossy
  gutter = "#2f5a3a", -- line numbers / borders

  red = "#ff4d4d",
  green = "#3ddc84",
  bgreen = "#7dff5a",
  yellow = "#ffc233",
  byellow = "#ffe066",
  blue = "#2ea8e0",
  bblue = "#5fd0ff",
  magenta = "#c77dff",
  bmagenta = "#e0a6ff",
  cyan = "#25e0b8",
  bcyan = "#5cffdc",
  white = "#f4fff4",
  cursor = "#8dff5a",
}

local hl = {
  -- Editor UI
  Normal = { fg = c.fg, bg = c.bg },
  NormalNC = { fg = c.fg, bg = c.bg },
  NormalFloat = { fg = c.fg, bg = c.bg_float },
  FloatBorder = { fg = c.gutter, bg = c.bg_float },
  FloatTitle = { fg = c.bgreen, bg = c.bg_float, bold = true },
  Cursor = { fg = c.bg, bg = c.cursor },
  lCursor = { fg = c.bg, bg = c.cursor },
  CursorLine = { bg = c.bg_hl },
  CursorColumn = { bg = c.bg_hl },
  ColorColumn = { bg = c.bg_alt },
  LineNr = { fg = c.gutter },
  CursorLineNr = { fg = c.cursor, bold = true },
  SignColumn = { bg = c.bg },
  FoldColumn = { fg = c.gutter, bg = c.bg },
  Folded = { fg = c.fg_dim, bg = c.bg_alt },
  Visual = { bg = c.bg_sel },
  VisualNOS = { bg = c.bg_sel },
  Search = { fg = c.bg, bg = c.byellow },
  IncSearch = { fg = c.bg, bg = c.cursor },
  CurSearch = { fg = c.bg, bg = c.cursor },
  Substitute = { fg = c.bg, bg = c.red },
  MatchParen = { fg = c.cursor, bold = true, underline = true },
  Pmenu = { fg = c.fg, bg = c.bg_alt },
  PmenuSel = { fg = c.bg, bg = c.bgreen, bold = true },
  PmenuSbar = { bg = c.bg_alt },
  PmenuThumb = { bg = c.gutter },
  WildMenu = { fg = c.bg, bg = c.bgreen },
  StatusLine = { fg = c.fg, bg = c.bg_alt },
  StatusLineNC = { fg = c.fg_dim, bg = c.bg_dark },
  TabLine = { fg = c.fg_dim, bg = c.bg_dark },
  TabLineSel = { fg = c.bg, bg = c.bgreen, bold = true },
  TabLineFill = { bg = c.bg_dark },
  WinBar = { fg = c.fg, bg = c.bg },
  WinBarNC = { fg = c.fg_dim, bg = c.bg },
  WinSeparator = { fg = c.gutter, bg = c.bg },
  VertSplit = { fg = c.gutter, bg = c.bg },
  NonText = { fg = c.gutter },
  Whitespace = { fg = c.gutter },
  SpecialKey = { fg = c.gutter },
  EndOfBuffer = { fg = c.bg_dark },
  Conceal = { fg = c.gutter },
  Directory = { fg = c.bblue },
  Title = { fg = c.bgreen, bold = true },
  ErrorMsg = { fg = c.red },
  WarningMsg = { fg = c.yellow },
  ModeMsg = { fg = c.bgreen },
  MoreMsg = { fg = c.green },
  Question = { fg = c.green },
  QuickFixLine = { bg = c.bg_sel },

  -- Syntax (legacy / fallback)
  Comment = { fg = c.comment, italic = true },
  Constant = { fg = c.yellow },
  String = { fg = c.green },
  Character = { fg = c.green },
  Number = { fg = c.byellow },
  Boolean = { fg = c.yellow },
  Float = { fg = c.byellow },
  Identifier = { fg = c.fg },
  Function = { fg = c.bblue },
  Statement = { fg = c.magenta },
  Conditional = { fg = c.magenta },
  Repeat = { fg = c.magenta },
  Label = { fg = c.magenta },
  Operator = { fg = c.fg_dim },
  Keyword = { fg = c.magenta },
  Exception = { fg = c.red },
  PreProc = { fg = c.cyan },
  Include = { fg = c.cyan },
  Define = { fg = c.cyan },
  Macro = { fg = c.cyan },
  PreCondit = { fg = c.cyan },
  Type = { fg = c.cyan },
  StorageClass = { fg = c.cyan },
  Structure = { fg = c.cyan },
  Typedef = { fg = c.cyan },
  Special = { fg = c.bgreen },
  SpecialChar = { fg = c.bgreen },
  Tag = { fg = c.bblue },
  Delimiter = { fg = c.fg_dim },
  SpecialComment = { fg = c.comment, bold = true },
  Debug = { fg = c.red },
  Underlined = { fg = c.bblue, underline = true },
  Ignore = { fg = c.gutter },
  Error = { fg = c.red },
  Todo = { fg = c.bg, bg = c.byellow, bold = true },

  -- Treesitter
  ["@variable"] = { fg = c.fg },
  ["@variable.builtin"] = { fg = c.red },
  ["@variable.parameter"] = { fg = c.byellow },
  ["@variable.member"] = { fg = c.bcyan },
  ["@constant"] = { fg = c.yellow },
  ["@constant.builtin"] = { fg = c.yellow, bold = true },
  ["@constant.macro"] = { fg = c.cyan },
  ["@module"] = { fg = c.bblue },
  ["@label"] = { fg = c.magenta },
  ["@string"] = { fg = c.green },
  ["@string.escape"] = { fg = c.bgreen },
  ["@string.special"] = { fg = c.bgreen },
  ["@character"] = { fg = c.green },
  ["@boolean"] = { fg = c.yellow },
  ["@number"] = { fg = c.byellow },
  ["@number.float"] = { fg = c.byellow },
  ["@type"] = { fg = c.cyan },
  ["@type.builtin"] = { fg = c.cyan, italic = true },
  ["@type.definition"] = { fg = c.cyan },
  ["@attribute"] = { fg = c.cyan },
  ["@property"] = { fg = c.bcyan },
  ["@function"] = { fg = c.bblue },
  ["@function.builtin"] = { fg = c.bblue, italic = true },
  ["@function.call"] = { fg = c.bblue },
  ["@function.macro"] = { fg = c.cyan },
  ["@constructor"] = { fg = c.cyan },
  ["@operator"] = { fg = c.fg_dim },
  ["@keyword"] = { fg = c.magenta },
  ["@keyword.function"] = { fg = c.magenta },
  ["@keyword.return"] = { fg = c.magenta },
  ["@keyword.operator"] = { fg = c.magenta },
  ["@keyword.import"] = { fg = c.cyan },
  ["@keyword.exception"] = { fg = c.red },
  ["@keyword.conditional"] = { fg = c.magenta },
  ["@keyword.repeat"] = { fg = c.magenta },
  ["@punctuation.delimiter"] = { fg = c.fg_dim },
  ["@punctuation.bracket"] = { fg = c.fg_dim },
  ["@punctuation.special"] = { fg = c.bgreen },
  ["@comment"] = { fg = c.comment, italic = true },
  ["@comment.error"] = { fg = c.bg, bg = c.red },
  ["@comment.warning"] = { fg = c.bg, bg = c.yellow },
  ["@comment.todo"] = { fg = c.bg, bg = c.byellow, bold = true },
  ["@comment.note"] = { fg = c.bg, bg = c.bblue },
  ["@tag"] = { fg = c.red },
  ["@tag.attribute"] = { fg = c.byellow },
  ["@tag.delimiter"] = { fg = c.fg_dim },
  ["@markup.heading"] = { fg = c.bgreen, bold = true },
  ["@markup.strong"] = { bold = true },
  ["@markup.italic"] = { italic = true },
  ["@markup.strikethrough"] = { strikethrough = true },
  ["@markup.link"] = { fg = c.bblue, underline = true },
  ["@markup.link.url"] = { fg = c.cyan, underline = true },
  ["@markup.raw"] = { fg = c.green },
  ["@markup.list"] = { fg = c.magenta },
  ["@markup.quote"] = { fg = c.comment, italic = true },
  ["@diff.plus"] = { fg = c.green },
  ["@diff.minus"] = { fg = c.red },
  ["@diff.delta"] = { fg = c.yellow },

  -- LSP semantic tokens
  ["@lsp.type.class"] = { link = "@type" },
  ["@lsp.type.enum"] = { link = "@type" },
  ["@lsp.type.interface"] = { link = "@type" },
  ["@lsp.type.struct"] = { link = "@type" },
  ["@lsp.type.function"] = { link = "@function" },
  ["@lsp.type.method"] = { link = "@function" },
  ["@lsp.type.variable"] = { link = "@variable" },
  ["@lsp.type.property"] = { link = "@property" },
  ["@lsp.type.parameter"] = { link = "@variable.parameter" },
  ["@lsp.type.keyword"] = { link = "@keyword" },
  ["@lsp.type.namespace"] = { link = "@module" },

  -- Diagnostics
  DiagnosticError = { fg = c.red },
  DiagnosticWarn = { fg = c.yellow },
  DiagnosticInfo = { fg = c.bblue },
  DiagnosticHint = { fg = c.cyan },
  DiagnosticOk = { fg = c.green },
  DiagnosticUnderlineError = { undercurl = true, sp = c.red },
  DiagnosticUnderlineWarn = { undercurl = true, sp = c.yellow },
  DiagnosticUnderlineInfo = { undercurl = true, sp = c.bblue },
  DiagnosticUnderlineHint = { undercurl = true, sp = c.cyan },
  DiagnosticVirtualTextError = { fg = c.red, bg = c.bg_alt },
  DiagnosticVirtualTextWarn = { fg = c.yellow, bg = c.bg_alt },
  DiagnosticVirtualTextInfo = { fg = c.bblue, bg = c.bg_alt },
  DiagnosticVirtualTextHint = { fg = c.cyan, bg = c.bg_alt },

  -- Git / diff
  DiffAdd = { bg = "#102a16" },
  DiffChange = { bg = "#1a2610" },
  DiffDelete = { bg = "#2a1010" },
  DiffText = { bg = "#244a1a" },
  Added = { fg = c.green },
  Changed = { fg = c.yellow },
  Removed = { fg = c.red },
  GitSignsAdd = { fg = c.green },
  GitSignsChange = { fg = c.yellow },
  GitSignsDelete = { fg = c.red },

  -- Spell
  SpellBad = { undercurl = true, sp = c.red },
  SpellCap = { undercurl = true, sp = c.yellow },
  SpellRare = { undercurl = true, sp = c.magenta },
  SpellLocal = { undercurl = true, sp = c.cyan },
}

for group, opts in pairs(hl) do
  vim.api.nvim_set_hl(0, group, opts)
end

-- :terminal colors (matches the Ghostty jungle palette)
vim.g.terminal_color_0 = "#12261a"
vim.g.terminal_color_1 = "#ff4d4d"
vim.g.terminal_color_2 = "#3ddc84"
vim.g.terminal_color_3 = "#ffc233"
vim.g.terminal_color_4 = "#2ea8e0"
vim.g.terminal_color_5 = "#c77dff"
vim.g.terminal_color_6 = "#25e0b8"
vim.g.terminal_color_7 = "#b6d7b0"
vim.g.terminal_color_8 = "#2f5a3a"
vim.g.terminal_color_9 = "#ff7a7a"
vim.g.terminal_color_10 = "#7dff5a"
vim.g.terminal_color_11 = "#ffe066"
vim.g.terminal_color_12 = "#5fd0ff"
vim.g.terminal_color_13 = "#e0a6ff"
vim.g.terminal_color_14 = "#5cffdc"
vim.g.terminal_color_15 = "#f4fff4"
