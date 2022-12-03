local config = {
	active = true,
	style = "lunarvim",
	options = {
		icons_enabled = nil,
		component_separators = nil,
		section_separators = nil,
		theme = nil,
		disabled_filetypes = nil,
		globalstatus = true,
	},
	sections = {
		lualine_a = nil,
		lualine_b = nil,
		lualine_c = nil,
		lualine_x = nil,
		lualine_y = nil,
		lualine_z = nil,
	},
	inactive_sections = {
		lualine_a = nil,
		lualine_b = nil,
		lualine_c = nil,
		lualine_x = nil,
		lualine_y = nil,
		lualine_z = nil,
	},
	tabline = nil,
	extensions = nil,
	on_config_done = nil,
}

local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local style = require("plugins/statusline/lualine/styles").get_style(config.style)

config = vim.tbl_deep_extend("keep", config, style)

-- set colorscheme
config.theme = vim.g.colors_name

lualine.setup(config)

if config.on_config_done then
	config.on_config_done(config)
end
