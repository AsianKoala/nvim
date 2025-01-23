-- Disable netrw for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " " -- set leader

require "options"
require "keymaps"
require "Lazy"
require "autocommands"
