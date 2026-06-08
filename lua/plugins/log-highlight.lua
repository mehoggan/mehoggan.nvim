return {
  {
    "fei6409/log-highlight.nvim",
    config = function()
      require("log-highlight").setup({})
    end,
    -- Ensure it loads when you open a log file
    ft = { "log" },
  },
}
