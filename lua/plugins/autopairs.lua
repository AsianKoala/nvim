return {
  {
    "windwp/nvim-autopairs",
    event = "BufReadPost",
    dependencies = {
      {
        "hrsh7th/nvim-cmp",
        event = {
          "InsertEnter",
          "CmdlineEnter",
        },
      },
    },
    opts = {
      check_ts = true, -- treesitter integration
      disable_filetype = { "TelescopePrompt" },
      ts_config = {
        lua = { "string", "source" },
      },
    },
  },

}
