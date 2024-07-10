-- git clone --depth 1 https://github.com/wbthomason/packer.nvim `
--   $env:LOCALAPPDATA\nvim\site\pack\packer\start\packer.nvim


-- Ensure packer.nvim is installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}

-- Install your plugins here
packer.startup(function(use)
  -- My plugins here
  use 'wbthomason/packer.nvim' -- Have packer manage itself
  use 'nvim-treesitter/nvim-treesitter'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/LuaSnip'
  use 'windwp/nvim-autopairs'
  use 'nvim-treesitter/playground'
  use 'numToStr/Comment.nvim'
  use 'simrat39/symbols-outline.nvim' -- Plugin for symbol outline

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- Treesitter configuration
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "bash", "c", "cpp", "css", "dockerfile", "go", "html", "javascript", "json", "lua", "markdown", "python", "ruby", "rust", "toml", "typescript", "yaml" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

-- LSP configuration for C++
local lspconfig = require('lspconfig')
lspconfig.clangd.setup{
  cmd = { "clangd", "--background-index" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
  on_attach = function(client, bufnr)
      local buf_map = function(bufnr, mode, lhs, rhs, opts)
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
          noremap = true,
          silent = true,
        })
      end
      buf_map(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
      buf_map(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
      buf_map(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
      buf_map(bufnr, 'n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
      buf_map(bufnr, 'n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
      buf_map(bufnr, 'n', 'F2', '<cmd>lua vim.lsp.buf.rename()<CR>')
      buf_map(bufnr, 'n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>')
      buf_map(bufnr, 'n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    end,
    flags = {
      debounce_text_changes = 150,
    }
}

-- nvim-cmp setup
local cmp = require'cmp'
local luasnip = require'luasnip'

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
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

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }
})

-- Auto pairs configuration
require('nvim-autopairs').setup{}

-- If you want auto-pairs to work with nvim-cmp
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

require('Comment').setup()


-- Keybinding for commenting
vim.api.nvim_set_keymap('n', '<C-_>', ':lua require("Comment.api").toggle.linewise.current()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-_>', ':lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { noremap = true, silent = true })

-- Configure symbols-outline
require('symbols-outline').setup()

-- Keybinding for symbols outline
vim.api.nvim_set_keymap('n', '<leader>o', ':SymbolsOutline<CR>', { noremap = true, silent = true })

-- Set colorscheme
vim.cmd('colorscheme retrobox')

-- Enable syntax highlighting
vim.cmd('syntax on')

vim.opt.tabstop = 4
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.hlsearch = false

vim.opt.smartcase = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.ruler = true

vim.opt.mouse = "a"

