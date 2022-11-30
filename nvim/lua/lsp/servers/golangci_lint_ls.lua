local util = require 'lspconfig.util'
local common = require("lsp.common-config")

local opts = {
  flags = common.flags,
  on_attach = function(client, bufnr)
    -- common.disableFormat(client)
  common.keyAttach(bufnr)
  end,
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
    -- _G.log(opts)
    server.setup(opts)
  end

}
