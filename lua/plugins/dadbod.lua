return {
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    keys = {
      { "<leader>cD", "<cmd>DBUI<cr>", desc = "Dadbod UI" },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      -- optional: keep the connections/queries drawer state on the Linux FS
      -- vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"
    end,
  },
}
