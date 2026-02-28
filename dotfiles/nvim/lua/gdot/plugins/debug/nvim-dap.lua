return {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  config = function()
    local overseer = require("overseer")
    overseer.enable_dap()

    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = '', linehl = '', numhl = '' })
  end,
}
