-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = false
vim.opt.clipboard = "unnamedplus"
vim.opt.colorcolumn = "80,100" -- Where to draw the color column
vim.opt.ignorecase = false -- Do not ignore case when searching
vim.opt.smartcase = false -- Do not override ignorecase if uppercase is used
vim.lsp.inlay_hint.enable(false) -- Disable inline hints for parameters
vim.opt.list = true -- Enable global whitespace visibility

vim.opt.listchars = { -- Customize how each whitespace character looks
  space = "·", -- Show spaces as middle dots
  tab = "→ ", -- Show tabs as an arrow followed by a space
  trail = "•", -- Show trailing spaces as bullets
  nbsp = "⍽", -- Show non-breaking spaces
  eol = "⤶", -- Optional: Show end-of-line/newlines
  extends = "»",
  precedes = "«",
}

vim.opt.shell = "/bin/bash"
vim.opt.termguicolors = true
vim.g.jungle_transparent = true

if vim.fn.has("win32") == 1 then
  vim.opt.shell = "powershell.exe"
  vim.opt.shellcmdflag =
    "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
  vim.opt.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; stop"
  vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; stop"
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
end
