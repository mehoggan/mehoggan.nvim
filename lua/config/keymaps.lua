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
vim.keymap.set("n", "<leader>uw", "<cmd>set list!<cr>", { desc = "Toggle Whitespace Visibility" })
