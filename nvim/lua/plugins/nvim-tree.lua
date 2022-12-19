local icons = require("utils.icons")

local config = {
	ignore_ft_on_setup = {
		"startify",
		"dashboard",
		"alpha",
	},
	auto_reload_on_write = false,
	hijack_directories = {
		enable = false,
	},
	update_cwd = true,
	diagnostics = {
		enable = true,
		show_on_dirs = false,
		icons = {
			hint = icons.diagnostics.BoldHint,
			info = icons.diagnostics.BoldInformation,
			warning = icons.diagnostics.BoldWarning,
			error = icons.diagnostics.BoldError,
		},
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
	},
	system_open = {
		cmd = nil,
		args = {},
	},
	git = {
		enable = true,
		ignore = false,
		timeout = 200,
	},
	view = {
		width = 30,
		hide_root_folder = false,
		side = "left",
		mappings = {
			custom_only = false,
			list = {},
		},
		number = false,
		relativenumber = false,
		signcolumn = "yes",
	},
	renderer = {
		indent_markers = {
			enable = false,
			icons = {
				corner = "└",
				edge = "│",
				item = "│",
				none = " ",
			},
		},
		icons = {
			webdev_colors = true,
			show = {
				git = true,
				folder = true,
				file = true,
				folder_arrow = true,
			},
			glyphs = {
				default = icons.ui.Text,
				symlink = icons.ui.FileSymlink,
				git = {
					deleted = icons.git.FileDeleted,
					ignored = icons.git.FileIgnored,
					renamed = icons.git.FileRenamed,
					staged = icons.git.FileStaged,
					unmerged = icons.git.FileUnmerged,
					unstaged = icons.git.FileUnstaged,
					untracked = icons.git.FileUntracked,
				},
				folder = {
					default = icons.ui.Folder,
					empty = icons.ui.EmptyFolder,
					empty_open = icons.ui.EmptyFolderOpen,
					open = icons.ui.FolderOpen,
					symlink = icons.ui.FolderSymlink,
				},
			},
		},
		highlight_git = true,
		group_empty = false,
		root_folder_modifier = ":t",
	},
	filters = {
		dotfiles = false,
		custom = { "node_modules", "\\.cache" },
		exclude = {},
	},
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
	log = {
		enable = false,
		truncate = false,
		types = {
			all = false,
			config = false,
			copy_paste = false,
			diagnostics = false,
			git = false,
			profile = false,
		},
	},
	actions = {
		use_system_clipboard = true,
		change_dir = {
			enable = true,
			global = false,
			restrict_above_cwd = false,
		},
		open_file = {
			quit_on_open = false,
			resize_window = false,
			window_picker = {
				enable = true,
				chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
				exclude = {
					filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
					buftype = { "nofile", "terminal", "help" },
				},
			},
		},
	},
}

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

-- Implicitly update nvim-tree when project module is active
config.respect_buf_cwd = true
config.update_cwd = true
config.update_focused_file = { enable = true, update_cwd = true }

local function start_telescope(telescope_mode)
	local node = require("nvim-tree.lib").get_node_at_cursor()
	if not node then
		return
	end
	local abspath = node.link_to or node.absolute_path
	local is_folder = node.open ~= nil
	local basedir = is_folder and abspath or vim.fn.fnamemodify(abspath, ":h")
	require("telescope.builtin")[telescope_mode] {
		cwd = basedir,
	}
end

-- Add useful keymaps
config.view.mappings.list = {
	{ key = {"<CR>", "o" }, action = "edit", mode = "n" },
	{ key = "h", action = "close_node" },
	{ key = "v", action = "vsplit" },
	{ key = "sv", action = "split" },
	{ key = "C", action = "cd" },
	{ key = "gtf", action = "telescope_find_files", action_cb = start_telescope("find_files") },
	{ key = "gtg", action = "telescope_live_grep", action_cb = start_telescope("live_grep") },
}

nvim_tree.setup(config)

--[[
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
      vim.cmd "quit"
    end
  end
})
]]

-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close
-- nvim-tree is also there in modified buffers so this function filter it out
local modifiedBufs = function(bufs)
    local t = 0
    for _,v in pairs(bufs) do
        if v.name:match("NvimTree_") == nil then
            t = t + 1
        end
    end
    return t
end

vim.api.nvim_create_autocmd("BufEnter", {
    nested = true,
    callback = function()
        if #vim.api.nvim_list_wins() == 1 and
        vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil and
        modifiedBufs(vim.fn.getbufinfo({bufmodified = 1})) == 0 then
            vim.cmd "quit"
        end
    end
})

