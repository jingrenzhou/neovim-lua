local status, _ = pcall(require, "Comment")
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

local vopts = {
	mode = "v", -- VISUAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	["/"] = {
		name = "Comment",
		["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment toggle current line" },
		b = { "<Plug>(comment_toggle_blockwise_current)", "Comment toggle current block" },
	},
}

local vmappings = {
	name = "Comment",
	["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise (visual)" },
	b = { "<Plug>(comment_toggle_blockwise_visual)", "Comment toggle blockwise (visual)" },
}

require("which-key").register(mappings, opts)
require("which-key").register(vmappings, vopts)
