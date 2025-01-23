return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
    },
    cmd = { "TSUpdateSync" },
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = {
          "asm",
          "bash",
          "bibtex",
          "cmake",
          "cpp",
          "c",
          "gitignore",
          "html",
          "json",
          "python",
          "sxhkdrc",
          "lua",
          "rust",
          "markdown",
          "markdown_inline",
          "latex",
        },
        highlight = { enable = true },
        indent = { enable = true },
        autotag = {
          enable = true,
        },
      }
    end,
  },

}
