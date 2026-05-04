return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 300,
      },

      message_template = " ▶️ <summary> • <date> • <author> • <sha>",

      on_attach = function(_)
        -- Set the color for current line blame
        vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = "#000077" })
      end,
    },
  },
}
