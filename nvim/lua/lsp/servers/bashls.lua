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
}
return {
  setup = function(server)
    server.setup(opts)
  end,
}
