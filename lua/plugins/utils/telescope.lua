local Plugin = {'nvim-telescope/telescope.nvim'}

Plugin.dependencies = {
  {'nvim-lua/plenary.nvim'},
  {
    'nvim-telescope/telescope-fzy-native.nvim',
  },
}

function Plugin.config()
  local actions = require('telescope.actions')

  -- Basic Configuration
  require('telescope').setup {
    defaults = {
      prompt_prefix = " > ",
      selection_caret = "> ",
      entry_prefix = "  ",
      initial_mode = "insert",
      sorting_strategy = "ascending",
      layout_strategy = "vertical",
      layout_config = {
        width = 0.90,
        height = 0.7,
        prompt_position = "bottom",
        horizontal = {
          mirror = false,
          --preview_width = 0.2,
        },
        vertical = {
          mirror = false,
          --preview_width = 0.2,
        },
      },
      file_ignore_patterns = { 'node_modules', '.git' }, -- Hapus '__pycache__' dari daftar
      generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
      path_display = { "shorten" },
      mappings = {
        i = {
          --["<esc>"] = actions.close,
          ["<M-n>"] = actions.cycle_history_next,
          ["<M-p>"] = actions.cycle_history_prev,
          ["<M-j>"] = actions.move_selection_next,
          ["<M-k>"] = actions.move_selection_previous,
        },
      },
      file_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
      grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
      qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    },
    pickers = {
      find_files = {
        hidden = true, -- Aktifkan opsi untuk menampilkan file tersembunyi'rg',
      },
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = true,
        override_file_sorter = true,
      }
    }
  }

  -- Key Mappings
  local map = vim.keymap.set
  local opts = { noremap = true, silent = true }
  local builtin = require('telescope.builtin')

  map('n', '<leader>ff', builtin.find_files, opts)
  map('n', '<leader>fh', builtin.oldfiles, opts)
  map('n', '<leader>fg', builtin.live_grep, opts)
  map('n', '<leader>fb', builtin.buffers, opts)
  map('n', '<leader>f?', builtin.help_tags, opts)
  map('n', '<leader>ft', builtin.treesitter, opts)
  map('n', '<leader>fc', builtin.commands, opts)
  map('n', '<leader>fd', builtin.colorscheme, opts)
  map('n', '<leader>fi', builtin.lsp_document_symbols, opts)
  map('n', '<leader>fs', builtin.grep_string, opts)
  map('n', '<leader>fk', builtin.keymaps, opts)

  -- Enable fzy native extension
  require('telescope').load_extension('fzy_native')
end

return Plugin

