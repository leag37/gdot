return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    local treesitter = require("nvim-treesitter")

    -- Configure treesitter
    treesitter.setup({
      -- enable syntax highlighting
      highlight = {
        enable = true,
      },
      -- ensure these language parsers are installed
      ensure_installed = {
        "bash",
        "c",
        "c_sharp",
        "cmake",
        "cpp",
        "css",
        "cuda",
        "disassembly",
        "dockerfile",
        "doxygen",
        "erlang",
        "fortran",
        "fsharp",
        "gitignore",
        "glsl",
        "go",
        "haskell",
        "hlsl",
        "html",
        "ini",
        "java",
        "javascript",
        "json",
        "kotlin",
        "llvm",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        "ruby",
        "rust",
        "sql",
        "tmux",
        "toml",
        "typescript",
        "vim",
        "xml",
        "yaml",
        "zsh",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end,
}
