-- return {
-- 	{
-- 		"nvim-treesitter/nvim-treesitter",
-- 		build = ":TSUpdate",
--
-- 		opts = {
-- 			-- Parsers you actually want installed
-- 			ensure_installed = {
-- 				"c",
-- 				"lua",
-- 				"vim",
-- 				"vimdoc",
-- 				"query",
-- 				"markdown",
-- 				"markdown_inline",
-- 				"python",
-- 				"go",
-- 				"javascript",
-- 				"typescript",
-- 			},
--
-- 			-- Do NOT auto-install on buffer open
-- 			auto_install = false,
--
-- 			highlight = {
-- 				enable = true,
--
-- 				-- Disable for large files
-- 				-- disable = function(_, buf)
-- 				--   local max_filesize = 100 * 1024 -- 100 KB
-- 				--   local ok, stats = pcall(
-- 				--     vim.loop.fs_stat,
-- 				--     vim.api.nvim_buf_get_name(buf)
-- 				--   )
-- 				--   return ok and stats and stats.size > max_filesize
-- 				-- end,
--
-- 				additional_vim_regex_highlighting = false,
-- 			},
--
-- 			indent = {
-- 				enable = true,
-- 			},
-- 		},
-- 	},
-- }
return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local ts = require("nvim-treesitter")
			ts.setup({
				-- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
				install_dir = vim.fn.stdpath("data") .. "/site",
			})

			local parsers = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
				"python",
				"javascript",
				"typescript",
				"tsx",
			}
			for _, parser in ipairs(parsers) do
				ts.install(parser)
			end
			local patterns = {}
			for _, parser in ipairs(parsers) do
				local parser_patterns = vim.treesitter.language.get_filetypes(parser)
				for _, pp in pairs(parser_patterns) do
					table.insert(patterns, pp)
				end
			end
			-- 			vim.api.nvim_create_autocmd("FileType", {
			-- 				pattern = patterns,
			-- 				callback = function()
			-- 					vim.treesitter.start()
			-- 				end,
			--			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPre",
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				multiwindow = false, -- Enable multiwindow support.
				max_lines = 4, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 2, -- Maximum number of lines to show for a single context
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			})
		end,
	},
}
