-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches.
-- Add your language server below:
local servers = { 'bashls', 'pyright', 'clangd', 'html', 'cssls', 'tsserver' }

local lspconfig_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_status_ok then
  return
end

local lspconfig = require("lspconfig")
-- Call setup
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    root_dir = root_dir,
    capabilities = capabilities,
    flags = {
      -- default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end

-- see : help mason-lspconfig-dynamic-server-setup to detail
require("mason").setup()
require("mason-lspconfig").setup({
	 --ensure_installed = {"clangd", "sumneko_lua", "gopls", "golangci_lint_ls", "pyright"},
	 ensure_installed = {"clangd", "sumneko_lua"},
})
require("mason-lspconfig").setup_handlers ({
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function (server) -- default handler (optional)
		local config = require("lsp.servers."..server)
		config.setup(lspconfig[server])
	end,
	-- Next, you can provide targeted overrides for specific servers.
	-- example:
	--["clangd"] = function ()
	--    require("lsp.config.clangd").setup() -- must be function
	--end,
})
