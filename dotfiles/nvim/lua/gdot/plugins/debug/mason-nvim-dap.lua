return {
  "jay-babu/mason-nvim-dap.nvim",
  event = "VeryLazy",
  dependencies = {
    "williamboman/mason.nvim",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    local mason_dap = require("mason-nvim-dap")
    mason_dap.setup({
      ensure_installed = {},
      handlers = {},
    })

    -- Configurations per language
    local dap = require("dap")

    -- C/C++/Rust
    dap.adapters.codelldb = {
      type = "executable",
      command = "codelldb",
    }

    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }
    
    -- Keymaps
    local keymap = vim.keymap
    keymap.set("n", "<F9>", "<cmd>DapToggleBreakpoint<CR>", { desc = "Toggle a breakpoint" })
  end,
}
