return {
	{ "rose-pine/neovim", name = "rose-pine" },
	{
		"EdenEast/nightfox.nvim",
		name = "nightfox",
		priority = 1000,
		--	config = function()
		--		vim.cmd.colorscheme("nightfox")
		--	end,
	},
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		priority = 1000,
		--	config = function()
		--		vim.cmd.colorscheme("kanagawa")
		--	end,
	},
	{
		"sainnhe/gruvbox-material",
		-- lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_enable_italic = true
			-- 	vim.cmd.colorscheme("gruvbox-material")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				integrations = {
					treesitter = true,
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"AlexvZyl/nordic.nvim",
		priority = 1000,
		-- config = function()
		-- 	vim.cmd.colorscheme("nordic")
		-- end,
	},
}
