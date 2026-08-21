return {
  "kndndrj/nvim-dbee",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  build = function()
    require("dbee").install()
  end,
  -- Define convenient leader keybindings for LazyVim
  keys = {
    { "<leader>db", "<cmd>DbeeToggle<CR>", desc = "Toggle DBee UI" },
    { "<leader>do", "<cmd>DbeeOpen<CR>", desc = "Open DBee UI" },
    { "<leader>dc", "<cmd>DbeeClose<CR>", desc = "Close DBee UI" },
  },
  config = function()
    require("dbee").setup()
  end,
}
