return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({global = false})
			end,
			desc = "Buffer local Keymaps (which-key)",
		},
	},
}