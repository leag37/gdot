return {
  "Civitasv/cmake-tools.nvim",
  event = "VeryLazy",
  dependencies = {
    "jay-babu/mason-nvim-dap.nvim",
  },
  opts = {
    cmake_executor = {
      name = "overseer",
      opts = {}
    },
  },
}
