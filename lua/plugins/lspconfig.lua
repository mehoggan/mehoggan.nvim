return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "clangd" }, -- Ensure clangd is installed
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		-- Optional: Add lazy loading options here if desired,
		-- e.g., event = "BufReadPre", or ft = { "lua", "python" }
	},
	-- Other plugins...
}
