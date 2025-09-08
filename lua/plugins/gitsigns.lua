return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			-- Your gitsigns configuration options go here
			-- For example:
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "✖" },
				topdelete = { text = "▲" },
				changedelete = { text = "▎" },
			},
			on_attach = function(bufnr)
				-- Keymaps or other actions that depend on gitsigns being loaded
				local gs = package.loaded.gitsigns

				vim.keymap.set("n", "<leader>gp", gs.prev_hunk, { buffer = bufnr, desc = "Previous Hunk" })
				vim.keymap.set("n", "<leader>gn", gs.next_hunk, { buffer = bufnr, desc = "Next Hunk" })
				-- Add more keymaps or setup other gitsigns features here
			end,
		})
	end,
}
