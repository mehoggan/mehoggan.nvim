-- Per-project query-drivers, added only when that tree is present on this machine.
-- The key is the dir to test; the value is the clangd --query-driver glob to enable.
local function query_drivers()
  local drivers = { "/usr/bin/*" } -- host toolchains, always allowed
  local per_project = {
    ["/grmn/prj/hydra"] = "/grmn/prj/hydra/_Output/archive/extract/yocto-sdk/**/aarch64-poky-linux-*",
  }
  for dir, glob in pairs(per_project) do
    if vim.fn.isdirectory(dir) == 1 then
      table.insert(drivers, glob)
    end
  end
  return "--query-driver=" .. table.concat(drivers, ",")
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          mason = false,
          keys = {
            {
              "<leader>chs",
              function()
                vim.lsp.buf.typehierarchy("supertypes")
              end,
              desc = "Class: base classes",
            },
            {
              "<leader>chS",
              function()
                vim.lsp.buf.typehierarchy("subtypes")
              end,
              desc = "Class: derived classes",
            },
          },
          cmd = (function()
            local cmd = {
              "clangd",
              "--background-index",
              ("-j=%d"):format(
                math.max(1, math.floor(vim.uv.available_parallelism() / 2))
              ),
              "--clang-tidy",
              "--completion-style=detailed",
              "--header-insertion=never",
              "--enable-config",
            }
            local qd = query_drivers()
            if qd and qd ~= "" then
              table.insert(cmd, qd)
            end
            return cmd
          end)(),
        },
        -- YAML language server
        yamlls = {
          settings = {
            yaml = {
              validate = true,
              -- Extend schemas to recognize Zuul configuration files
              schemas = {
                ["https://schemastore.org"] = {
                  "**/zuul.d/*.yaml",
                  ".zuul.yaml",
                  "**/zuul.yaml",
                },
              },
              -- Map custom tags if your Zuul setup relies on them
              customTags = {
                "!encrypted scalar",
              },
            },
          },
          -- Dynamically resolve the root directory to your config-project path
          root_dir = function()
            local target_dir = "/grmn/zuul"

            -- Check if the conventional directory exists and is accessible
            if vim.fn.isdirectory(target_dir) == 1 then
              return target_dir
            else
              -- Fallback to the user home directory if missing
              return vim.fn.expand("$HOME")
            end
          end,
        },
      },
    },
  },
}
