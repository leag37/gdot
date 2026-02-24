return {
  "stevearc/overseer.nvim",
  ---@module 'overseer'
  ---@type overseer.SetupOpts
  opts = {},
  config = function()
    local overseer = require("overseer")
    overseer.setup({
      dap = false, -- disable dap to support lazy loading
    })

    local keymap = vim.keymap
    keymap.set("n", "<leader>ao", "<cmd>OverseerRun<CR>", { desc = "Run a task via overseer" })
    keymap.set("n", "<leader>at", "<cmd>OverseerToggle<CR>", { desc = "Toggle Overseer window" })
  end,
}
