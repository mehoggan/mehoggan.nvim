return {
	{
		"dense-analysis/ale",
		-- Optional: Configure ALE settings
		config = function()
			vim.g.ale_fix_on_save = 1
			vim.g.ale_sign_column_always = 1
			vim.g.ale_linters = {
				cpp = { "clangtidy", "cpplint", "cspell" },
				c = { "clangtidy", "cpplint" },
			}
			vim.g.ale_fixers = {
				cpp = { "clang-format" },
				c = { "clang-format" },
				["*"] = { "remove_trailing_lines", "trim_whitespace" },
			}
			vim.g.ale_cpp_clangtidy_executable = 'clang-tidy'
			vim.g.ale_c_parse_compile_commands = 1
			vim.g.ale_cpp_parse_compile_commands = 1
			vim.g.ale_set_balloons = 1
			vim.g.ale_linters_explicit = 1
			vim.g.ale_completion_enabled = 1
      vim.g.ale_c_build_dir = './build'
      vim.g.ale_cpp_build_dir = './build'
		end,
	},
}
