return {
  {
    "lambdalisue/vim-suda",
    config = function()
      -- Automatically read and write with sudo when you don't have permissions
      vim.g.suda_smart_edit = 1
    end,
  },
}
