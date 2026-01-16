return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths

    -- vsnip snippets engine
    "hrsh7th/cmp-vsnip", 
    "hrsh7th/vim-vsnip",

    -- vs-code-like pictograms
    "onsails/lspkind.nvim",

    -- command line
    "hrsh7th/cmp-cmdline",

    -- emoji
    "hrsh7th/cmp-emoji",
  },
  config = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = {
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body) -- vsnip setup
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4), 
        ["<C-f>"] = cmp.mapping.scroll_docs(4), 
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion
        ["<C-c>"] = cmp.mapping.abort(), -- close completion window
        ["<Tab>"] = cmp.mapping.confirm({ select = true }), 
      }),
      -- sources for autocompletion
      sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- lsp servers
        { name = "vsnip" }, -- snippets
        { name = "render-markdown" }, -- markdown plugin
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system path
      }),
      -- configure lspkind for vs-code like pictograms in completion menu
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },
    })
  end,
}
