return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          mason = false,
          cmd = {
            "clangd",
            "--background-index",
            "-j",
            math.floor(vim.uv.available_parallelism() / 2),
            "--clang-tidy",
            "--completion-style=detailed",
            "--header-insertion=never",
            "--query-driver=/usr/bin/g++,/usr/bin/gcc,/usr/bin/clang++,/usr/bin/clang",
            "--enable-config",
          },
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
