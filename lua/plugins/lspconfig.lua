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
            "--clang-tidy",
            "--completion-style=detailed",
            "--header-insertion=never",
            "--query-driver=/usr/include/c++/13",
            "--enable-config",
          },
        },
        -- YAML language server
        yamlls = {
          settings = {
            yaml = {
              validate = true,
              schemaStore = {
                enable = true,
                url = "https://www.schemastore.org/api/json/catalog.json",
              },
              hover = true,
              completion = true,
            },
          },
        },
      },
    },
  },
}
