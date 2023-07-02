-----------------------------------------------------------
-- Dashboard configuration file
-----------------------------------------------------------

-- Plugin: alpha-nvim
-- url: https://github.com/goolord/alpha-nvim

-- For configuration examples see: https://github.com/goolord/alpha-nvim/discussions/16
local Plugin = {
  'goolord/alpha-nvim',
  event = "VimEnter",
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'nvim-tree/nvim-tree.lua'
  },
}

function Plugin.init()

  local status_ok, alpha = pcall(require, 'alpha')
  if not status_ok then
    return
  end

  local dashboard = require('alpha.themes.dashboard')

  -- Footer
  local function footer()
    --local version = vim.version()
    --local print_version = "v" .. version.major .. '.' .. version.minor .. '.' .. version.patch
    --local datetime = os.date('%Y/%m/%d %H:%M:%S')

    --return print_version .. ' - ' .. datetime
    return 'https://github.com/matobodol'
  end
  --
  -- Banner
  local neodol = {
    "                                                    ",
    "  ███╗  ██╗██████╗ █████╗ ██████╗  █████╗ ██╗      ",
    "  ████╗ ██║██╔═══╝██╔══██╗ ██╔═██╗██╔══██╗██║      ",
    "  ██╔██╗██║████╗  ██║  ██║ ██║ ██║██║  ██║██║      ",
    "  ██║╚████║██╔═╝  ██║  ██║ ██║ ██║██║  ██║██║      ",
    "  ██║ ╚███║██████╗╚█████╔╝██████╔╝╚█████╔╝██████╗  ",
    "  ╚═╝  ╚══╝╚═════╝ ╚════╝ ╚═════╝  ╚════╝ ╚═════╝  ",
    "                                                    ",
  }

  dashboard.section.header.val = neodol

  -- Menu
  dashboard.section.buttons.val = {
    dashboard.button('n', '  New file', ':ene <BAR> startinsert<CR>'),
    dashboard.button('h', "  History"   , ":Telescope oldfiles<CR>"),
    dashboard.button('e', "  Nvim-tree", ":NvimTreeToggle<CR>"),
    dashboard.button('f', "  Find file", ":cd $HOME | Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>"),
    dashboard.button('s', '  Settings', ':e $MYVIMRC<CR>'),
    dashboard.button('u', '  Update plugins', ':Lazy update<CR>'),
    dashboard.button('q', '  Quit', ':qa<CR>'),
  }

  dashboard.section.footer.val = footer()

  alpha.setup(dashboard.config)
  vim.keymap.set('n', '<leader>fa', '<cmd>:Alpha<cr>')

end


return Plugin
