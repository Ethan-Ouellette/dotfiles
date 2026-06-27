return {
	{
		"mrjones2014/smart-splits.nvim",
		lazy = false,
		opts = {
			at_edge = "wrap",
		},
		config = function(_, opts)
			-- change focus window
			vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left, { desc = "Move to left window" })
			vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down, { desc = "Move to down window" })
			vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up, { desc = "Move to up window" })
			vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right, { desc = "Move to right window" })
			-- resize window
			vim.keymap.set("n", "<M-h>", require("smart-splits").resize_left, { desc = "smart resize left" })
			vim.keymap.set("n", "<M-j>", require("smart-splits").resize_down, { desc = "smart resize down" })
			vim.keymap.set("n", "<M-k>", require("smart-splits").resize_up, { desc = "smart resize up" })
			vim.keymap.set("n", "<M-l>", require("smart-splits").resize_right, { desc = "smart resize right" })
			require("smart-splits").setup(opts)
		end,
	},
	{
		"otavioschwanck/arrow.nvim",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			-- or if using `mini.icons`
			-- { "echasnovski/mini.icons" },
		},
		opts = {
			show_icons = true,
			leader_key = "<leader>m", -- Recommended to be a single key
			buffer_leader_key = "<leader>M", -- Per Buffer Mappings
		},
	},
}
