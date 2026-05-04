return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = true,
    keys = {
      { "<leader>gD", "<cmd>DiffviewOpen<cr>", desc = "DiffView Open" },
      { "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "DiffView File History" },
    },
  },
}
