-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- url: https://github.com/wbthomason/packer.nvim

-- Automatically install packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
		 -- https://github.com/wbthomason/packer.nvim/issues/750
		 local data_path = fn.stdpath("data") .. "/site/pack/*/start/*"
		 if not string.find(vim.o.runtimepath, data_path) then
			 vim.o.runtimepath = data_path .. "," .. vim.o.runtimepath
		 end
		 return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Autocommand that reloads neovim whenever you save the packer_init.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerSync
    autocmd BufWritePost init.lua source <afile> | PackerCompile
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Install plugins

local spec = {
	function(use)
    -- Add you plugins here:
    use { "wbthomason/packer.nvim" } -- packer can manage itself

    -- File explorer
    use {
			"nvim-tree/nvim-tree.lua",
			config = function() require("plugins.nvim-tree") end
		}

    -- Indent line
    use {
			"lukas-reineke/indent-blankline.nvim",
			config = function() require('plugins/indent-blankline') end
		}

    -- Autopair
    use {
      "windwp/nvim-autopairs",
      config = function() require('nvim-autopairs').setup{} end
    }

    -- Icons
    use { "kyazdani42/nvim-web-devicons" }

    -- Treesitter interface
    use {
      "nvim-treesitter/nvim-treesitter",
      run = function() require("nvim-treesitter.install").update({ with_sync = true }) end,
			config = function() require("plugins/nvim-treesitter") end,
    }

    -- Color schemes
    use { "navarasu/onedark.nvim" }
    use { "tanvirtin/monokai.nvim" }
    use { "rose-pine/neovim", as = "rose-pine" }

    -- LSP
    use {
			"neovim/nvim-lspconfig",
			requires = {
 				-- lspconfig extensions
				{ "williamboman/mason.nvim" },
 				{ "williamboman/mason-lspconfig.nvim" },
			},
		}
    -- Autocomplete
    use {
      "hrsh7th/nvim-cmp",
      requires = {
        "L3MON4D3/LuaSnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "saadparwaiz1/cmp_luasnip",
      },
			config = function() require("plugins/nvim-cmp") end
    }

    -- Statusline
    use {
      "feline-nvim/feline.nvim",
      requires = { "kyazdani42/nvim-web-devicons" },
      config = function() require("plugins/statusline/feline") end
    }

    -- git labels
    use {
      "lewis6991/gitsigns.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function() require("gitsigns").setup{} end
    }

    -- Dashboard (start screen)
    use {
      "goolord/alpha-nvim",
      requires = { "kyazdani42/nvim-web-devicons" },
			config = function() require("plugins/alpha-nvim") end
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      require("packer").sync()
    end

  end,

	config = {
		-- snapshot = "v2",
		snapshot_path = require("packer.util").join_paths(vim.fn.stdpath("config"), "snapshots"),
		compile_path = require("packer.util").join_paths(vim.fn.stdpath("config"), "plugin", "packer_compiled.lua"),
		max_jobs = 16,

		git = {
			-- default_url_format = "https://mirror.ghproxy.com/https://github.com/%s",
			-- default_url_format = "https://gitcode.net/mirrors/%s",
			-- default_url_format = "https://gitclone.com/github.com/%s",
		},
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
		profile = {
			enable = true,
		},
		luarocks = {
			python_cmd = "python3",
		}
	},
}

return packer.startup(spec)

