return {
  {
    "folke/flash.nvim",
    event = "BufReadPost",
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    },
  },
}
