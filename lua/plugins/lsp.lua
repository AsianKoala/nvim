return {
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    dependencies = {
      {
        "hrsh7th/cmp-nvim-lsp",
      },
    },

    init = function ()
      local function lsp_keymaps(bufnr)
        local opts = { noremap = true, silent = true }
        local keymap = vim.api.nvim_buf_set_keymap
        keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
        keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
        keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
        keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
        keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
        keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
        keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
        keymap(bufnr, "n", "<leader>lI", "<cmd>Mason<cr>", opts)
        keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
        keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
        keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
        keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
        keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
        keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
      end

      local lspconfig = require "lspconfig"
      local on_attach = function(client, bufnr)
        if client.name == "sumneko_lua" then
          client.server_capabilities.documentFormattingProvider = false
        end

        if client.name == "pyright" then
          client.server_capabilities.documentFormattingProvider = false
        end


        lsp_keymaps(bufnr)
        require("illuminate").on_attach(client)
      end

      for _, server in pairs(require("langs").servers) do
        Opts = {
          on_attach = on_attach,
        }

        server = vim.split(server, "@")[1]

        local require_ok, conf_opts = pcall(require, "langs." .. server)
        if require_ok then
          Opts = vim.tbl_deep_extend("force", conf_opts, Opts)
        end

        lspconfig[server].setup(Opts)
      end
    end
  },

  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    event = "BufReadPre",
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        lazy = true,
      },
    },
    opts = { ui = { icons = { package_installed = '', package_pending = '', package_uninstalled = '' } } },
    -- todo
    config = function (_, opts)
      require("mason").setup(opts)
      require("mason-lspconfig").setup {
        ensure_installed = require("langs").servers,
        automatic_installation = true,
      }
    end
  },

  {
    'jay-babu/mason-null-ls.nvim',
    event = "VeryLazy",
    opts = {
      ensure_installed = { "stylua", "cpplint", "clang_format" }
    }
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    dependencies = {
      {
        "nvim-lua/plenary.nvim",
        lazy = true,
      },
    },
    opts = function()
      local nls = require('null-ls')
      return {
        sources = {
            nls.builtins.formatting.stylua,
            -- nls.builtins.formatting.markdownlint,
            -- nls.builtins.formatting.clang_format,
            -- nls.builtins.diagnostics.markdownlint,
            -- nls.builtins.diagnostics.cpplint,
        },
      }
    end,
  },

  -- fidget.nvim

  {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
  },

}
