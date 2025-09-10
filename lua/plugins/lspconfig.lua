return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = { "clangd" }, -- Install clangd
		})

		local lspconfig = require("lspconfig")
		lspconfig.clangd.setup({
			  cmd = {
          "clangd",
          "--background-index",
          "--suggest-missing-includes",
          "--compile-commands-dir=/path/to/your/build/directory", -- Replace with your actual path
        },
        filetypes = { "c", "cpp" },
		})
	end,
}
