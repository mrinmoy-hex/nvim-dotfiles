return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return math.floor(vim.o.columns * 0.4)
				end
			end,
			direction = "horizontal",
			start_in_insert = true,
			insert_mappings = true,
			terminal_mappings = true,
			persist_size = true,
			persist_mode = true,
			close_on_exit = true,
			float_opts = {
				border = "curved",
			},
		},
		keys = {
			{
				"<C-`>",
				"<cmd>ToggleTerm direction=horizontal<cr>",
				mode = { "n", "t" },
				desc = "Toggle bottom terminal",
			},
			{
				"<leader>t",
				"<cmd>ToggleTerm direction=horizontal<cr>",
				desc = "Toggle bottom terminal",
			},
			{
				"<leader>tf",
				"<cmd>ToggleTerm direction=float<cr>",
				desc = "Toggle floating terminal",
			},
			{
				"<leader>tv",
				"<cmd>ToggleTerm direction=vertical<cr>",
				desc = "Toggle side terminal",
			},
		},
	},
}
