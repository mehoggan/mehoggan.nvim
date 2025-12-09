return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"jay-babu/mason-nvim-dap.nvim",
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"williamboman/mason.nvim",
		"mfussenegger/nvim-dap-python",
		"nvim-dap-ui",
		"nvim-dap-virtual-text",
		"nvim-telescope/telescope-dap.nvim",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local mason_dap = require("mason-nvim-dap")
		local mason = require("mason")

		mason.setup()

		dapui.setup()

		vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = "🚏", texthl = "", linehl = "", numhl = "" })

    dap.set_log_level(vim.log.levels.DEBUG)

		dap.adapters.cppdbg = {
			id = "cppdbg",
			type = "executable",
			command = "~/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
      env = {
        LD_LIBRARY_PATH = "./build/lib/.libs" .. ":" .. (os.getenv("LD_LIBRARY_PATH") or "")
      }
		}

    --[[
    dap.adapters.lldb = {
      id = "lldb",
      type = "executable",
      command = "lldb-dap",
    }
    ]]

    dap.adapters.codelldb = {
      type = "server",
      executable = {
        command = "~/.local/share/nvim/mason/bin/codelldb",
      }
    }

		dap.adapters.python = {
			command = "python",
			type = "executable",
			args = { "-m", "debugpy.adapter" },
		}

		mason_dap.setup({
			ensure_installed = { "cppdbg" }, -- Install the C++ debug adapter
			automatic_installation = true,
			handlers = {
				function(config)
					mason_dap.default_setup(config)
				end,
			},
		})

		-- DAP configurations for C++
		dap.configurations.cpp = {
			{
				name = "launch",
				type = "codelldb", -- Change to cppdbg for gdb
				request = "launch",
				program = function()
					return vim.fn.input("Executable path to debug: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = true,
				setupCommands = {
					{
						text = "-enable-pretty-printing",
						description = "enable pretty printing",
						ignoreFailures = false,
					},
				},
			},
			-- You can add more configurations here, e.g., for attaching to a process
		}

		-- Keymaps for DAP UI
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "DAP Continue" })
		vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "DAP Step Into" })
		vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "DAP Step Over" })
		vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "DAP Step Out" })
		vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "DAP Step Over" })
		vim.keymap.set("n", "<leader>dk", dap.close, { desc = "Kill Session" })
		vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>dU", dap.up, { desc = "Debug: DAP Stack UP" })
		vim.keymap.set("n", "<leader>dD", dap.down, { desc = "Debug: DAP Stack DOWN" })
		vim.keymap.set("n", "<leader>dB", function()
			local condition = vim.fn.input("Breakpoint condition: ")
			require("dap").set_breakpoint(condition)
		end, { desc = "Set Conditional Breakpoint" })

		local dap_python = require("dap-python")
		dap_python.setup("/usr/bin/python3")
		dap_python.test_runner = "pytest"
		dap_python.default_port = 38000

		dap.listeners.after.event_initialized["dapui_config"] = function()
			require("dapui").open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			require("dapui").close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			require("dapui").close()
		end
	end,
}

--[[
require('dap').step_back(): Steps back to the previous line of code (if supported by the debugger).
require('dap').reverse_continue(): Continues execution backward (if supported by the debugger).
require('dap').toggle_breakpoint(): Toggles a breakpoint on the current line.
require('dap').clear_breakpoints(file_path): Clears all breakpoints in a specified file.
require('dap').clear_all_breakpoints(): Clears all breakpoints in the current debugging session.
require('dap').run_last(): Reruns the last launched or attached debug configuration.
require('dap').restart(): Restarts the current debugging session.
require('dap').stop(): Stops the current debugging session.
require('dap').pause(): Pauses the execution of the program.
require('dap').evaluate(expression, frame_id): Evaluates an expression in the current scope or a specified frame.
require('dap').repl.open(): Opens the Debug Adapter Protocol (DAP) Read-Eval-Print Loop (REPL).
require('dap').repl.send(message): Sends a message to the REPL.
require('dap').repl.close(): Closes the REPL.
UI-Related Commands (often used with nvim-dap-ui):
require('dapui').toggle({}): Toggles the visibility of the DAP UI panels.
require('dapui').open(): Opens the DAP UI panels.
require('dapui').close(): Closes the DAP UI panels.
require('dap.ui.widgets').hover(): Shows variable information under the cursor.
require('dap.ui.widgets').scopes(): Opens a floating window to inspect variables in the current scope.
require('dap.ui.widgets').watches(): Opens a floating window to manage watch expressions.
require('dap.ui.widgets').breakpoints(): Opens a floating window to manage breakpoints.
require('dap.ui.widgets').stack_frames(): Opens a floating window to navigate the call stack.
--]]
