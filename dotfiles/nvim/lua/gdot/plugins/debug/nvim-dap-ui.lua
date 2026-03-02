return {
  "rcarriga/nvim-dap-ui",
  event = "VeryLazy",
  dependencies = {
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
    "nvim-neotest/nvim-nio",
    "Civitasv/cmake-tools.nvim",
  },
  config = function()
    local mason_dap = require("mason-nvim-dap")
    local dap = require("dap")
    local ui = require("dapui")
    local cmake = require("cmake-tools")

    ui.setup()

    dap.listeners.after.event_initialized["dapui_config"] = function()
      ui.open()
    end

    dap.listeners.after.event_terminated["dapui_config"] = function()
      ui.close()
    end

    -- CMake setup vs conventional dap setup
    local keymap = vim.keymap
    keymap.set("n", "<F5>", function()
      if dap.session() == nil then
        vim.cmd("CMakeDebug")
      else
        dap.continue()
      end
    end, { desc = "Start a debugging session" })
    if cmake.is_cmake_project then
      keymap.set("n", "<C-F5>", "<cmd>CMakeRun<CR>", { desc = "Start a debugging session" })
      -- keymap.set("n", "<F5>", "<cmd>CMakeDebug<CR>", { desc = "Start the application" })
    else
    end

    -- Keymap conditional on attaching debugger
    local opts = { silent = true }
    -- opts.cond = function()
    --   return dap.session() ~= nil
    -- end

    opts.desc = "Stop the debugger"
    keymap.set("n", "<S-F5>", "<cmd>DapTerminate<CR>", opts)

    opts.desc = "Step out of the current scope"
    keymap.set("n", "<S-F11>", "<cmd>DapStepOut<CR>", opts)

    opts.desc = "Step over the current scope"
    keymap.set("n", "<F10>", "<cmd>DapStepOver<CR>", opts)

    opts.desc = "Step into the current scope"
    keymap.set("n", "<F11>", "<cmd>DapStepInto<CR>", opts)
  end,
}
