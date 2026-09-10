return {
  "zadirion/ClassDossier.nvim",
  -- Load only when an LSP is attached since it heavily relies on LSP data
  event = "LspAttach",
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  opts = {
    -- Add any custom configuration options here if needed
  },
  keys = {
    {
      "<leader>cZ",
      "<cmd>ClassDossier<cr>",
      desc = "Open Class Dossier",
    },
  },
}
