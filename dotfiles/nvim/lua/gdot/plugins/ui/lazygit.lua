return {
  "kdheepak/lazygit.nvim",
  lazy = false, -- telescope integration doesn't support lazy loading
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  -- Keybindings
  keys = {
    { "<leader>lg", "<cmd>LazyGit<CR>", desc = "Open LazyGit" },
  },
  config = function()
    require("telescope").load_extension("lazygit")
  end,
}
