local status, common = pcall(require, "lsp.common")
if not status then
	return
end
local util = require 'lspconfig.util'

local function reload_workspace(bufnr)
  bufnr = util.validate_bufnr(bufnr)
  vim.lsp.buf_request(bufnr, 'rust-analyzer/reloadWorkspace', nil, function(err)
    if err then
      error(tostring(err))
    end
    vim.notify 'Cargo workspace reloaded'
  end)
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
  default_config = {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_dir = function(fname)
      local cargo_crate_dir = util.root_pattern 'Cargo.toml'(fname)
      local cmd = { 'cargo', 'metadata', '--no-deps', '--format-version', '1' }
      if cargo_crate_dir ~= nil then
        cmd[#cmd + 1] = '--manifest-path'
        cmd[#cmd + 1] = util.path.join(cargo_crate_dir, 'Cargo.toml')
      end
      local cargo_metadata = ''
      local cargo_metadata_err = ''
      local cm = vim.fn.jobstart(cmd, {
        on_stdout = function(_, d, _)
          cargo_metadata = table.concat(d, '\n')
        end,
        on_stderr = function(_, d, _)
          cargo_metadata_err = table.concat(d, '\n')
        end,
        stdout_buffered = true,
        stderr_buffered = true,
      })
      if cm > 0 then
        cm = vim.fn.jobwait({ cm })[1]
      else
        cm = -1
      end
      local cargo_workspace_dir = nil
      if cm == 0 then
        cargo_workspace_dir = vim.json.decode(cargo_metadata)['workspace_root']
        if cargo_workspace_dir ~= nil then
          cargo_workspace_dir = util.path.sanitize(cargo_workspace_dir)
        end
      else
        vim.notify(
          string.format('[lspconfig] cmd (%q) failed:\n%s', table.concat(cmd, ' '), cargo_metadata_err),
          vim.log.levels.WARN
        )
      end
      return cargo_workspace_dir
        or cargo_crate_dir
        or util.root_pattern 'rust-project.json'(fname)
        or util.find_git_ancestor(fname)
    end,
  },
  commands = {
    CargoReload = {
      function()
        reload_workspace(0)
      end,
      description = 'Reload current cargo workspace',
    },
  },
  docs = {
    description = [[
https://github.com/rust-analyzer/rust-analyzer
rust-analyzer (aka rls 2.0), a language server for Rust
See [docs](https://github.com/rust-analyzer/rust-analyzer/tree/master/docs/user#settings) for extra settings.
    ]],
    default_config = {
      root_dir = [[root_pattern("Cargo.toml", "rust-project.json")]],
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
      })
    end
  end,
}
