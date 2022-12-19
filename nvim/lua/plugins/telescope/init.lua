local function get_pickers(actions)
	return {
		find_files = {
			theme = "dropdown",
			hidden = true,
			previewer = false,
		},
		live_grep = {
			--@usage don't include the filename in the search results
			only_sort_text = true,
			theme = "dropdown",
		},
		grep_string = {
			only_sort_text = true,
			theme = "dropdown",
		},
		buffers = {
			theme = "dropdown",
			previewer = false,
			initial_mode = "normal",
			mappings = {
				i = {
					["<leader>d"] = actions.delete_buffer,
				},
				n = {
					["dd"] = actions.delete_buffer,
				},
			},
		},
		planets = {
			show_pluto = true,
			show_moon = true,
		},
		git_files = {
			theme = "dropdown",
			hidden = true,
			previewer = false,
			show_untracked = true,
		},
		lsp_references = {
			theme = "dropdown",
			initial_mode = "normal",
		},
		lsp_definitions = {
			theme = "dropdown",
			initial_mode = "normal",
		},
		lsp_declarations = {
			theme = "dropdown",
			initial_mode = "normal",
		},
		lsp_implementations = {
			theme = "dropdown",
			initial_mode = "normal",
		},
	}
end

local status, telescope = pcall(require, "telescope")
if not status then
	return
end

local actions = require("telescope.actions")

local icons = require("utils.icons")
local config = {
	defaults = {
		prompt_prefix = icons.ui.Telescope .. " ",
		selection_caret = icons.ui.Forward .. " ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "descending",
		layout_strategy = "horizontal",
		layout_config = {
			width = 0.75,
			preview_cutoff = 120,
			horizontal = {
				preview_width = function(_, cols, _)
					if cols < 120 then
						return math.floor(cols * 0.5)
					end
					return math.floor(cols * 0.6)
				end,
				mirror = false,
			},
			vertical = { mirror = false },
		},
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--hidden",
			"--glob=!.git/",
		},
		---@usage Mappings are fully customizable. Many familiar mapping patterns are setup as defaults.
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-c>"] = actions.close,
				["<C-n>"] = actions.cycle_history_next,
				["<C-p>"] = actions.cycle_history_prev,
				["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
				["<CR>"] = actions.select_default,
			},
			n = {
				["j"] = actions.move_selection_next,
				["k"] = actions.move_selection_previous,
				["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
				["q"] = actions.close,
			},
		},
		pickers = get_pickers(actions),
		file_ignore_patterns = {},
		path_display = { "smart" },
		winblend = 0,
		border = {},
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		color_devicons = true,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
	},
	pickers = get_pickers(actions),
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		},
	},
}

local previewers = require "telescope.previewers"
local sorters = require "telescope.sorters"

config = vim.tbl_extend("keep", {
	file_previewer = previewers.vim_buffer_cat.new,
	grep_previewer = previewers.vim_buffer_vimgrep.new,
	qflist_previewer = previewers.vim_buffer_qflist.new,
	file_sorter = sorters.get_fuzzy_file,
	generic_sorter = sorters.get_generic_fuzzy_sorter,
}, config)

telescope.setup(config)
--telescope.load_extension("projects")
telescope.load_extension("fzf")
telescope.load_extension("lsp_handlers")
