return {
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
