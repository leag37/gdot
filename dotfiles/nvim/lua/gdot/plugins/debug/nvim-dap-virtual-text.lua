return {
  "theHamsta/nvim-dap-virtual-text",
  event = "VeryLazy",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    local dap_virtual_text = require("nvim-dap-virtual-text")
    dap_virtual_text.setup()
  end,
}
