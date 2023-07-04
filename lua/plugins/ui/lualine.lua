local Plugin = {'nvim-lualine/lualine.nvim'}
Plugin.dependencies = {'nvim-tree/nvim-web-devicons'}

Plugin.opts = {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      winbar = {},
      statusline = { "dashboard", "alpha" },
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'},
    lualine_c = {'diagnostics'},
    lualine_x = {},
    --lualine_y = {'progress'},
    lualine_y = {'location'},
    lualine_z = {
      function()
        return " " .. os.date("%R")
      end,
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {
      function()
        return " " .. os.date("%R")
      end,
    },
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

return Plugin
