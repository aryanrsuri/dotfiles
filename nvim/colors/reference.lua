-- Charcoal, muted ANSI colors, and classic Vim syntax from the Desktop references.
vim.o.background = "dark"
vim.cmd("highlight clear")
vim.g.colors_name = "reference"

local c = {
  bg = "#202020", fg = "#d0d0d0", dim = "#808080",
  red = "#af5f5f", green = "#87af5f", yellow = "#afaf5f",
  blue = "#5f87af", magenta = "#af87af", cyan = "#5f9f9f",
}

local groups = {
  Normal = { fg = c.fg, bg = c.bg },
  NormalNC = { link = "Normal" },
  NormalFloat = { link = "Normal" },
  FloatBorder = { fg = c.dim, bg = c.bg },
  Cursor = { fg = c.bg, bg = c.fg },
  TermCursor = { link = "Cursor" },
  LineNr = { fg = c.yellow, bg = c.bg },
  CursorLineNr = { link = "LineNr" },
  SignColumn = { link = "Normal" },
  FoldColumn = { link = "LineNr" },
  Folded = { fg = c.dim, bg = c.bg },
  EndOfBuffer = { fg = c.dim },
  NonText = { fg = c.dim },
  Whitespace = { link = "NonText" },
  VertSplit = { fg = c.dim, bg = c.bg },
  WinSeparator = { link = "VertSplit" },
  StatusLine = { fg = c.bg, bg = c.fg },
  StatusLineNC = { fg = c.bg, bg = c.dim },
  MsgArea = { link = "Normal" },
  ModeMsg = { fg = c.fg, bold = true },
  MoreMsg = { fg = c.green },
  Question = { fg = c.green },
  Title = { fg = c.fg, bold = true },
  Comment = { fg = c.green, bold = true },
  Constant = { fg = c.red },
  Identifier = { fg = c.fg },
  Function = { fg = c.fg },
  Statement = { fg = c.yellow },
  Operator = { fg = c.yellow },
  PreProc = { fg = c.yellow },
  Type = { fg = c.green },
  Structure = { fg = c.yellow },
  Special = { fg = c.red },
  SpecialComment = { link = "Comment" },
  Delimiter = { fg = c.fg },
  Underlined = { fg = c.cyan, underline = true },
  Ignore = { fg = c.dim },
  Error = { fg = c.red, bg = c.bg, underline = true },
  ErrorMsg = { fg = c.red },
  WarningMsg = { fg = c.yellow },
  Todo = { fg = c.yellow, bg = c.bg, bold = true },
  Visual = { bg = "#444444" },
  Search = { fg = c.bg, bg = c.yellow },
  IncSearch = { fg = c.bg, bg = c.fg },
  CurSearch = { link = "IncSearch" },
  MatchParen = { fg = c.bg, bg = c.cyan },
  Pmenu = { fg = c.fg, bg = "#303030" },
  PmenuSel = { fg = c.bg, bg = c.fg },
  PmenuSbar = { bg = "#303030" },
  PmenuThumb = { bg = c.dim },
  Directory = { fg = c.cyan },
  DiffAdd = { bg = "#293024" },
  DiffChange = { bg = "#303020" },
  DiffDelete = { fg = c.red, bg = "#302424" },
  DiffText = { bg = "#484830" },
  DiagnosticError = { fg = c.red },
  DiagnosticWarn = { fg = c.yellow },
  DiagnosticInfo = { fg = c.cyan },
  DiagnosticHint = { fg = c.dim },
  ["@variable"] = { link = "Identifier" },
  ["@property"] = { link = "Identifier" },
  ["@punctuation"] = { link = "Delimiter" },
  ["@string"] = { link = "String" },
  ["@function"] = { link = "Function" },
  ["@keyword"] = { link = "Statement" },
  ["@type"] = { link = "Type" },
  ["@comment"] = { link = "Comment" },
  -- Neovim's bundled Solidity syntax links these differently from the reference.
  solContractName = { fg = c.cyan },
  solFunction = { link = "Statement" },
  solModifierName = { link = "Statement" },
  solNatSpec = { link = "Comment" },
}
local syntax_links = {
  Constant = { "String", "Character", "Number", "Boolean", "Float" },
  Statement = { "Conditional", "Repeat", "Label", "Keyword", "Exception" },
  PreProc = { "Include", "Define", "Macro", "PreCondit" },
  Type = { "StorageClass", "Typedef" },
  Special = { "SpecialChar", "Tag", "Debug" },
}
for target, names in pairs(syntax_links) do
  for _, name in ipairs(names) do
    groups[name] = { link = target }
  end
end
local ansi = {
  c.bg, c.red, c.green, c.yellow, c.blue, c.magenta, c.cyan, c.fg,
  c.dim, "#cf7f7f", "#a7cf7f", "#cfcf7f", "#7fa7cf", "#cfa7cf", "#7fbfbf", "#eeeeee",
}
local terminal_colors = {}
for index, color in ipairs(ansi) do
  vim.g["terminal_color_" .. (index - 1)] = color
  terminal_colors[color] = terminal_colors[color] or (index - 1)
end
for name, attributes in pairs(groups) do
  if attributes.fg then
    attributes.ctermfg = terminal_colors[attributes.fg]
  end
  if attributes.bg then
    attributes.ctermbg = terminal_colors[attributes.bg] or 236
  end
  vim.api.nvim_set_hl(0, name, attributes)
end
