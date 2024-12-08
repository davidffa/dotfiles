return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	init = function()
		if vim.fn.argc(-1) == 1 then
			local stat = vim.loop.fs_stat(vim.fn.argv(0))
			if stat and stat.type == "directory" then
				require("neo-tree").setup({
					filesystem = {
						hijack_netrw_behavior = "open_current",
					},
					event_handlers = {

						{
							event = "file_opened",
							handler = function(filepath)
								require("neo-tree.command").execute({ action = "close" })
							end,
						},
					},
				})
			end
		end
	end,
	config = function()
		vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {})
	end,
}
