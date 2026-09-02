-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set({ "n", "t" }, "<leader>tr", function()
  Snacks.terminal.open(nil, { win = { position = "right" } })
end, { desc = "Terminal (Vertical Right)" })
vim.keymap.set({ "n", "t" }, "<leader>tb", function()
  Snacks.terminal.open(nil, { win = { position = "bottom" } })
end, { desc = "Terminal (Horizontal Bottom)" })
vim.keymap.set(
  { "n", "t" },
  "<leader>ch",
  "<cmd>LspClangdSwitchSourceHeader<cr>",
  { desc = "Switch between source/header" }
)
vim.keymap.set("n", "[w", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
end)
vim.keymap.set(
  { "n", "t" },
  "<leader>sb",
  ':bufdo if &buftype == "terminal" | call jobsend(b:terminal_job_id, "source ~/.bashrc\\n") | endif<CR>',
  { noremap = true, desc = "Source bashrc for all open teremial buffers." }
)
vim.keymap.set(
  "n",
  "<leader>uw",
  "<cmd>set list!<cr>",
  { desc = "Toggle Whitespace Visibility" }
)
vim.keymap.set(
  "n",
  "<leader>gq",
  "<cmd>DiffviewClose<cr>",
  { desc = "Close Diffview" }
)
vim.keymap.set(
  "n",
  "<leader>mps",
  "<cmd>MarkdownPreview<cr>",
  { desc = "Markdown: Start preview" }
)
vim.keymap.set(
  "n",
  "<leader>mpS",
  "<cmd>MarkdownPreviewStop<cr>",
  { desc = "Markdown: Stop preview" }
)
vim.keymap.set(
  "n",
  "<leader>mpr",
  "<cmd>MarkdownPreviewRefresh<cr>",
  { desc = "Markdown: Refresh preview" }
)

-- LSP keymaps
vim.keymap.set("n", "grr", vim.lsp.buf.references, { desc = "LSP: References" })
vim.keymap.set(
  "n",
  "gri",
  vim.lsp.buf.implementation,
  { desc = "LSP: Implementations" }
)
vim.keymap.set("n", "grn", vim.lsp.buf.rename, { desc = "LSP: Rename" })
vim.keymap.set(
  "n",
  "gra",
  vim.lsp.buf.code_action,
  { desc = "LSP: Code Action" }
)
vim.keymap.set(
  "n",
  "grt",
  vim.lsp.buf.type_definition,
  { desc = "LSP: Type Definition" }
)
vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "LSP: Definition" })
vim.keymap.set(
  "n",
  "grD",
  vim.lsp.buf.declaration,
  { desc = "LSP: Declaration" }
)
