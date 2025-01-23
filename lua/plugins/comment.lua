return {
  -- Commenting
  {
    "numToStr/Comment.nvim",
    event = "BufReadPost",
    dependencies = {
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        event = "VeryLazy",
      },
    },
  },

}
