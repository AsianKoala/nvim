return {
  -- Detect projects


  {
    "folke/which-key.nvim",
    event = "BufReadPre", -- used to be VeryLazy
    opts = {},
  },

  -- ui components
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },

  -- Add visual indent guide to lines
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  },
}
