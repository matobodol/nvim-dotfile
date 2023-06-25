local Plugin = {

	{"folke/tokyonight.nvim"},
	{"Mofiqul/dracula.nvim",
    config = function()
      vim.cmd("colorscheme dracula")
    end
  },
}


return Plugin

