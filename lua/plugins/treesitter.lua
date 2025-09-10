return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- This will update parsers when the plugin is updated
    config = function()
      require("nvim-treesitter.configs").setup({
        -- Your Tree-sitter configuration goes here
      })
    end,
  },
}
