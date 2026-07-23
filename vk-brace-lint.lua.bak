-- Project-specific style check for mehoggan/intel_vulkan.
--
-- clang-tidy has no check for "Type x = {...}" vs "Type x{...}" aggregate
-- init style (both forms are semantically identical for aggregates, so no
-- stock check covers it, and clangd's clang-tidy integration only runs
-- checks compiled into clangd itself). This registers a lightweight
-- grep-based nvim-lint linter instead, scoped to files under
-- .../intel_vulkan/ so it never fires on unrelated C++ projects.
--
-- Heuristic: flags lines starting with a PascalCase type name followed by
-- a lower_snake_case identifier immediately followed by `{` (no `=`).
-- Relies on this project's own naming convention (types PascalCase,
-- variables lower_case) to avoid matching function/method definitions,
-- control-flow blocks, lambdas, and class/struct declarations. Single-line
-- only -- a type name wrapped onto its own line (e.g. when the combined
-- declaration exceeds 80 columns) won't be caught.
return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = function(_, opts)
    opts.linters = opts.linters or {}
    opts.linters.vk_brace_style = {
      cmd = "grep",
      stdin = false,
      args = {
        "-nE",
        [[^[[:space:]]*[A-Z][A-Za-z0-9_:<>]*[[:space:]]+[a-z_][A-Za-z0-9_]*\{]],
      },
      ignore_exitcode = true,
      parser = function(output)
        local diagnostics = {}
        for line in output:gmatch("[^\r\n]+") do
          local lnum = line:match("^(%d+):")
          if lnum then
            table.insert(diagnostics, {
              lnum = tonumber(lnum) - 1,
              col = 0,
              message = "Use `Type x = {...}` instead of `Type x{...}`"
                .. " (project convention, see tutorial_syntax_differences.md)",
              severity = vim.diagnostic.severity.WARN,
              source = "vk-brace-style",
            })
          end
        end
        return diagnostics
      end,
    }
    return opts
  end,
  config = function(_, opts)
    require("lint").linters = vim.tbl_extend("force", require("lint").linters, opts.linters)

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      pattern = { "*.cpp", "*.h", "*.hpp" },
      callback = function(args)
        local path = vim.api.nvim_buf_get_name(args.buf)
        if path:match("/intel_vulkan/") then
          require("lint").try_lint("vk_brace_style")
        end
      end,
    })
  end,
}
