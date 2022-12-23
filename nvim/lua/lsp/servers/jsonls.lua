local util = require 'lspconfig.util'
local status, common = pcall(require, "lsp.common")
if not status then
	return
end
local bin_name = 'vscode-json-language-server'
local cmd = { bin_name, '--stdio' }

local opts = {
	flags = common.flags,
	on_attach = function(client, bufnr)
		-- common.disableFormat(client)
		common.common_on_attach(client, bufnr)
	end,
	capabilities = common.capabilities,
	default_config = {
		cmd = cmd,
		filetypes = { 'json', 'jsonc' },
		init_options = {
			provideFormatter = true,
		},
		root_dir = util.find_git_ancestor,
		single_file_support = true,
	},
	settings = {
    json = {
    },
  },
}

return {
  setup = function(server)
    server.setup(opts)
  end,
}
