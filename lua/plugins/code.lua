return {

  -- Automatic bracket pairs

  -- auto pairs
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
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
        javascript = { "string", "template_string" },
        -- java = false,
      }
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "hrsh7th/cmp-nvim-lsp",
      },
      {
        "hrsh7th/cmp-buffer",
      },
      {
        "hrsh7th/cmp-path",
      },
      {
        "hrsh7th/cmp-cmdline",
      },
      {
        "saadparwaiz1/cmp_luasnip",
      },
      {
        "L3MON4D3/LuaSnip",
        event = "InsertEnter",
        dependencies = {
          "rafamadriz/friendly-snippets",
        },
      },
      {
        "hrsh7th/cmp-nvim-lua",
      },
    },
    init = function ()
      vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
    end,
    event = "InsertEnter",
    config = function ()
      local cmp = require("cmp")
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local luasnip = require("luasnip")
      require("luasnip/loaders/from_vscode").lazy_load()

      local check_backspace = function()
        local col = vim.fn.col "." - 1
        return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
      end

      local kind_icons = {
        Array = ' ',
        Boolean = ' ',
        Class = ' ',
        Color = ' ',
        Constant = ' ',
        Constructor = ' ',
        Copilot = ' ',
        Enum = ' ',
        EnumMember = ' ',
        Event = ' ',
        Field = ' ',
        File = ' ',
        Folder = ' ',
        Function = ' ',
        Interface = ' ',
        Key = ' ',
        Keyword = ' ',
        Method = ' ',
        Module = ' ',
        Namespace = ' ',
        Null = ' ',
        Number = ' ',
        Object = ' ',
        Operator = ' ',
        Package = ' ',
        Property = ' ',
        Reference = ' ',
        Snippet = ' ',
        String = ' ',
        Struct = ' ',
        Text = ' ',
        TypeParameter = ' ',
        Unit = ' ',
        Value = ' ',
        Variable = ' ',
      }

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
          ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-e>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          },
          -- Accept currently selected item. If none selected, `select` first item.
          -- Set `select` to `false` to only confirm explicitly selected items.
          ["<CR>"] = cmp.mapping.confirm { select = true },
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expandable() then
              luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif check_backspace() then
              fallback()
            else
              fallback()
            end
          end, {
            "i",
            "s",
          }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, {
            "i",
            "s",
          }),
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            vim_item.kind = kind_icons[vim_item.kind]
            vim_item.menu = ({
              nvim_lsp = "",
              nvim_lua = "",
              luasnip = "",
              buffer = "",
              path = "",
              emoji = "",
            })[entry.source.name]
            -- return require("tailwindcss-colorizer-cmp").formatter
            return vim_item
          end,
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        experimental = {
          ghost_text = true,
        },
        enabled = function()
            -- Disable nvim-cmp in a telescope prompt
            local buftype = vim.api.nvim_buf_get_option(0, 'buftype')
            if buftype == 'prompt' then
                return false
            end
            -- Disable completion in comments
            local context = require('cmp.config.context')
            -- Keep command mode completion enabled when cursor is in a comment
            if vim.api.nvim_get_mode().mode == 'c' then
                return true
            else
                return not context.in_treesitter_capture('comment') and not context.in_syntax_group('Comment')
            end
        end,
      }

      -- cmp-cmdline setup
      cmp.setup.cmdline('/', {
          mapping = cmp.mapping.preset.cmdline(),
          sources = { { name = 'buffer' } },
      })

      cmp.setup.cmdline(':', {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({ { name = 'path' } }, {
              { name = 'cmdline', option = { ignore_cmds = { 'Man', '!' } } },
          }),
      })

      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done {})
    end,
  },

  -- Commenting 

  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    dependencies = {
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        event = "VeryLazy",
      },
    },
  },
  -- Highlight same string

  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    init = function ()
      vim.g.Illuminate_ftblacklist = {'alpha', 'NvimTree'}
      vim.api.nvim_set_keymap('n', '<a-n>', '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', {noremap=true})
      vim.api.nvim_set_keymap('n', '<a-p>', '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', {noremap=true})
    end
  },

  -- Git integration

  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    -- opts = {
    --   signs = {
    --     add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    --     change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    --     delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    --     topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    --     changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    --   },
    --   signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    --   watch_gitdir = {
    --     interval = 1000,
    --     follow_files = true,
    --   },
    --   attach_to_untracked = true,
    --   current_line_blame_opts = {
    --     virt_text = true,
    --     virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    --     delay = 1000,
    --   },
    --   sign_priority = 6,
    --   update_debounce = 100,
    --   status_formatter = nil, -- Use default
    --   preview_config = {
    --     -- Options passed to nvim_open_win
    --     border = "single",
    --     style = "minimal",
    --     relative = "cursor",
    --     row = 0,
    --     col = 1,
    --   },
    -- }
  },


  -- Competitive programming tests

  {
    "xeluxee/competitest.nvim",
    commit = "c3cb0e2b0916a879c4d3dcb5737e6c046dd0afc5",
    ft = "cpp",
    dependencies = {
      {
        "MunifTanjim/nui.nvim"
      },
    },
    opts = {
      local_config_file_name = ".competitest.lua",

      floating_border = "solid",
      floating_border_highlight = "FloatBorder",
      picker_ui = {
        width = 0.2,
        height = 0.3,
        mappings = {
          focus_next = { "j", "<down>", "<Tab>" },
          focus_prev = { "k", "<up>", "<S-Tab>" },
          close = { "<esc>", "<C-c>", "q", "Q" },
          submit = { "<cr>" },
        },
      },
      editor_ui = {
        popup_width = 0.4,
        popup_height = 0.6,
        show_nu = true,
        show_rnu = false,
        normal_mode_mappings = {
          switch_window = { "<C-h>", "<C-l>", "<C-i>" },
          save_and_close = "<C-s>",
          cancel = { "q", "Q" },
        },
        insert_mode_mappings = {
          switch_window = { "<C-h>", "<C-l>", "<C-i>" },
          save_and_close = "<C-s>",
          cancel = "<C-q>",
        },
      },
      runner_ui = {
        interface = "split",
        selector_show_nu = false,
        selector_show_rnu = false,
        show_nu = true,
        show_rnu = false,
        mappings = {
          run_again = "R",
          run_all_again = "<C-r>",
          kill = "K",
          kill_all = "<C-k>",
          view_input = { "i", "I" },
          view_output = { "a", "A" },
          view_stdout = { "o", "O" },
          view_stderr = { "e", "E" },
          toggle_diff = { "d", "D" },
          close = { "q", "Q" },
        },
        viewer = {
          width = 0.5,
          height = 0.5,
          show_nu = true,
          show_rnu = false,
          close_mappings = { "q", "Q" },
        },
      },
      popup_ui = {
        total_width = 0.8,
        total_height = 0.8,
        layout = {
          { 4, "tc" },
          { 5, { { 1, "so" }, { 1, "si" } } },
          { 5, { { 1, "eo" }, { 1, "se" } } },
        },
      },
      split_ui = {
        position = "right",
        relative_to_editor = true,
        total_width = 0.3,
        vertical_layout = {
          { 1, "tc" },
          { 1, { { 1, "so" }, { 1, "eo" } } },
          { 1, { { 1, "si" }, { 1, "se" } } },
        },
        total_height = 0.4,
        horizontal_layout = {
          { 2, "tc" },
          { 3, { { 1, "so" }, { 1, "si" } } },
          { 3, { { 1, "eo" }, { 1, "se" } } },
        },
      },

      save_current_file = true,
      save_all_files = false,
      compile_directory = ".",
      compile_command = {
        c = { exec = "gcc", args = { "-Wall", "$(FNAME)", "-o", "$(FNOEXT)" } },
        cpp = { exec = "g++", args = { "-Wall", "$(FNAME)", "-o", "$(FNOEXT)" } },
        rust = { exec = "rustc", args = { "$(FNAME)" } },
        java = { exec = "javac", args = { "$(FNAME)" } },
      },
      running_directory = ".",
      run_command = {
        c = { exec = "./$(FNOEXT)" },
        cpp = { exec = "./$(FNOEXT)" },
        rust = { exec = "./$(FNOEXT)" },
        python = { exec = "python", args = { "$(FNAME)" } },
        java = { exec = "java", args = { "$(FNOEXT)" } },
      },
      multiple_testing = 0,
      maximum_time = 5000,
      output_compare_method = "squish",
      view_output_diff = true,

      testcases_directory = ".",
      testcases_use_single_file = true,
      testcases_auto_detect_storage = true,
      testcases_single_file_format = "$(FNOEXT).testcases",

      companion_port = 27121,
      receive_print_message = true,
    },
    keys = {
      {
        "<leader>ca",
        "<cmd>CompetiTest add_testcase<CR>",
        desc = "CompetiTest Add"
      },
      {
        "<leader>cr",
        "<cmd>CompetiTest run<CR>",
        desc = "CompetiTest Run"
      },
      {
        "<leader>ce",
        "<cmd>CompetiTest edit_testcase<CR>",
        desc = "CompetiTest Edit"
      },
      {
        "<leader>cd",
        "<cmd>CompetiTest delete_testcase<CR>",
        desc = "CompetiTest Receive Testcases"
      },
      {
        "<leader>ct",
        "<cmd>CompetiTest receive testcases<CR>",
        desc = "CompetiTest Receive Testcases"
      }
    }
  },

  -- LaTeX functionality

  {
    "lervag/vimtex",
    event = "VeryLazy",
    ft = {"tex", "cls"},
    init = function()
      vim.g.vimtex_view_general_viewer = 'zathura'
      vim.g.vimtex_compiler_latexmk_engines = {
        _ = '-xelatex'
      }
      vim.g.tex_comment_nospell = 1
      vim.g.vimtex_compiler_progname = 'nvr'
      vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
    end
  },
}
