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

vim.api.nvim_create_user_command("LspInfo", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  if #clients == 0 then
    vim.notify("No LSP clients attached to this buffer", vim.log.levels.WARN)
    return
  end
  local lines = {}
  for _, c in ipairs(clients) do
    table.insert(lines, ("client: %s (id=%d, pid=%s)"):format(c.name, c.id, tostring(c.rpc and c.rpc.pid)))
    table.insert(lines, ("  root_dir: %s"):format(c.root_dir or "<none>"))
    table.insert(lines, ("  cmd: %s"):format(table.concat(c.config.cmd or {}, " ")))
    table.insert(lines, ("  filetypes: %s"):format(table.concat(c.config.filetypes or {}, ", ")))
    if c.config.cmd_env then
      table.insert(lines, ("  cmd_env.PATH: %s"):format(c.config.cmd_env.PATH or "<unset>"))
    else
      table.insert(lines, "  cmd_env: <none>")
    end
  end
  vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO, { title = "LSP Info" })
end, {})
