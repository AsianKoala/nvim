return {
  {
    -- "folke/tokyonight.nvim",
    -- "AlphaTechnolog/pywal.nvim",
    -- "rockerBOO/boo-colorscheme-nvim",
    -- "mcchrish/zenbones.nvim",
    "tiagovla/tokyodark.nvim",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    dependencies = {
      -- {
      --   "rktjmp/lush.nvim"
      -- }
    },
    config = function ()
      vim.g.tokyodark_transparent_background = false
      vim.g.tokyodark_enable_italic_comment = true
      vim.g.tokyodark_enable_italic = false
      vim.g.tokyodark_color_gamma = "0.9"
      vim.cmd([[colorscheme tokyodark]])
    end
  },
}
