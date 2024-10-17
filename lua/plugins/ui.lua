return {

  -- startup screen

  {
    "goolord/alpha-nvim",
    event = "VimEnter",

    config = function ()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.header.val = {
        -- [[ ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        -- [[ ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⠋⠉⣉⣉⠙⠿⠋⣠⢴⣊⣙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        -- [[ ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠋⠁⠀⢀⠔⡩⠔⠒⠛⠧⣾⠊⢁⣀⣀⣀⡙⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        -- [[ ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠛⠁⠀⠀⠀⠀⠀⡡⠊⠀⠀⣀⣠⣤⣌⣾⣿⠏⠀⡈⢿⡜⣿⣿⣿⣿⣿⣿⣿⣿]],
        -- [[ ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠡⣤⣶⠏⢁⠈⢻⡏⠙⠛⠀⣀⣁⣤⢢⣿⣿⣿⣿⣿⣿⣿⣿]],
        -- [[ ⣿⣿⣿⣿⣿⣿⣿⣿⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⣄⡀⠣⣌⡙⠀⣘⡁⠜⠈⠑⢮⡭⠴⠚⠉⠀⣿⣿⣿⣿⣿⣿⣿⣿]],
        -- [[ ⣿⣿⣿⣿⣿⣿⣿⠁⠀⢀⠔⠁⣀⣤⣤⣤⣤⣤⣄⣀⠀⠉⠉⠉⠉⠉⠁⠀⠀⠀⠀⠀⠁⠀⢀⣠⢠⣿⣿⣿⣿⣿⣿⣿⣿]],
        -- [[ ⣿⣿⣿⣿⣿⣿⣿⡀⠀⢸⠀⢼⣿⣿⣶⣭⣭⣭⣟⣛⣛⡿⠷⠶⠶⢶⣶⣤⣤⣤⣶⣶⣾⡿⠿⣫⣾⣿⣿⣿⣿⣿⣿⣿⣿]],
        -- [[ ⣿⣿⣿⣿⣿⣿⣿⠇⠀⠀⠀⠈⠉⠉⠉⠉⠉⠙⠛⠛⠻⠿⠿⠿⠷⣶⣶⣶⣶⣶⣶⣶⣶⡾⢗⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        -- [[ ⣿⣿⣿⣿⣿⣿⣿⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣿⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        -- [[ ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣤⣄⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⢀⣀⣤⣝⡻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        -- [[ ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
    [[⣇⣿⠘⣿⣿⣿⡿⡿⣟⣟⢟⢟⢝⠵⡝⣿⡿⢂⣼⣿⣷⣌⠩⡫⡻⣝⠹⢿⣿⣷]],
    [[⡆⣿⣆⠱⣝⡵⣝⢅⠙⣿⢕⢕⢕⢕⢝⣥⢒⠅⣿⣿⣿⡿⣳⣌⠪⡪⣡⢑⢝⣇]],
    [[⡆⣿⣿⣦⠹⣳⣳⣕⢅⠈⢗⢕⢕⢕⢕⢕⢈⢆⠟⠋⠉⠁⠉⠉⠁⠈⠼⢐⢕⢽]],
    [[⡗⢰⣶⣶⣦⣝⢝⢕⢕⠅⡆⢕⢕⢕⢕⢕⣴⠏⣠⡶⠛⡉⡉⡛⢶⣦⡀⠐⣕⢕]],
    [[⡝⡄⢻⢟⣿⣿⣷⣕⣕⣅⣿⣔⣕⣵⣵⣿⣿⢠⣿⢠⣮⡈⣌⠨⠅⠹⣷⡀⢱⢕]],
    [[⡝⡵⠟⠈⢀⣀⣀⡀⠉⢿⣿⣿⣿⣿⣿⣿⣿⣼⣿⢈⡋⠴⢿⡟⣡⡇⣿⡇⡀⢕]],
    [[⡝⠁⣠⣾⠟⡉⡉⡉⠻⣦⣻⣿⣿⣿⣿⣿⣿⣿⣿⣧⠸⣿⣦⣥⣿⡇⡿⣰⢗⢄]],
    [[⠁⢰⣿⡏⣴⣌⠈⣌⠡⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣬⣉⣉⣁⣄⢖⢕⢕⢕]],
    [[⡀⢻⣿⡇⢙⠁⠴⢿⡟⣡⡆⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣵⣵⣿]],
    [[⡻⣄⣻⣿⣌⠘⢿⣷⣥⣿⠇⣿⣿⣿⣿⣿⣿⠛⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
    [[⣷⢄⠻⣿⣟⠿⠦⠍⠉⣡⣾⣿⣿⣿⣿⣿⣿⢸⣿⣦⠙⣿⣿⣿⣿⣿⣿⣿⣿⠟]],
    [[⡕⡑⣑⣈⣻⢗⢟⢞⢝⣻⣿⣿⣿⣿⣿⣿⣿⠸⣿⠿⠃⣿⣿⣿⣿⣿⣿⡿⠁⣠]],
    [[⡝⡵⡈⢟⢕⢕⢕⢕⣵⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣿⣿⣿⣿⣿⠿⠋⣀⣈⠙]],
    [[⡝⡵⡕⡀⠑⠳⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⢉⡠⡲⡫⡪⡪⡣]],
      }
      dashboard.section.buttons.val = {
        dashboard.button("f", ">find file", ":Telescope find_files <CR>"),
        dashboard.button("p", ">find project", ":lua require('telescope').extensions.projects.projects()<CR>"),
        dashboard.button("s", ">scratchpad", ":e ~/documents/scratchpad <CR>"),
        dashboard.button("c", ">config", ":e ~/dotfiles/nvim/init.lua <CR>"),
        dashboard.button("t", ">live grep", ":Telescope live_grep<CR>"),
        dashboard.button("q", ">quit", ":qa<CR>"),
      }
      dashboard.section.buttons.opts = {
        spacing = 0,
        position = "center"
      }
      local function footer()
        return "こんばんは\n  ニール"
      end

      dashboard.section.footer.val = footer()

      dashboard.section.footer.opts.hl = "Type"
      dashboard.section.header.opts.hl = "Include"
      dashboard.section.buttons.opts.hl = "Keyword"

      dashboard.opts.opts.noautocmd = true
      alpha.setup(dashboard.opts)
    end
  },

  -- bufferline

  {
    "akinsho/bufferline.nvim",
    event = { "UIEnter" },
    dependencies = {
      {
        "famiu/bufdelete.nvim",
      },
    },
    opts = {
      options = {
        close_command = "Bdelete! %d",       -- can be a string | function, see "Mouse actions"
        right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
        offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
        separator_style = "thin",            -- | "thick" | "thin" | { 'any', 'any' },
      },
      -- highlights = {
      --   fill = {
      --     fg = { attribute = "fg", highlight = "#ff0000" },
      --     bg = { attribute = "bg", highlight = "TabLine" },
      --   },
      --   background = {
      --     fg = { attribute = "fg", highlight = "TabLine" },
      --     bg = { attribute = "bg", highlight = "TabLine" },
      --   },
      --   buffer_visible = {
      --     fg = { attribute = "fg", highlight = "TabLine" },
      --     bg = { attribute = "bg", highlight = "TabLine" },
      --   },
      --   close_button = {
      --     fg = { attribute = "fg", highlight = "TabLine" },
      --     bg = { attribute = "bg", highlight = "TabLine" },
      --   },
      --   close_button_visible = {
      --     fg = { attribute = "fg", highlight = "TabLine" },
      --     bg = { attribute = "bg", highlight = "TabLine" },
      --   },
      --   tab_selected = {
      --     fg = { attribute = "fg", highlight = "Normal" },
      --     bg = { attribute = "bg", highlight = "Normal" },
      --   },
      --   tab = {
      --     fg = { attribute = "fg", highlight = "TabLine" },
      --     bg = { attribute = "bg", highlight = "TabLine" },
      --   },
      --   tab_close = {
      --     -- fg = {attribute='fg',highlight='LspDiagnosticsDefaultError'},
      --     fg = { attribute = "fg", highlight = "TabLineSel" },
      --     bg = { attribute = "bg", highlight = "Normal" },
      --   },
      --   duplicate_selected = {
      --     fg = { attribute = "fg", highlight = "TabLineSel" },
      --     bg = { attribute = "bg", highlight = "TabLineSel" },
      --     italic = true,
      --   },
      --   duplicate_visible = {
      --     fg = { attribute = "fg", highlight = "TabLine" },
      --     bg = { attribute = "bg", highlight = "TabLine" },
      --     italic = true,
      --   },
      --   duplicate = {
      --     fg = { attribute = "fg", highlight = "TabLine" },
      --     bg = { attribute = "bg", highlight = "TabLine" },
      --     italic = true,
      --   },
      --   modified = {
      --     fg = { attribute = "fg", highlight = "TabLine" },
      --     bg = { attribute = "bg", highlight = "TabLine" },
      --   },
      --   modified_selected = {
      --     fg = { attribute = "fg", highlight = "Normal" },
      --     bg = { attribute = "bg", highlight = "Normal" },
      --   },
      --   modified_visible = {
      --     fg = { attribute = "fg", highlight = "TabLine" },
      --     bg = { attribute = "bg", highlight = "TabLine" },
      --   },
      --   separator = {
      --     fg = { attribute = "bg", highlight = "TabLine" },
      --     bg = { attribute = "bg", highlight = "TabLine" },
      --   },
      --   separator_selected = {
      --     fg = { attribute = "bg", highlight = "Normal" },
      --     bg = { attribute = "bg", highlight = "Normal" },
      --   },
      --   indicator_selected = {
      --     fg = { attribute = "fg", highlight = "LspDiagnosticsDefaultHint" },
      --     bg = { attribute = "bg", highlight = "Normal" },
      --   },
      -- },
    }
  },

  -- statusline

  {
    "nvim-lualine/lualine.nvim",
    event = { "VimEnter", "InsertEnter", "BufReadPre", "BufAdd", "BufNew", "BufReadPost" },
    opts = function ()
      local hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end

      local diagnostics = {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { "error", "warn" },
        symbols = { error = " ", warn = " " },
        colored = false,
        always_visible = true,
      }

      local diff = {
        "diff",
        colored = false,
        symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
        cond = hide_in_width,
      }

      local filetype = {
        "filetype",
        icons_enabled = false,
      }

      local location = {
        "location",
        padding = 0,
      }

      local spaces = function()
        return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
      end

      return {
        options = {
          globalstatus = true,
          icons_enabled = true,
          theme = "auto",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = { "alpha", "dashboard" },
          always_divide_middle = true,
        },

        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = { diagnostics },
          lualine_x = { diff, spaces, "encoding", filetype },
          lualine_y = { location },
          lualine_z = { "progress" },
        },
      }

    end
  },

  -- nvim-tree

  {
    "kyazdani42/nvim-tree.lua",
    event = "VeryLazy",
    opts = function ()
      local api = require("nvim-tree.api")

      return {
        update_focused_file = {
          enable = true,
          update_cwd = true,
        },
        git = {
          ignore = false -- show files that are in .gitignore
        },
        renderer = {
          icons = {
            glyphs = {
              default = "",
              symlink = "",
              folder = {
                arrow_open = "",
                arrow_closed = "",
                default = "",
                open = "",
                empty = "",
                empty_open = "",
                symlink = "",
                symlink_open = "",
              },
              git = {
                unstaged = "",
                staged = "S",
                unmerged = "",
                renamed = "➜",
                untracked = "U",
                deleted = "",
                ignored = "◌",
              },
            },
          },
        },
        diagnostics = {
          enable = true,
          show_on_dirs = true,
          icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
          },
        },
        view = {
          width = 30,
          side = "left",
          -- mappings = {
          --   list = {
          --     { key = { "l", "<CR>", "o" }, cb = api.node.open.edit() },
          --     { key = "v",                  cb = api.node.open.vertical() },
          --   },
          -- },
        },
        actions = {
          open_file = {
            resize_window = false
          }
        }
      }

    end
  },

  -- Terminal inside nvim

  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    opts = {
      size = 10,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "horizontal",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
      },
    },

    config = function (_, opts)
      require("toggleterm").setup(opts)

      function _G.set_terminal_keymaps()
        local Opts = { noremap = true }
        -- vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], Opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], Opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], Opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], Opts)
      end

      vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"
      
    end
  },

  -- Icons for nvim-tree

  {
    "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    opts = {
      override = {
        zsh = {
          icon = "",
          color = "#428850",
          cterm_color = "65",
          name = "Zsh",
        },
      },
      color_icons = true,
      default = true,
    }
  },

  -- keybindings visual

  {
    "folke/which-key.nvim",
    event = "VeryLazy",

    config = function ()
      require("which-key").setup {}
    end
  },


  -- ui components

  {
    "MunifTanjim/nui.nvim",
    event = "VeryLazy"
  },

  {
    'stevearc/dressing.nvim',
    event = "VeryLazy",
  },
}
