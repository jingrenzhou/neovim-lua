local status, _ = pcall(require, "bufferline")
if not status then
	return
end

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	b = {
		name = "Buffers",
		d = { "<cmd>BufferLineSortByDirectory<cr>", "Sort by directory" },
		e = { "<cmd>BufferLineSortByExtension<cr>", "Sort by language" },
		j = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
		k = { "<cmd>BufferLineCycleNext<cr>", "Next" },
		h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
		l = { "<cmd>BufferLineCloseRight<cr>", "Close all to the right" },
		p = { "<cmd>BufferLinePick<cr>", "Jump" },
		P = { "<cmd>BufferLinePickClose<cr>", "Pick which buffer to close" },
	},
}

require("which-key").register(mappings, opts)
