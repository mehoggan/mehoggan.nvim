return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    version = "v2.0.0", -- Explicitly pins the plugin version (last release before the `pumborder` check, which this nvim build's 0.12-dev doesn't yet support)
    priority = 1000,
    opts = {
      transparent_background = true,
    },
    init = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          local hl_groups = {
            "Normal",
            "NormalNC",
            "NormalFloat",
            "FloatBorder",
            "LineNr",
            "SignColumn",
            "StatusLine",
            "MsgArea",
            "EndOffLine",
            "NeoTreeNormal",
            "NeoTreeNormalNC",
            "LazyNormal",
            "DashboardHeader",
            "DashboardFooter",
          }
          for _, group in ipairs(hl_groups) do
            vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
          end
        end,
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
