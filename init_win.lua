-- Ensure lazy.nvim is installed
local ensure_lazy = function()
  local install_path = vim.fn.stdpath('data') .. '/site/pack/lazy/start/lazy.nvim'
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/folke/lazy.nvim', install_path})
    vim.cmd([[packadd lazy.nvim]])
    return true
  end
  return false
end

-- Bootstrap lazy.nvim if needed
local lazy_bootstrap = ensure_lazy()

-- Protected call to ensure Lazy is available
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then return end

-- Plugin setup
lazy.setup({
  'nvim-treesitter/nvim-treesitter',
  'neovim/nvim-lspconfig',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lsp-signature-help',
  'L3MON4D3/LuaSnip',
  'windwp/nvim-autopairs',
  'numToStr/Comment.nvim',
  'simrat39/symbols-outline.nvim',
  'tanvirtin/monokai.nvim',
  'navarasu/onedark.nvim',
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  }
  -- Add other plugins here as needed
})

-- Treesitter configuration
require('nvim-treesitter.configs').setup({
  ensure_installed = { "c", "cpp", "css", "html", "javascript", "json", "lua", "markdown", "python", "rust", "typescript" },
  highlight = { enable = true },
  indent = { enable = true },
  fold = { enable = true, disable = {} }
})

vim.cmd([[autocmd CursorMoved * normal! zvzz]])

-- LSP setup
local lspconfig = require('lspconfig')
lspconfig.clangd.setup({
  cmd = { "clangd", "--background-index" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
  on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true }
    local buf_set_keymap = vim.api.nvim_buf_set_keymap
    local mappings = {
      { 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts },
      { 'n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>', opts },
      { 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts },
      { 'n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts },
      { 'n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts },
      { 'n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts }
    }
    for _, map in pairs(mappings) do
      buf_set_keymap(bufnr, unpack(map))  -- Ensure 5 arguments are passed
    end
  end,
  flags = { debounce_text_changes = 150 }
})

-- nvim-cmp setup with LuaSnip and LSP
local cmp = require('cmp')
local luasnip = require('luasnip')

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" })
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'nvim_lsp_signature_help' }
  }
})

-- Auto pairs configuration and integration with nvim-cmp
require('nvim-autopairs').setup({})
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

-- Comment plugin setup
require('Comment').setup()

-- Symbols-outline configuration
require('symbols-outline').setup()

-- Key mappings for SymbolsOutline and Commenting
vim.api.nvim_set_keymap('n', '<leader>o', ':SymbolsOutline<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-_>', ':lua require("Comment.api").toggle.linewise.current()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-_>', ':lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { noremap = true, silent = true })

-- Theme setup (Monokai/OneDark)
require('onedark').setup({ style = 'darker', transparent = false })
require('onedark').load()

-- Lualine setup
require('lualine').setup({
  options = {
    icons_enabled = true,
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  }
})

-- Common key mappings for clipboard and general usage
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-v>', '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-v>', '<C-r>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-a>', 'ggVG', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-x>', '"+d', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-x>', '"+d', { noremap = true, silent = true })

-- Sync plugins if lazy.nvim was just installed
if lazy_bootstrap then require('lazy').sync() end

-- Editor options
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.ruler = true
vim.opt.mouse = 'a'
vim.opt.wrap = true
vim.opt.wrapscan = true
