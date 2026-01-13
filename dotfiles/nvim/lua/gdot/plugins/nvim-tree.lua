return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvim_tree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrePlugin = 1

    -- Setup nvim tree
    nvim_tree.setup({
      view = {
        width = {
          min = 30,
          max = -1,
        },
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

      -- Override on_attach for custom behavior
      on_attach = custom_on_attach,
    })

    -- Keymaps
    local keymap = vim.keymap
    keymap.set("n", "<leader>ee", "<cmd>NvimTreeOpen<CR>", { desc = "Open the file explorer" })
    keymap.set("n", "<leader>eq", "<cmd>NvimTreeClose<CR>", { desc = "Close the file explorer" })
    keymap.set("n", "<leader>et", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle the file explorer" })
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFile<CR>", { desc = "Go to the current file in the file explorer" })
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse the file explorer" })
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh the file explorer" })

    -- Recipes (sourced initially from nvim-tree github)
    -- Automatically open file upon creation
    local api = require("nvim-tree.api")
    api.events.subscribe(api.events.Event.FileCreated, function(file)
      vim.cmd("edit " .. vim.fn.fnameescape(file.fname))
    end)

    -- Find and focus directory (with Telescope)
    function find_directory_and_focus()
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")

      local function open_nvim_tree(prompt_bufnr, _)
        actions.select_default:replace(function()
          
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          if (selection ~= nil) then
            api.tree.open()
            api.tree.find_file(selection.cwd .. "/" .. selection.value)
          end
        end)
        return true
      end

      require("telescope.builtin").find_files({
        find_command = { "fdfind", "--type", "d", "--hidden", "--exclude", ".git/*" },
        attach_mappings = open_nvim_tree,
      })
    end

    keymap.set("n", "<leader>fd", find_directory_and_focus)

  end
}
