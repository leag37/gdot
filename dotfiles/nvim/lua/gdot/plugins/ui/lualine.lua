return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "stevearc/overseer.nvim",
    "Civitasv/cmake-tools.nvim",
  },
  config = function()
    local lualine = require("lualine")
    local cmake = require("cmake-tools")
    local icons = require("gdot.core.icons")

    local colors = {
      blue = "#65D1FF",
      green = "#3EFFDC",
      violet = "#FF61EF",
      yellow = "#FFDA7B",
      red = "#FF4A4A",
      fg = "#C3CCDC",
      bg = "#112638",
      inactive_bg = "#2C3043",
    }

    local my_lualine_theme = {
      normal = {
        a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      insert = {
        a = { bg = colors.green, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      visual = {
        a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      command = {
        a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      replace = {
        a = { bg = colors.red, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      inactive = {
        a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
        b = { bg = colors.inactive_bg, fg = colors.semilightgray },
        c = { bg = colors.inactive_bg, fg = colors.semilightgray },
      },
    }

    -- Cache lazy status for pending updates
    local lazy_status = require("lazy.status")

    -- Configure lualine with modified theme
    local config = {
      options = {
        theme = my_lualine_theme,
      },
      sections = {
        -- lualine_a =  {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        -- lualine_z = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
    }

    -- Insert a component in lualine_c at left section
    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    -- Insert a component in lualine_x at right section
    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    -- ins_left { "mode" }
    ins_left { "branch" }
    ins_left {
      function()
        local c_preset = cmake.get_configure_preset()
        return "CMake: [" .. (c_preset and c_preset or "X") .. "]"
      end,
      icon = icons.ui.Search,
      cond = function()
        return cmake.is_cmake_project() and cmake.has_cmake_preset()
      end,
      on_click = function(n, mouse)
        if (n == 1) then
          if (mouse == "l") then
            vim.cmd("CMakeSelectConfigurePreset")
          end
        end
      end
    }
    -- ins_left {
    --   function()
    --     local build_type = cmake.get_build_type()
    --     return "CMake: [" .. (build_type and build_type or "") .. "]"
    --   end,
    --   icon = icons.ui.Search,
    --   cond = function()
    --     return cmake.is_cmake_project() and cmake.has_cmake_preset()
    --   end,
    --   on_click = function(n, mouse)
    --     if (n == 1) then
    --       if (mouse == "l") then
    --         vim.cmd("CMakeSelectBuildType")
    --       end
    --     end
    --   end
    -- }
    -- ins_left {
    --   function()
    --     local kit = cmake.get_kit()
    --     return "CMake: [" .. (kit and kit or "X") .. "]"
    --   end,
    --   icon = icons.ui.Pencil,
    --   cond = function()
    --     return cmake.is_cmake_project() and cmake.has_cmake_preset()
    --   end,
    --   on_click = function(n, mouse)
    --     if (n == 1) then
    --       if (mouse == "l") then
    --         vim.cmd("CMakeSelectKit")
    --       end
    --     end
    --   end
    -- }
    ins_left {
      function()
        return "Build"
      end,
      icon = icons.ui.Gear,
      cond = cmake.is_cmake_project,
      on_click = function(n, mouse)
        if (n == 1) then
          if (mouse == "l") then
            vim.cmd("CMakeBuild")
          end
        end
      end
    }
    -- ins_left {
    --   function()
    --     local b_preset = cmake.get_build_preset()
    --     return "CMake: [" .. (b_preset and b_preset or "X") .. "]"
    --   end,
    --   icon = icons.ui.Search,
    --   cond = function()
    --     return cmake.is_cmake_project() and cmake.has_cmake_preset()
    --   end,
    --   on_click = function(n, mouse)
    --     if (n == 1) then
    --       if (mouse == "l") then
    --         vim.cmd("CMakeSelectBuildPreset")
    --       end
    --     end
    --   end
    -- }
    -- ins_left {
    --   function()
    --     local b_target = cmake.get_build_target()
    --     return "CMake: [" .. (b_target and b_target or "X") .. "]"
    --   end,
    --   icon = icons.ui.Search,
    --   cond = cmake.is_cmake_project,
    --   on_click = function(n, mouse)
    --     if (n == 1) then
    --       if (mouse == "l") then
    --         vim.cmd("CMakeSelectBuildTarget")
    --       end
    --     end
    --   end
    -- }
    ins_left {
      function()
        return icons.ui.Run
      end,
      cond = cmake.is_cmake_project,
      on_click = function(n, mouse)
        if (n == 1) then
          if (mouse == "l") then
            vim.cmd("CMakeRun")
          end
        end
      end
    }
    ins_left {
      function()
        local l_target = cmake.get_launch_target()
        return "[" .. (l_target and l_target or "X") .. "]"
      end,
      cond = cmake.is_cmake_project,
      on_click = function(n, mouse)
        if (n == 1) then
          if (mouse == "l") then
            vim.cmd("CMakeSelectLaunchTarget")
          end
        end
      end
    }
    ins_left {
      function()
        return icons.ui.Debug
      end,
      cond = cmake.is_cmake_project,
      on_click = function(n, mouse)
        if (n == 1) then
          if (mouse == "l") then
            vim.cmd("CMakeDebug")
          end
        end
      end
    }
    ins_left {
      "filename",
      path = 1,
    }

    ins_right {
      lazy_status.updates,
      cond = lazy_status.has_updates,
      color = { fg = "#FF9E64" },
    }

    ins_right { "overseer" }
    ins_right {
      "datetime",
      style = "%H:%M:%S",
    }
    ins_right { "encoding" }
    ins_right { "fileformat" }
    ins_right { "filetype" }
    -- ins_right { "location" }
    ins_right { "progress" }

    -- Apply config
    lualine.setup(config)
  end,
}
