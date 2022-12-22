local status, _ = pcall(require, "nvim-tree")
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
	m = {
		name = "Misc",
		t = { "<cmd>NvimTreeToggle<cr>", "Open/Close NvimTree" },
	},
}

require("which-key").register(mappings, opts)
