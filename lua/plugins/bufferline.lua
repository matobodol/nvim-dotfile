local Plugin = {'akinsho/bufferline.nvim'}
Plugin.dependencies = {'nvim-tree/nvim-web-devicons'}

Plugin.config = {
  options = {
    mode = 'buffers',
    offsets = {
      {filetype = 'NvimTree'}
    },
    numbers = 'none',
    diagnostics = 'nvim_lsp',
    diagnostics_indicator = function(count, level)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
    seperator_style = 'slant' or 'padded_slant',
    show_tab_indicators = true,
    show_buffer_close_icons = false,
    show_close_icon = false,
  }
}

function Plugin.init()
  vim.keymap.set({'n',}, '<leader>bb', '<cmd>BufferLineCyclePrev<cr>')
  vim.keymap.set({'n',}, '<leader>bn', '<cmd>BufferLineCycleNext<cr>')
  vim.keymap.set({'n',}, '<leader>c', '<cmd>bd<cr>')
end

return Plugin
