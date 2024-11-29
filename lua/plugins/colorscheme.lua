return {
  {
    -- "folke/tokyonight.nvim",
    -- "AlphaTechnolog/pywal.nvim",
    -- "rockerBOO/boo-colorscheme-nvim",
    "jesseleite/nvim-noirbuddy",
    -- "tiagovla/tokyodark.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    dependencies = {
      {
        "rktjmp/lush.nvim",
      },
      { "tjdevries/colorbuddy.nvim", branch = "dev" },
    },
    opts = {
      colors = {
        primary = "#E4579B",
        secondary = "#93518B",
      },
    },
    config = function(_, opts)
      require("noirbuddy").setup(opts)
    end,
  },
}
