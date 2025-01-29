return {
  {
    -- "folke/tokyonight.nvim",
    -- "AlphaTechnolog/pywal.nvim",
    -- "rockerBOO/boo-colorscheme-nvim",
    "jesseleite/nvim-noirbuddy",
    -- "tiagovla/tokyodark.nvim",
    -- "slugbyte/lackluster.nvim",
    -- "wnkz/monoglow.nvim",
    -- "kdheepak/monochrome.nvim",
    lazy = false,
    priority = 1000,
    dependencies = {
      { "tjdevries/colorbuddy.nvim" },
    },
    opts = {
    colors = {
      primary = "#915691",
    }
    -- colors = {
    --   primary = "#E4579B",
    --   secondary = "#93518B",
    -- },
    },
    config = function(_, opts)
      require("noirbuddy").setup(opts)
    end,
  },
}
