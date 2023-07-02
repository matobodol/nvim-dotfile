local Plugin = {
  {"folke/tokyonight.nvim"},
  {"Mofiqul/dracula.nvim",
    lazy = false,
    config = function()
      vim.cmd("colorscheme dracula")
    end
  },
}

return Plugin

