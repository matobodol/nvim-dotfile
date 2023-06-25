local Plugin = {'neovim/nvim-lspconfig'}             -- Required
  Plugin.dependencies = {
    -- LSP Support
    {                                      -- Optional
      'williamboman/mason.nvim',
      build = function()
        pcall(vim.cmd, 'MasonUpdate')
      end,
    },
    {'williamboman/mason-lspconfig.nvim'}, -- Optional
    -- Autocompletion
    {'hrsh7th/nvim-cmp'},     -- Required
    {'hrsh7th/cmp-nvim-lsp'}, -- Required
    {'L3MON4D3/LuaSnip'},     -- Required
  }

function Plugin.config()

  -- Mason setup
  require("mason").setup()
  require("mason-lspconfig").setup {
    --ensure_installed = { "rust_analyzer" },
    automatic_installation = false,
    handlers = nil,
  }

  -- LSP SETUP
  local lspconfig = require('lspconfig')
  local lsp_defaults = lspconfig.util.default_config

  lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
  )

  -- CALL CLIENT BAHAS
--  require'lspconfig'.rust_analyzer.setup({})
    require'lspconfig'.lua_ls.setup {}

  vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function()
      local bufmap = function(mode, lhs, rhs)
        local opts = {buffer = true}
        vim.keymap.set(mode, lhs, rhs, opts)
      end

      -- Displays hover information about the symbol under the cursor
      bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

      -- Jump to the definition
      bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

      -- Jump to declaration
      bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

      -- Lists all the implementations for the symbol under the cursor
      bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

      -- Jumps to the definition of the type symbol
      bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

      -- Lists all the references 
      bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

      -- Displays a function's signature information
      bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

      -- Renames all references to the symbol under the cursor
      bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

      -- Selects a code action available at the current cursor position
      bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
      bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')

      -- Show diagnostics in a floating window
      bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

      -- Move to the previous diagnostic
      bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

      -- Move to the next diagnostic
      bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
    end
  })

  vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
  local cmp = require('cmp')
  local luasnip = require('luasnip')
  
  local select_opts = {behavior = cmp.SelectBehavior.Select}
    cmp.setup({})

  local sign = function(opts)
    vim.fn.sign_define(opts.name, {
      texthl = opts.name,
      text = opts.text,
      numhl = ''
    })
  end

  sign({name = 'DiagnosticSignError', text = '✘'})
  sign({name = 'DiagnosticSignWarn', text = '▲'})
  sign({name = 'DiagnosticSignHint', text = '⚑'})
  sign({name = 'DiagnosticSignInfo', text = ''})

  vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
  })

  vim.cmd([[
    set signcolumn=yes
    autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
  ]])

end

return Plugin
