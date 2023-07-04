local Plugin = {'lukas-reineke/indent-blankline.nvim'}

Plugin.opts = {
  vim.cmd [[highlight IndentBlanklineIndent1 guifg=#4B5263 gui=nocombine]],
  vim.cmd [[highlight IndentBlanklineIndent2 guifg=#4B5263 gui=nocombine]],
  vim.cmd [[highlight IndentBlanklineIndent3 guifg=#4B5263 gui=nocombine]],
  vim.cmd [[highlight IndentBlanklineIndent4 guifg=#4B5263 gui=nocombine]],
  vim.cmd [[highlight IndentBlanklineIndent5 guifg=#4B5263 gui=nocombine]],
  vim.cmd [[highlight IndentBlanklineIndent6 guifg=#4B5263 gui=nocombine]],

  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
    "IndentBlanklineIndent3",
    "IndentBlanklineIndent4",
    "IndentBlanklineIndent5",
    "IndentBlanklineIndent6",
  },

  enabled = true,
  show_current_context_start = true,
  show_trailing_blankline_indent = false,
  show_first_indent_level = true,
  use_treesitter = false,
  show_current_context = true,

  vim.keymap.set('n', '<leader>ui', '<cmd>IndentBlanklineToggle<cr>')
}

--return Plugin
local M = {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    -- char = "▏",
    --char = "│",
    filetype_exclude = {
      "help",
      "alpha",
      "dashboard",
      "neo-tree",
      "Trouble",
      "lazy",
      "mason",
      "notify",
      "toggleterm",
      "lazyterm",
    },
    show_trailing_blankline_indent = false,
    show_current_context_start = true,
    show_current_context = false,
  },
  -- active indent guide and indent text objects
  dependencies = {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      --symbol = "▏",
      symbol = "│",
      options = { try_as_border = true },
      draw = {
        -- Delay (in ms) between event and start of drawing scope indicator
        delay = 100,

        -- Animation rule for scope's first drawing. A function which, given
        -- next and total step numbers, returns wait time (in ms). See
        -- |MiniIndentscope.gen_animation| for builtin options. To disable
        -- animation, use `require('mini.indentscope').gen_animation.none()`.
        --animation = --<function: implements constant 20ms between steps>,

        -- Symbol priority. Increase to display on top of more symbols.
        priority = 2,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
          "nvimtree",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
}

return M
