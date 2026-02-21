return {
  "kylechui/nvim-surround",
  event = { "BufReadPre", "BufNewFile", "VeryLazy" },
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  config = function()
    require("nvim-surround").setup({})
  end,
}
