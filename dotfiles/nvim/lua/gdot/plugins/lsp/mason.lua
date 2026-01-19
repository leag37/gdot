return {
  "mason-org/mason.nvim",
  dependencies = {
    "mason-org/mason-lspconfig.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        -- LSPs
        "bashls",
        "buf_ls",
        "clangd",
        "cmake",
        "csharp_ls",
        "cobol_ls",
        "cssls",
        "diagnosticls",
        "docker_language_server",
        -- "elp",
        "erlangls",
        "eslint",
        "fortls",
        -- "gdscript", -- not officially supported
        -- "gdshader_lsp", -- not officially supported
        "glsl_analyzer",
        "gopls",
        "hls",
        "html",
        "jdtls",
        "jsonls",
        "kotlin_lsp",
        "lua_ls",
        "markdown_oxide",
        "marksman",
        "opencl_ls",
        "pylsp",
        "rust_analyzer",
        "slangd",
        "ts_ls",
        "vimls",
        "yamlls",

      },
    })

    ---@param packages string[]
    local function InstallSupplementalPackages(packages)
      local mason_commands = require("mason.api.command")
      local registry = require("mason-registry")

      local to_install = {}
      for _, v in ipairs(packages) do
        if not registry.is_installed(v) then
          table.insert(to_install, v)
        end

        if next(to_install) ~= nil then
          mason_commands.MasonInstall(to_install, {})
        end
      end
    end

    -- Install other packages
    -- DAPs
    local daps = {
      "codelldb",
      "cpptools",
      "debugpy",
      "delve", -- go
      "erlang-debugger",
      "go-debug-adapter",
      "haskell-debug-adapter",
      "js-debug-adapter",
      "kotlin-debug-adapter",
      "local-lua-debugger-vscode",
    }
    InstallSupplementalPackages(daps)

    -- Linters
    local linters = {
      "cmakelang",
      "cpplint",
      "fortitude",
      "hlint",
      "htmlhint",
      "jsonlint",
      -- "luacheck", -- does not support Lua 5.5 yet
      "markdownlint",
      "mypy",
      "quick-lint-js",
      "yamllint",
    }
    InstallSupplementalPackages(linters)

    -- Formatters
    local formatters = {
      "asmfmt",
      "autopep8",
      "buf",
      "clang-format",
      "cmakelang",
      "csharpier",
      "fprettify",
      -- "gdtoolkit",
      "ktlint",
      "luaformatter",
      "prettier",
      -- "rustfmt", -- deprecated
      "ts-standard",
      "yamlfmt",

    }
    InstallSupplementalPackages(formatters)

  end,
}
