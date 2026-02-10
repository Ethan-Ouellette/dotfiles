return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",

		opts = {
			-- Parsers you actually want installed
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
				"python",
				"go",
				"javascript",
				"sml",
			},

			-- Do NOT auto-install on buffer open
			auto_install = false,

			highlight = {
				enable = true,

				-- Disable for large files
				-- disable = function(_, buf)
				--   local max_filesize = 100 * 1024 -- 100 KB
				--   local ok, stats = pcall(
				--     vim.loop.fs_stat,
				--     vim.api.nvim_buf_get_name(buf)
				--   )
				--   return ok and stats and stats.size > max_filesize
				-- end,

				additional_vim_regex_highlighting = false,
			},

			indent = {
				enable = true,
			},
		},
	},
}
