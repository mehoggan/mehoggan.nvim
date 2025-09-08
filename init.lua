require("config.lazy")

require("hardline").setup({})

require("neogit").setup({})

require("telescope").load_extension("mru_files")

require("cscope_maps").setup()

-- For defaults see: https://neovim.io/doc/user/lsp.html#lsp-defaults
require("lspconfig").clangd.setup({
	-- Optional: Add specific settings for clangd
	-- For example, to enable semantic highlighting:
	capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
	cmd = { "clangd" }, -- Ensure clangd is in your PATH or provide the full path
	filetypes = { "h", "hxx", "hpp", "c", "cpp", "cxx" },
	init_options = {
		compilationDatabasePath = "./build", -- Or any other relative/absolute path
	},
	root_dir = require("lspconfig.util").root_pattern("build/compile_commands.json", ".git"),
})

local lspconfig = require("lspconfig")

-- Lua language server configuration

vim.diagnostic.config({
	virtual_text = true,
	-- other configurations like signs, underline, etc.
})

lspconfig.lua_ls.setup({
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_dir = lspconfig.util.root_pattern(
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

vim.opt.expandtab = true -- Converts tabs to spaces
vim.opt.shiftwidth = 2 -- Number of spaces for each indent level
vim.opt.tabstop = 2 -- Number of spaces a tab character represents
vim.opt.softtabstop = 2 -- Number of spaces a <Tab> counts for when inserting

vim.opt.colorcolumn = "80,100"
vim.cmd("highlight ColorColumn guibg=#333333 ctermbg=darkgrey")

vim.cmd("packadd termdebug")

local function file_exists(filename)
	local file = io.open(filename, "r") -- Attempt to open the file in read mode
	if file then
		-- If the file opened successfully, it exists. Close it and return true.
		file:close()
		return true
	else
		-- If io.open returns nil, the file does not exist or cannot be accessed.
		return false
	end
end

local map = vim.api.nvim_set_keymap

map("n", "<F2>", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle NvimTree" })
map("n", "<F3>", ":Telescope mru_files<CR>", { noremap = true, silent = true, desc = "Toggle MRU" })
map("n", "<F4>", ":FzfLua files<CR>", { noremap = true, silent = true, desc = "Toggle FzF" })
map("n", "<F5>", ":Termdebug<CR>", { noremap = true, silent = true, desc = "Opens up GDB" })

function CScopeAdd()
	local cscope_file = vim.fn.getcwd() .. "/" .. "cscope.out"
	if file_exists(cscope_file) then
		print("Adding " .. cscope_file .. "...")
		vim.cmd(":Cs db add")
	end
end

function CScopeGenerate()
	local find_cmd = "find"
		.. " "
		.. vim.fn.getcwd()
		.. " "
		.. '-name "*.c" -o -name "*.cpp" -o -name "*.h"  -o -name "*.hpp" '
		.. " > cscope.files"
	print("Running " .. find_cmd .. "...")
	local find_pid = vim.fn.jobstart(find_cmd, { cwd = vim.fn.getcwd() })
	vim.fn.jobwait({ find_pid })
	print("Done with " .. find_pid)
	local cscope_cmd = "cscope -b -q -i cscope.files"
	print("Running " .. cscope_cmd .. "...")
	local cscope_pid = vim.fn.jobstart(cscope_cmd, { cwd = vim.fn.getcwd() })
	vim.fn.jobwait({ cscope_pid })
	print("Done with " .. cscope_pid)
end

function CTagsGenerate()
	local current_dir = vim.fn.getcwd()
	local ctags_cmd = current_dir .. "/.git/hooks/ctags"
	print("Running " .. ctags_cmd .. "...")
	local ctags_pid = vim.fn.jobstart(ctags_cmd)
	vim.fn.jobwait({ ctags_pid })
	print("Done with " .. ctags_cmd)
end

function HelpLsp()
	print('"grn" is mapped in Normal mode to vim.lsp.buf.rename()')
	print('"gra" is mapped in Normal and Visual mode to vim.lsp.buf.code_action()')
	print('"grr" is mapped in Normal mode to vim.lsp.buf.references()')
	print('"gri" is mapped in Normal mode to vim.lsp.buf.implementation()')
	print('"grt" is mapped in Normal mode to vim.lsp.buf.type_definition()')
	print('"gO" is mapped in Normal mode to vim.lsp.buf.document_symbol()')
	print("CTRL-S is mapped in Insert mode to vim.lsp.buf.signature_help()")
	print(
		'"an" and "in" are mapped in Visual mode to outer and inner incremental selections, '
			.. "respectively, using vim.lsp.buf.selection_range()"
	)
end
