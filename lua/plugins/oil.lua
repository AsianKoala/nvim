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
        keymaps = {
          ["yp"] = {
            function()
              require("oil.actions").yank_entry.callback()
            end,
            mode = "n",
            desc = "Yank filepath",
          },
        },
      }
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
  },
}
