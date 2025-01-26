return {
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},

    config = function()
      require("oil").setup {
        view_options = {
          show_hidden = true,
        },
      }
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
  },
}
