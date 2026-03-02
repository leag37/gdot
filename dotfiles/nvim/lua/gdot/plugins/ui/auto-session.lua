return {
  "rmagatti/auto-session",
  dependencies = {
    "stevearc/overseer.nvim",
    "Weissle/persistent-breakpoints.nvim",
  },
  config = function()
    local auto_session = require("auto-session")

    auto_session.setup({
      -- auto_restore_enabled = false,
      auto_restore_last_session = true,
      auto_session_suppress_dirs = { "~/", "~/Dev", "~/Downloads", "~/Desktop" },

      -- overseer integration
      pre_save_cmds = {
        function()
          local tasks = require("overseer.task_list").list_tasks()
          local cmds = {}
          for _, task in ipairs(tasks) do
            local json = vim.json.encode(task:serialize())

            -- For some reason, vim.json.encode encodes / as \/.
            json = string.gsub(json, "\\/", "/")

            -- Escape single quotes so we can put this inside single quotes
            json = string.gsub(json, "'", "\\'")

            table.insert(cmds, string.format("lua require('overseer').new_task(vim.json.decode('%s')):start()", json))
          end
          return cmds
        end,
        function()
          local persistent_breakpoints = require("persistent-breakpoints.api")
          persistent_breakpoints.store_breakpoints()
        end,
      },
      post_restore_cmds = {
      },
    })

    local keymap = vim.keymap
    keymap.set("n", "<leader>sr", "<cmd>AutoSession restore<CR>", { desc = "Restore session for cwd" })
    keymap.set("n", "<leader>ss", "<cmd>AutoSession save<CR>", { desc = "Save session for cwd" })
  end
}
