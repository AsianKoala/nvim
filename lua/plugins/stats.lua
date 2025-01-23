return {
  -- Measure startup time

  {
    "dstein64/vim-startuptime",
    event = "VeryLazy",
    -- lazy-load on a command
    cmd = "StartupTime",
    -- init is called during startup. Configuration for vim plugins typically should be set in an init function
    init = function()
      vim.g.startuptime_tries = 10
    end,
  },

  {
    "3rd/time-tracker.nvim",
    dependencies = {
      "3rd/sqlite.nvim",
    },
    event = "VeryLazy",
    opts = {
      data_file = vim.fn.stdpath "data" .. "/time-tracker.db",
    },
  },
}
