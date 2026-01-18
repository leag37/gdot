-- Set leader
vim.g.mapleader = " "

-- Keymap
local keymap = vim.keymap

-- Searching
keymap.set("n", "\\", ":nohl<CR>", { desc = "Clear search highlights" })

-- Window management
keymap.set("n", "<leader>ws", "<C-w>s", { desc = "Split a window horizontally" })
keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split a window vertically" })
keymap.set("n", "<leader>wx", "<cmd>close<CR>", { desc = "Close current window split" })
keymap.set("n", "<leader>wq", "<cmd>close<CR>", { desc = "Close current window split" })
keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make window splits equal size" })
keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Cycle to left pane" })
keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Cycle to below pane" })
keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Cycle to above pane" })
keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Cycle to right pane" })

keymap.set("n", "<leader>tt", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- Increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Saving and quitting
keymap.set("n", "<leader>vq", "<cmd>qa<CR>", { desc = "Exit NeoVim" })
keymap.set("n", "<leader>vQ", "<cmd>qa!<CR>", { desc = "Exit NeoVim" })
keymap.set("n", "<leader>vs", "<cmd>w<CR>", { desc = "Save current file" })
keymap.set("n", "<leader>va", "<cmd>w!<CR>", { desc = "Save all files" })
keymap.set("n", "<leader>vx", "<cmd>wq!<CR>", { desc = "Save all files and quit" })

-- Lazy function
keymap.set("n", "<leader>lz", "<cmd>Lazy<CR>", { desc = "Open Lazy plugin manager" })
