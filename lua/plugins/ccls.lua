return {
  -- ccls server, merged alongside your clangd/yamlls
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ccls = {
          offset_encoding = "utf-32",
          init_options = {
            compilationDatabaseDirectory = "/grmn/prj/hydra/_Output/wildcat",
            cache = {
              directory = "/grmn/prj/hydra/_Output/wildcat/.ccls-cache",
            },
            clang = {
              extraArgs = {
                -- FILL IN: run `ls <sysroot>/usr/include/c++/` and use that version dir
                "-isystem",
                "/grmn/prj/hydra/_Output/archive/extract/yocto-sdk/afc1c7f/sysroots/armv8a-poky-linux/usr/include/c++/13.4.0",
                "-isystem",
                "/grmn/prj/hydra/_Output/archive/extract/yocto-sdk/afc1c7f/sysroots/armv8a-poky-linux/usr/include/c++/13.4.0/aarch64-poky-linux",
              },
            },
            diagnostics = { onChange = -1, onOpen = -1, onSave = -1 }, -- keep clangd's lints, not ccls's
          },
        },
      },
    },
  },

  -- ccls.nvim: the inheritance tree UI
  {
    "ranjithshegde/ccls.nvim",
    config = function()
      require("ccls").setup({
        win_config = { sidebar = { size = 50, position = "left" } },
      })
      -- keep clangd primary; ccls stays resident but only answers hierarchy requests
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local c = vim.lsp.get_client_by_id(args.data.client_id)
          if c and c.name == "ccls" then
            c.server_capabilities.completionProvider = nil
            c.server_capabilities.documentFormattingProvider = nil
            c.server_capabilities.documentRangeFormattingProvider = nil
            c.server_capabilities.semanticTokensProvider = nil
          end
        end,
      })
    end,
    keys = {
      {
        "<leader>chs",
        function()
          require("ccls").inheritanceHierarchy(false, "sidebar")
        end,
        desc = "Class: base tree",
      },
      {
        "<leader>chS",
        function()
          require("ccls").inheritanceHierarchy(true, "sidebar")
        end,
        desc = "Class: derived tree",
      },
    },
  },
}
