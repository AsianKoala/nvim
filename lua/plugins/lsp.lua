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


vim.g.rustaceanvim = {
  -- LSP configuration
  server = {
    on_attach = function(client, bufnr)
      lsp_keymaps(bufnr)
    end,
  },
}

return {

  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    lazy = false,
  },

  {
    "neovim/nvim-lspconfig",
    lazy = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "jay-babu/mason-null-ls.nvim",
        "jose-elias-alvarez/null-ls.nvim",
        "nvim-lua/plenary.nvim",
      },
    },

    init = function()
      local lspconfig = require "lspconfig"
      local on_attach = function(client, bufnr)
        lsp_keymaps(bufnr)
        require("illuminate").on_attach(client)
      end

      -- mason
      local cmp = require "cmp"
      local cmp_lsp = require "cmp_nvim_lsp"

      local capabilities =
        vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

      require("mason").setup()
      require("mason-lspconfig").setup {
        ensure_installed = {
          "lua_ls",
          "pyright",
          "bashls",
          "jsonls",
          "clangd",
        },

        handlers = {
          ["clangd"] = function()
            lspconfig["clangd"].setup {
              on_attach = on_attach,
              capabilities = capabilities,
            }
          end,

          ["pyright"] = function()
            lspconfig["pyright"].setup {
              on_attach = on_attach,
              capabilities = capabilities,
            }
          end,

          ["bashls"] = function()
            lspconfig["bashls"].setup {
              on_attach = on_attach,
              capabilities = capabilities,
            }
          end,

          ["jsonls"] = function()
            lspconfig["jsonls"].setup {
              on_attach = on_attach,
              capabilities = capabilities,
            }
          end,


          ["lua_ls"] = function()
            lspconfig["lua_ls"].setup {
              on_attach = on_attach,
              capabilities = capabilities,
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                  workspace = {
                    library = {
                      [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                      [vim.fn.stdpath "config" .. "/lua"] = true,
                    },
                  },
                  telemetry = {
                    enable = false,
                  },
                },
              },
            }
          end,
        },
      }

      -- null-ls
      local nls = require "null-ls"
      nls.setup {
        sources = {
          nls.builtins.formatting.stylua,
        },
      }

      -- mason null ls
      require("mason-null-ls").setup {
        ensure_installed = { "stylua", "cpplint", "clang_format" },
        automatic_installation = true,
      }
    end,
  },
}
