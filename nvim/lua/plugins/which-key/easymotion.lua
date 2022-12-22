local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	s = {
		name = "Search",
		e = {
			name = "Easymotion",
			s = { "<Plug>(easymotion-sn)", "Search characters" },
			f = { "<Plug>(easymotion-fn)", "Search characters under the cursor" },
			h = { "<Plug>(easymotion-linebackward)", "Move position left" },
			l = { "<Plug>(easymotion-lineforward)", "Move position right" },
			p = { "<Plug>(easymotion-prev)", "Jump to previous match" },
			n = { "<Plug>(easymotion-next)", "Jump to next match" },
		},
	},
}

require("which-key").register(mappings, opts)
