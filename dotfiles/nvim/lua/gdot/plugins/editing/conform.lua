return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        c = { "clang-format" },
        cmake = { "cmakelang" },
        cpp = { "clang-format" },
        csharp = { "csharpier" },
        javascript = { "prettier" },
        json = { "prettier" },
        lua = { "stylua" },
        markdown = { "prettier" },
        python = { "isort", "black" },
        rust = { "rustfmt", lsp_format = "fallback" },
        yaml = { "prettier" },
      },
      format_after_save = {
        lsp_format = true,
        async = true,
        timeout_ms = 1000,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>af", function()
      conform.format({
        lsp_format = true,
        async = true,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
