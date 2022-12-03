-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- url: https://github.com/wbthomason/packer.nvim

-- For information about installed plugins see the README:
-- neovim-lua/README.md
-- https://github.com/brainfucksec/neovim-lua#readme


-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end

-- Autocommand that reloads neovim whenever you save the packer_init.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer_init.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Install plugins
return packer.startup{
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
    snapshots = "v1",
    snapshot_path = require("packer.util").join_paths(vim.fn.stdpath("config"), "snapshots"),
    compile_path = require("packer.util").join_paths(vim.fn.stdpath("config"), "plugin", "packer_compiled.lua"),
    max_jobs = 16,
    luarocks = {
      python_cmd = "python3",
    },

    git = {
      -- default_url_format = "https://hub.fastgit.xyz/%s",
      -- default_url_format = "https://mirror.ghproxy.com/https://github.com/%s",
      -- default_url_format = "https://gitcode.net/mirrors/%s",
      -- default_url_format = "https://gitclone.com/github.com/%s",
    },
    -- display = {
      -- 使用浮动窗口显示
      --   open_fn = function()
        --     return require("packer.util").float({ border = "single" })
        --   end,
        -- },
    profile = {
      enable = true,
    },
    },
}

