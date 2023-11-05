return {
  {
    -- "folke/tokyonight.nvim",
    -- "AlphaTechnolog/pywal.nvim",
    -- "rockerBOO/boo-colorscheme-nvim",
    "jesseleite/nvim-noirbuddy",
    -- "tiagovla/tokyodark.nvim",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    dependencies = {
      {
        "rktjmp/lush.nvim",
      },
      { "tjdevries/colorbuddy.nvim", branch = "dev" }
    },
    opts = {
      -- transparent_background = false,
      -- gamma = 0.85,
      -- styles = {
      --   comments = { italic = false },
      --   keywords = { italic = false },
      --   identifiers = { italic = false },
      --   functions = { italic = false },
      --   variables = { italic = false }
      -- }
      colors = {
        primary = '#E4579B',
        secondary = '#93518B'
      }
    },
    config = function(_, opts)
      require('noirbuddy').setup(opts);
      -- require('noirbuddy').setup {
      --   colors = {
      --     primary = '#6EE2FF',
      --     secondary = '#267FB5',
      --   },
      -- }
    end,
  },
}
