-- Slightly better directory navigation settings for non-treesitter
vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- Line numbers
opt.number = true -- show the absolute line number of the selected line
opt.relativenumber = true -- show the relative line numbers compared to the current line
opt.wrap = false -- disable line wrapping
opt.cursorline = true -- highlight the current line occupied by the cursor

-- Searching
opt.hlsearch = true -- highlight the search result
opt.incsearch = true -- search incrementally matches as pattern is modified
opt.ignorecase = true -- case insensitive by default
opt.smartcase = true -- if casing is introduced, become case sensitive; paired with the above option

-- Tabs and spaces
opt.tabstop = 2 -- 2 spaces per tab
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting a new one

-- Colorscheme prep
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be forced to dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line, or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use the system clipboard as the default register

-- split windows
opt.splitright = true
opt.splitbelow = true

-- File format options
opt.ffs = "unix,dos"
