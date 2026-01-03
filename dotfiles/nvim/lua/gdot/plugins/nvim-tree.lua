return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvim_tree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrePlugin = 1

    nvim_tree.setup({
      view = {
        width = 35,
        relativenumber = true,
      },
      -- Change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "",
              arrow_open = "",
            },
          },
        },
      },

      -- Disable window_picker for explorer to work well with window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = {},
      },
      git = {
        ignore = false,
      },
    })

    -- Keymaps
    local keymap = vim.keymap
    keymap.set("n", "<leader>ee", "<cmd>NvimTreeOpen<CR>", { desc = "Open the file explorer" })
    keymap.set("n", "<leader>eq", "<cmd>NvimTreeClose<CR>", { desc = "Close the file explorer" })
    keymap.set("n", "<leader>et", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle the file explorer" })
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFile<CR>", { desc = "Go to the current file in the file explorer" })
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse the file explorer" })
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh the file explorer" })
  end
}
