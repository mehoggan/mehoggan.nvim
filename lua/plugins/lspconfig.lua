-- Per-project overrides, applied only when that tree is present on this
-- machine. `root` is picked by OS rather than probed with isdirectory:
-- on Windows, a driveless path like "/grmn/prj/hydra" is drive-relative
-- to whatever drive is current, so it can falsely resolve to
-- "C:/grmn/prj/hydra" and match even when the Linux path is the wrong one.
local project_overrides = {
  {
    root = vim.fn.has("win32") == 1 and "C:/grmn/prj/hydra" or "/grmn/prj/hydra",
    compile_commands_dir = "%s/_Output/wildcat",
    query_driver = "%s/_Output/archive/extract/yocto-sdk/**/aarch64-poky-linux-*",
  },
}

local function find_project_override()
  for _, o in ipairs(project_overrides) do
    if vim.fn.isdirectory(o.root) == 1 then
      return {
        compile_commands_dir = o.compile_commands_dir:format(o.root),
        query_driver = o.query_driver:format(o.root),
      }
    end
  end
  return nil
end

local function query_drivers(override)
  local drivers = { "/usr/bin/*" } -- host toolchains, always allowed
  if override then
    table.insert(drivers, override.query_driver)
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
          cmd = (function()
            local cmd = {
              "clangd",
              "--background-index",
              ("-j=%d"):format(
                math.max(1, math.floor(vim.uv.available_parallelism() / 2))
              ),
              "--clang-tidy",
              "--completion-style=detailed",
              "--background-index-priority=normal",
              "--pch-storage=memory",
              "--header-insertion=never",
              "--enable-config",
            }
            local override = find_project_override()
            if override then
              table.insert(
                cmd,
                "--compile-commands-dir=" .. override.compile_commands_dir
              )
            end
            table.insert(cmd, query_drivers(override))
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
