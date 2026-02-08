return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  init = function()
    -- Disable entire built-in ftplugin mappings to avoid conflicts
    -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins
    vim.g.no_plugin_maps = true

    -- Or, disable per filetype (add as you like)
    -- vim.g.no_python_maps = true
    -- vim.g.no_rust_maps = true
  end,
  config = function()
    local textobjects = require("nvim-treesitter-textobjects")

    textobjects.setup{
      select = {
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        -- You can choose the select mode (default is charwise 'v')
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function,inner'
        -- * method: eg 'v' or 'o'
        -- and should return the mode ('v', 'V', or '<c-v>') or a table
        -- mapping query_strings to modes.
        selection_modes = {
          ['@parameter.outer'] = 'v', -- charwise
          ['@function.outer'] = 'V', -- linewise
          -- ['@class.outer'] = '<c-v>', -- blockwise
        },
        -- If you set this to `true` (default is `false`) then any textobject is
        -- extended to inclode preceding or succeeding whitespace. Succeeding
        -- whitespace has priority in order to act similarly to eg the built-in
        -- `ap`.
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * selection_mode: eg 'v'
        -- and should return true of false
        include_surrounding_whitespace = false,
      },
    }

    -- keymaps
    -- You can use the capture groups defined in `textobjects.scm`
    local keymap = vim.keymap

    -- Select
    local select = require("nvim-treesitter-textobjects.select")
    keymap.set({ "x", "o" }, "am", function()
      select.select_textobject("@function.outer", "textobjects")
    end)
    keymap.set({ "x", "o" }, "im", function()
      select.select_textobject("@function.inner", "textobjects")
    end)
    keymap.set({ "x", "o" }, "ac", function()
      select.select_textobject("@class.outer", "textobjects")
    end)
    keymap.set({ "x", "o" }, "ic", function()
      select.select_textobject("@class.inner", "textobjects")
    end)
    keymap.set({ "x", "o" }, "a", function()
      select.select_textobject("@local.scope", "textobjects")
    end)

    -- Swap
    local swap = require("nvim-treesitter-textobjects.swap")
    keymap.set("n", "<leader>a", function()
      swap.swap_next "@parameter.inner"
    end)
    keymap.set("n", "<leader>A", function()
      swap.swap_next "@parameter.outer"
    end)
  end,
}
