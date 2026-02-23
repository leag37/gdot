return {
  "stevearc/overseer.nvim",
  ---@module 'overseer'
  ---@type overseer.SetupOpts
  opts = {},
  config = function()
    local overseer = require("overseer")
    overseer.setup()
  end,
}
