return {
  "jmacadie/telescope-hierarchy.nvim",
  branch = "feature/types",
  -- ...same dependencies/config as before...
  keys = {
    {
      "<leader>chi",
      "<cmd>Telescope hierarchy incoming_calls<cr>",
      desc = "Callers (incoming call tree)",
    },
    {
      "<leader>cho",
      "<cmd>Telescope hierarchy outgoing_calls<cr>",
      desc = "Callees (outgoing call tree)",
    },
    {
      "<leader>chs",
      "<cmd>Telescope hierarchy supertypes<cr>",
      desc = "Class: base classes (tree)",
    },
    {
      "<leader>chS",
      "<cmd>Telescope hierarchy subtypes<cr>",
      desc = "Class: derived classes (tree)",
    },
  },
}
