return {
  { "github/copilot.vim" },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      model = "gpt-5-mini", -- pin an explicit, lighter model instead of Auto
      temperature = 0.1,
      auto_fold = true, -- current option name (replaces show_folds)

      -- Leave system_prompt unset unless you have a specific reason;
      -- the default carries the diff/review formatting the prompts rely on.

      window = {
        layout = "vertical",
        width = 0.4,
      },
    },
    keys = {
      { "<leader>zc", ":CopilotChat<CR>", mode = "n", desc = "Chat with Copilot" },
      { "<leader>ze", ":CopilotChatExplain<CR>", mode = "v", desc = "Explain Code" },
      { "<leader>zr", ":CopilotChatReview<CR>", mode = "v", desc = "Review Code" },
      { "<leader>zf", ":CopilotChatFix<CR>", mode = "v", desc = "Fix Code Issues" },
      { "<leader>zo", ":CopilotChatOptimize<CR>", mode = "v", desc = "Optimize Code" },
      { "<leader>zd", ":CopilotChatDocs<CR>", mode = "v", desc = "Generate Documentation" },
      { "<leader>zt", ":CopilotChatTest<CR>", mode = "v", desc = "Generate Tests" },

      -- Reset chat (clears re-sent history) — the real token-saver
      { "<leader>zx", ":CopilotChatReset<CR>", mode = "n", desc = "Reset Copilot chat" },

      -- Targeted search: scope with a #grep resource instead of dumping the buffer
      {
        "<leader>zs",
        function()
          local input = vim.fn.input("Search pattern: ")
          if input ~= "" then
            require("CopilotChat").ask("#grep:" .. input .. " Find and explain matches")
          end
        end,
        mode = "n",
        desc = "Scoped codebase search",
      },
    },
  },
}
