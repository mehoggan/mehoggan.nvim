vim.cmd("syntax on")

require("config.lazy")

require("hardline").setup({})

require("neogit").setup({})

require("telescope").load_extension("mru_files")

require("cscope_maps").setup()

--require("mason").setup()

require("lspconfig").clangd.setup({
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

require("lspconfig").lua_ls.setup({
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

local ls = require("luasnip")

ls.config.set_config({
	history = true, -- Enables jumping back in snippets
	enable_autosnippets = true, -- Automatically triggers snippets
})

vim.keymap.set({ "i" }, "<C-K>", function()
	ls.expand()
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-L>", function()
	ls.jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function()
	ls.jump(-1)
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true })

require("nvim-treesitter.configs").setup({
	modules = {},
	sync_install = false,
	ensure_installed = {},
	ignore_install = {},
	auto_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false, -- Set to true if you need Vim regex highlighting alongside Treesitter
	},
})

-- Lua language server configuration

vim.diagnostic.config({
	virtual_text = true,
	-- other configurations like signs, underline, etc.
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

vim.opt.omnifunc = "ale#compeltion#OmniFunc"

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		vim.keymap.set("n", "grd", vim.lsp.buf.definition, { buffer = ev.buf })
		vim.keymap.set("n", "grD", vim.lsp.buf.declaration, { buffer = ev.buf })
	end,
})

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
