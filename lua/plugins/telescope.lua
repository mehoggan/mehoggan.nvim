return {
	{
		"mikemcbride/telescope-mru.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
	},

	{
		"kelly-lin/telescope-ag",
		dependencies = { "nvim-telescope/telescope.nvim" },
	},

	{ "nvim-lua/plenary.nvim", lazy = true },

	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
}
