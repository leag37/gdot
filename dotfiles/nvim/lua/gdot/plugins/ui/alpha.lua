return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Header
    -- Courtesy of https://patorjk.com/software/taag/#p=display&v=0&f=ANSI%20Shadow&t=Neovim
    -- Option 1 (ghost)
    dashboard.section.header.val = {
        "     .-') _   ('-.                     (`-.           _   .-')    ",
        "    ( OO ) )_(  OO)                  _(OO  )_        ( '.( OO )_  ",
        ",--./ ,--,'(,------. .-'),-----. ,--(_/   ,. \\ ,-.-') ,--.   ,--.)",
        "|   \\ |  |\\ |  .---'( OO'  .-.  '\\   \\   /(__/ |  |OO)|   `.'   | ",
        "|    \\|  | )|  |    /   |  | |  | \\   \\ /   /  |  |  \\|         | ",
        "|  .     |/(|  '--. \\_) |  |\\|  |  \\   '   /,  |  |(_/|  |'.'|  | ",
        "|  |\\    |  |  .--'   \\ |  | |  |   \\     /__),|  |_.'|  |   |  | ",
        "|  | \\   |  |  `---.   `'  '-'  '    \\   /   (_|  |   |  |   |  | ",
        "`--'  `--'  `------'     `-----'      `-'      `--'   `--'   `--' ",
    } 

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button("SPC sr", "󰑓 Restore previous session", "<cmd>AutoSession restore<CR>"), 
      dashboard.button("e", " > New File", "<cmd>ene<CR>"),
      dashboard.button("SPC ee", " > Open File Explorer", "<cmd>NvimTreeOpen<CR>"),
      dashboard.button("SPC ff", "󰈞 > Find File", "<cmd>Telescope find_files<CR>"),
      dashboard.button("SPC fs", " > Find String", "<cmd>Telescope live_grep<CR>"),
      dashboard.button("q", " > Quit NVIM", "<cmd>qa<CR>"),
    }

    -- Setup
    alpha.setup(dashboard.opts)

    -- Disable folding on this buffer
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
end,
}
