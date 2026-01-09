return {
	{
		"nvim-tree/nvim-tree.lua",
    width = 200,
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({})
		end,
	}
}
