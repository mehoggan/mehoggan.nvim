-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set({ "n", "t" }, "<leader>tr", function()
  Snacks.terminal.open(nil, { win = { position = "right" } })
end, { desc = "Terminal (Vertical Right)" })
vim.keymap.set({ "n", "t" }, "<leader>tb", function()
  Snacks.terminal.open(nil, { win = { position = "bottom" } })
end, { desc = "Terminal (Horizontal Bottom)" })
