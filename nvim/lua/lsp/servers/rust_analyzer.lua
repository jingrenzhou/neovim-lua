local status, common = pcall(require, "lsp.common")
if not status then
	return
end

local opts = {
	flags = common.flags,
	on_attach = function(client, bufnr)
		-- common.disableFormat(client)
		common.common_on_attach(client, bufnr)
	end,
	capabilities = common.capabilities,
  settings = {
    -- to enable rust-analyzer settings visit:
    -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
    ["rust-analyzer"] = {
      -- enable clippy on save
      checkOnSave = {
        command = "clippy",
      },
    },
  },
}

return {
  setup = function(server)
    local ok_rt, rust_tools = pcall(require, "rust-tools")
    if not ok_rt then
      print("Failed to load rust tools, will set up `rust_analyzer` without `rust-tools`.")
      server.setup(opts)
    else
      -- We don't want to call lspconfig.rust_analyzer.setup() when using rust-tools
      rust_tools.setup({
        server = opts,
        dap = require("dap.nvim-dap.rust"),
      })
    end
  end,
}