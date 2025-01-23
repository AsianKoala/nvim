return {
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},

    config = function()
      require("oil").setup({

      })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy"
  },
}
