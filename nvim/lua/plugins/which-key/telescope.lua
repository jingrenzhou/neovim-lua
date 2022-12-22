local status, _ = pcall(require, "telescope")
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
		f = { "<cmd>Telescope buffers<cr>", "Find" },
	},
	g = {
		name = "Git",
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		C = {
			"<cmd>Telescope git_bcommits<cr>",
			"Checkout commit(for current file)",
		},
		f = { "<cmd>Telescope git_files<cr>", "Open file list in git repo"},
		s = { "<cmd>Telescope git_status<cr>", "Open changed file" },
	},
	l = {
		name = "Lsp",
		d = { "<cmd>Telescope lsp_definitions theme=get_ivy<cr>", "Lsp Definitions" },
		D = {"<cmd>Telescope lsp_type_definitions theme=get_ivy<cr>", "Lsp Type Definitions" },
		r = { "<cmd>Telescope lsp_references theme=get_ivy<cr>", "Lsp References" },
		i = { "<cmd>Telescope lsp_implementations theme=get_ivy<cr>", "Lsp Implementations" },
		g = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
		G = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		S = {
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			"Workspace Symbols",
		},
		e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
	},
	s = {
		name = "Search",
		c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
		f = { "<cmd>Telescope find_files<cr>", "Find File" },
		g = { "<cmd>Telescope grep_string<cr>", "Find Strings" },
		h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		m = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		o = { "<cmd>Telescope resume<cr>", "Recall" },
		p = {
			"<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
			"Colorscheme with Preview",
		},
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		t = { "<cmd>Telescope live_grep<cr>", "Text" },

	},
}

require("which-key").register(mappings, opts)
