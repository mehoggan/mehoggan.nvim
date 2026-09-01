return {
	-- 1. Visual guide + textwidth for Lua
	{
		"LazyVim/LazyVim",
		opts = function()
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("eighty_col", { clear = true }),
				pattern = "lua",
				callback = function()
					vim.opt_local.colorcolumn = "80"
					vim.opt_local.textwidth = 80
					-- wrap comments at 80, but NOT code (no "t")
					vim.opt_local.formatoptions = vim.opt_local.formatoptions + "c" + "q" + "j"
				end,
			})
		end,
	},

	-- 2. Enforce 80 on save via stylua (LazyVim ships conform.nvim)
	{
		"stevearc/conform.nvim",
		opts = {
			formatters = {
				stylua = {
					prepend_args = { "--column-width", "80" },
				},
			},
			formatters_by_ft = {
				lua = { "stylua" },
			},
		},
	},
}
