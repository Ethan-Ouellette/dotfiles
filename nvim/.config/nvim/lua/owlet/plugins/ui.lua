return {
	{
		"folke/which-key.nvim",
		event = "VimEnter",
		opts = { delay = 0 },
	},
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.ai").setup({ n_lines = 500 })
			require("mini.surround").setup()
			require("mini.pairs").setup()
			require("mini.statusline").setup({ use_icons = vim.g.have_nerd_font })
		end,
	},
}
