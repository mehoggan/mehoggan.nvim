return {
  "kdheepak/lazygit.nvim",
  cmd = {
    "LazyGit",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  -- Setting a global keymap to open Lazygit
  keys = {
    { "<leader>gl", "<cmd>LazyGit<cr>", desc = "LazyGit" },
  },
}
