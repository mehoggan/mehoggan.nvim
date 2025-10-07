return {
	"neovim/nvim-lspconfig",

	config = function()
		vim.lsp.config("pyright", {
      cmd = { "pyright" }
    })

		vim.lsp.config("pylsp", {
			cmd = { "pylsp" },
			filetypes = { "python" },
			settings = {
				pylsp = {
					configurationSources = { "flake8" },
					plugins = {
						jedi_completion = { enabled = true },
						jedi_hover = { enabled = true },
						jedi_references = { enabled = true },
						jedi_signature_help = { enabled = true },
						jedi_symbols = { enabled = true, all_scopes = true },
						pycodestyle = { enabled = false },
						flake8 = {
							enabled = true,
							ignore = {},
							maxLineLength = 160,
						},
						mypy = { enabled = false },
						isort = { enabled = false },
						yapf = { enabled = false },
						pylint = { enabled = false },
						pydocstyle = { enabled = false },
						mccabe = { enabled = false },
						preload = { enabled = false },
						rope_completion = { enabled = false },
					},
				},
			},
			on_attach = on_attach,
		})

		vim.lsp.config("clangd", {
			init_options = {
				compilationDatabasePath = "./build", -- or the correct path
			},
			cmd = {
				"clangd",
				"--background-index",
				"--suggest-missing-includes",
				"--compile-commands-dir=./build", -- Replace with your actual path
			},
			root_dir = require("lspconfig.util").root_pattern("build", ".git"),
		})

		vim.lsp.config("luals", {
			cmd = { "lua-language-server" },
			filetypes = { "lua" },
			root_dir = require("lspconfig").util.root_pattern(
				"~/.local/share/nvim/lazy/nvim-lspconfig/.luarc.json",
				"~/.local/share/nvim/lazy/nvim-lspconfig/.luarc.jsonc",
				"~/.local/share/nvim/lazy/nvim-lspconfig/.luacheckrc",
				"~/.local/share/nvim/lazy/nvim-lspconfig/.stylua.toml",
				"~/.local/share/nvim/lazy/nvim-lspconfig/stylua.toml",
				"~/.local/share/nvim/lazy/nvim-lspconfig/selene.toml",
				"~/.local/share/nvim/lazy/nvim-lspconfig/selene.yml",
				"~/.local/share/nvim/lazy/nvim-lspconfig/.git"
			),
			single_file_support = true,
			settings = {
				Lua = {
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true), -- Include Neovim's runtime files
					},
				},
			},
		})
	end,
}
