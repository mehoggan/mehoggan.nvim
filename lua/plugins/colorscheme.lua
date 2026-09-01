return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "jungle",
    },
    init = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "jungle",
        callback = function()
          for _, group in ipairs({
            "Normal",
            "NormalNC",
            "NormalFloat",
            "FloatBorder",
            "LineNr",
            "SignColumn",
            "StatusLine",
            "MsgArea",
            "EndOfBuffer",
            "LazyNormal",
            "NeoTreeNormal",
            "NeoTreeNormalNC",
          }) do
            vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
          end
        end,
      })
    end,
  },
}
