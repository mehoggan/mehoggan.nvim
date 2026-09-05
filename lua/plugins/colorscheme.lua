-- ~/.config/nvim/lua/plugins/colorscheme.lua
-- Tell LazyVim to use the jungle colorscheme. Opaque background, no transparency.

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
          if not vim.g.jungle_transparent then
            return
          end
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
