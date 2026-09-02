-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_user_command("LspRestart", function(o)
  local name = o.args ~= "" and o.args or nil
  for _, c in ipairs(vim.lsp.get_clients({ name = name })) do
    c:stop(true)
  end
  vim.defer_fn(function()
    vim.cmd.edit()
  end, 200)
end, { nargs = "?" })
