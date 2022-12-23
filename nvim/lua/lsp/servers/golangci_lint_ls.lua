local util = require 'lspconfig.util'
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
  default_config = {
    cmd = { 'golangci-lint-langserver' },
    filetypes = { 'go', 'gomod' },
    init_options = {
      command = { 'golangci-lint', 'run', '--out-format', 'json' },
    },
    root_dir = function(fname)
      return util.root_pattern 'go.work'(fname) or util.root_pattern('go.mod', '.golangci.yaml', '.git')(fname)
    end,
  },
  docs = {
    description = [[
Combination of both lint server and client

https://github.com/nametake/golangci-lint-langserver
https://github.com/golangci/golangci-lint


Installation of binaries needed is done via

```
go install github.com/nametake/golangci-lint-langserver@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.42.1
```

]],
    default_config = {
      root_dir = [[root_pattern('go.work') or root_pattern('go.mod', '.golangci.yaml', '.git')]],
    },
  },
}

return {
  setup = function(server)
    server.setup(opts)
  end

}
