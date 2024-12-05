-- Bootstrap packer
vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use {
    'neovim/nvim-lspconfig',
    requires = {
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip'
    }
  }
  use 'nvim-treesitter/nvim-treesitter'
  use 'windwp/nvim-autopairs'
  use 'numToStr/Comment.nvim'
  use 'navarasu/onedark.nvim'
  use 'overcache/NeoSolarized'
  use 'ray-x/lsp_signature.nvim'
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  })
  use 'sbdchd/neoformat'

  use {
   'nvim-telescope/telescope.nvim',
   requires = { {'nvim-lua/plenary.nvim'} }
} 
end)

-- Treesitter configuration
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "cpp", "html", "lua", "css", "javascript", "rust", "python"},
  highlight = { enable = true, disable = {}, },
}

-- LSP setup
local lspconfig = require('lspconfig')
lspconfig.clangd.setup{}

-- LSP Key Mappings
local function lsp_keymaps(bufnr)
  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gT', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
end

local on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
end

-- Configure clangd with on_attach
lspconfig.clangd.setup{
  on_attach = on_attach
}

-- nvim-cmp setup
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    -- Override these mappings to ensure they don't interfere with snippet navigation
    ['<Tab>'] = cmp.mapping(function(fallback)
      if require'luasnip'.expand_or_jumpable() then
        require'luasnip'.expand_or_jump()  -- Jump to the next placeholder
      elseif cmp.visible() then
        cmp.select_next_item()  -- Select next item in the completion list
      else
        fallback()  -- Default action (insert a tab)
      end
    end, { 'i', 's' }),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if require'luasnip'.jumpable(-1) then
        require'luasnip'.jump(-1)  -- Jump to the previous placeholder
      elseif cmp.visible() then
        cmp.select_prev_item()  -- Select previous item in the completion list
      else
        fallback()  -- Default action (insert a tab)
      end
    end, { 'i', 's' }),

    ['<C-Space>'] = cmp.mapping.complete(),  -- Ctrl+Space for completions
    ['<C-e>'] = cmp.mapping.close(),         -- Ctrl+e to close completions
    ['<CR>'] = cmp.mapping.confirm({ select = true }),  -- Enter to confirm selection
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  },
})

-- Auto pairs setup
require('nvim-autopairs').setup{}

-- Commenting setup
require('Comment').setup({
  padding = true,      -- Adds a space after the comment delimiters
  sticky = true,       -- Keeps the cursor in place when commenting
  ignore = nil,        -- Ignore certain filetypes from being commented
  toggler = {
    block = 'gc' -- Key mapping for block comments (multiline)
  },
  opleader = {
    block = 'gc'
  }
})

-- OneDark theme setup
require('onedark').load()

-- vim.cmd('colo NeoSolarized')

require'lsp_signature'.setup({
  bind = true,
  handler_opts = { border = "rounded" },
  hint_enable = true,
  hi_parameter = "Search",
})

-- Keybinding for signature help (argument hints)
vim.api.nvim_set_keymap('n', '<C-a>', 'ggVG', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua require"lsp_signature".signature_help()<CR>', { noremap = true, silent = true })

-- Map <Leader>t to open a terminal in a horizontal split
vim.api.nvim_set_keymap('n', '<Leader>t', ':vs | te<CR>', { noremap = true, silent = true })

-- Snippet navigation with LuaSnip
local luasnip = require("luasnip")

-- Move to next placeholder in a snippet
vim.api.nvim_set_keymap('i', '<C-Tab>', [[<Cmd>lua require'luasnip'.jump(1)<CR>]], { noremap = true, silent = true })

-- Move to previous placeholder in a snippet
vim.api.nvim_set_keymap('i', '<C-S-Tab>', [[<Cmd>lua require'luasnip'.jump(-1)<CR>]], { noremap = true, silent = true })

vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.mouse = 'a'
vim.opt.linebreak = true
vim.opt.formatoptions:append("t")

vim.cmd([[autocmd CursorMoved * normal! zvzz]])

-- with neoformat
vim.cmd [[autocmd BufWritePre *.cpp,*.h Neoformat]]

