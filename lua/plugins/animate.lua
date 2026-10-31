return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.animate").setup({
			cursor = { enable = true },
			scroll = { enable = true },
		})
	end,
}
