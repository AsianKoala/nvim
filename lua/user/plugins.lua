local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

  use({
    "catppuccin/nvim",
    as = "catppuccin"
  })

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use 'nvim-telescope/telescope-media-files.nvim'

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    commit = "518e27589c0463af15463c9d675c65e464efc2fe",
  }

  -- Commenting
  use { "numToStr/Comment.nvim", commit = "2c26a00f32b190390b664e56e32fd5347613b9e2" }
  use { "JoosepAlviste/nvim-ts-context-commentstring", commit = "88343753dbe81c227a1c1fd2c8d764afb8d36269" }

  -- Auto pairs
  use { "windwp/nvim-autopairs", commit = "fa6876f832ea1b71801c4e481d8feca9a36215ec" } -- Autopairs, integrates with both cmp and treesitter


  use { "kyazdani42/nvim-tree.lua", commit = "bdb6d4a25410da35bbf7ce0dbdaa8d60432bc243" }
  use { "kyazdani42/nvim-web-devicons", commit = "8d2c5337f0a2d0a17de8e751876eeb192b32310e" }



  use { "akinsho/bufferline.nvim", commit = "c78b3ecf9539a719828bca82fc7ddb9b3ba0c353" }




  use { "akinsho/toggleterm.nvim", commit = "aaeed9e02167c5e8f00f25156895a6fd95403af8" }





  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
