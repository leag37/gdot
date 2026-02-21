return {
  "mrjones2014/smart-splits.nvim",
  config = function()
    local smart_splits = require('smart-splits')
    local keymap = vim.keymap

    -- Key mappings
    -- resizing splits
    -- these keymaps will also accept a range, for example
    -- `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
    keymap.set('n', '<A-h>', smart_splits.resize_left)
    keymap.set('n', '<A-j>', smart_splits.resize_down)
    keymap.set('n', '<A-k>', smart_splits.resize_up)
    keymap.set('n', '<A-l>', smart_splits.resize_right)

    -- Moving between splits
    keymap.set('n', '<C-h>', smart_splits.move_cursor_left)
    keymap.set('n', '<C-j>', smart_splits.move_cursor_down)
    keymap.set('n', '<C-k>', smart_splits.move_cursor_up)
    keymap.set('n', '<C-l>', smart_splits.move_cursor_right)

    -- Swapping buffers between splits
    keymap.set('n', '<leader><leader>h', smart_splits.swap_buf_left)
    keymap.set('n', '<leader><leader>j', smart_splits.swap_buf_down)
    keymap.set('n', '<leader><leader>k', smart_splits.swap_buf_up)
    keymap.set('n', '<leader><leader>l', smart_splits.swap_buf_right)
  end,
}
