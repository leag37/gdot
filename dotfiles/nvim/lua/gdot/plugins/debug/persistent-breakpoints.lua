return {
  "Weissle/persistent-breakpoints.nvim",
  config = function()
    local persistent_breakpoints = require("persistent-breakpoints")
    persistent_breakpoints.setup {
      load_breakpoints_event = { "BufReadPost" }
    }
  end,
}
