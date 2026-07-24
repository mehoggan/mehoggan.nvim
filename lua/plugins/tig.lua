--[[
# Add these lines to ~/.config/tig/config
# Graph lives in main-view only. Oneline-ish: hash + graph + refs + subject.
set main-view = line-number:no id:yes,width=8 date:no author:no \
                commit-title:yes,graph=v2,refs=yes,overflow=no

set line-graphics = utf-8
set commit-order = topo
  --]]
return {
  "codeindulgence/vim-tig",
  cmd = { "Tig" },
  keys = {
    { "<leader>gt", "<cmd>Tig<cr>", desc = "Tig Status" },
    { "<leader>gT", "<cmd>Tig!<cr>", desc = "Tig Current File Log" },
    { "<leader>ga", "<cmd>Tig --all<cr>", desc = "Tig graph (all branches)" },
    {
      "<leader>gb",
      function()
        vim.ui.input({
          prompt = "Refs (space separated): ",
          completion = "customlist,v:lua.__tig_ref_complete",
        }, function(input)
          if not input then
            return
          end
          input = vim.trim(input)
          if input == "" then
            return
          end
          vim.schedule(function()
            vim.cmd("Tig " .. input)
          end)
        end)
      end,
      desc = "Tig graph (specific branches)",
    },
  },
  config = function()
    vim.g.tig_default_command = "status"
    vim.g.tig_margin = 6
    vim.g.tig_on_exit = "bw!"
  end,
}
