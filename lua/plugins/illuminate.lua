return {
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    init = function()
      vim.g.Illuminate_ftblacklist = { "alpha", "NvimTree" }
    end,
  },
}
