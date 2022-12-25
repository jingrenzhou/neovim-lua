local status, _ = pcall(require, "hop")
if not status then
	return
end

--local directions = require('hop.hint').HintDirection

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
		s = {
			name = "Hop",
			a = { "<CMD>HopAnywhere<CR>", "HopAnywhere" },
			w = { "<CMD>HopWord<CR>", "HopWord" },
			W = {"<CMD>HopWordCurrentLine<CR>", "HopWordCurrentLine"},
			p = { "<CMD>HopPattern<CR>", "HopPattern" },
			l = { "<CMD>HopLine<CR>", "HopLine" },
		},
	},
}


require("which-key").register(mappings, opts)
