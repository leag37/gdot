return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    {
      "antosha417/nvim-lsp-file-operations",
      config = true,
    },
    {
      "folke/neodev.nvim",
      opts = {},
    },
  },
  config = function()
    -- imports
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }

        -- set keybinds
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", { desc = "Show LSP references" })
        keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Show to declarations" })
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Show LSP definitions" })
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", { desc = "Show LSP implementations" })
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "Show LSP type definitions" })
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "See available code actions" })
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Smart rename" })
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufrn=0<CR>", { desc = "Show buffer diagnostics" })
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
        keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
        keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
        keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show documentation for what is under cursor" })
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP" })
      end,
    })

    -- Cache capabilities to enable autocompletion
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the gutter
    local info = vim.diagnostic.severity.INFO
    local hint = vim.diagnostic.severity.HINT
    local warn = vim.diagnostic.severity.WARN
    local error = vim.diagnostic.severity.ERROR
    vim.diagnostic.config({
      signs = {
        text = {
          [info] = "",
          [hint] = "",
          [warn] = "󰠠",
          [error] = "",
        },
        numhl = {
          [info] = "",
          [hint] = "",
          [warn] = "",
          [error] = "",
        },
      },
    })

    -- Setup all the LSPs
    vim.lsp.config("clangd", {})
   
    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    })
  end,
}
