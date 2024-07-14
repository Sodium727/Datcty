-- https://chatgpt.com/share/6c0267ed-0eb9-4ff6-920b-3ec64013a272

-- git clone --depth 1 https://github.com/folke/lazy.nvim C:\Users\Admin\Appdata\Local\nvim\site\pack\lazy\start\lazy.nvim


-- Ensure lazy.nvim is installed
local ensure_lazy = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/lazy/start/lazy.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/folke/lazy.nvim', install_path})
    vim.cmd [[packadd lazy.nvim]]
    return true
  end
  return false
end

local lazy_bootstrap = ensure_lazy()

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

-- Define your plugins here
lazy.setup({
  'nvim-treesitter/nvim-treesitter',
  'neovim/nvim-lspconfig',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'L3MON4D3/LuaSnip',
  'windwp/nvim-autopairs',
  'nvim-treesitter/playground',
  'numToStr/Comment.nvim',
  'simrat39/symbols-outline.nvim', -- Plugin for symbol outline
  'hrsh7th/cmp-nvim-lsp-signature-help',
  'tanvirtin/monokai.nvim',
  'navarasu/onedark.nvim',
  -- Add any other plugins you need here
})

-- Treesitter configuration
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "bash", "c", "cpp", "css", "dockerfile", "go", "html", "javascript", "json", "lua", "markdown", "python", "ruby", "rust", "toml", "typescript", "yaml" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
  fold = {
      enable = true,
      disable = {};
  }
}

-- Use Treesitter for folding
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldlevelstart = 99 -- Open all folds by default

-- Optional: Map keys to quickly open/close folds
vim.api.nvim_set_keymap('n', 'za', 'za', { noremap = true, silent = true })  -- Toggle fold
-- vim.api.nvim_set_keymap('n', 'zc', 'zc', { noremap = true, silent = true })  -- Close fold
-- vim.api.nvim_set_keymap('n', 'zo', 'zo', { noremap = true, silent = true })  -- Open fold

-- Custom fold text
vim.o.foldtext = 'v:lua.custom_fold_text()'

function _G.custom_fold_text()
  local line = vim.fn.getline(vim.v.foldstart)
  local num_of_lines = vim.v.foldend - vim.v.foldstart + 1
  return line .. ' ... ' .. num_of_lines .. ' lines'
end

-- Open folds when jumping to them
vim.cmd([[
  autocmd CursorMoved * normal! zvzz
]])

function _G.custom_fold_text()
  local line = vim.fn.getline(vim.v.foldstart)
  local num_of_lines = vim.v.foldend - vim.v.foldstart + 1
  return line .. ' ... ' .. num_of_lines .. ' lines'
end

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
    { name = 'nvim_lsp_signature_help' },
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

-- Configure monokai theme
-- require('monokai').setup {}
-- require('monokai').setup { palette = require('monokai').pro }
-- require('monokai').setup { palette = require('monokai').soda }
-- require('monokai').setup { palette = require('monokai').ristretto }

--Configure onedark theme
require('onedark').setup {
    style = 'darker'
}
require('onedark').load()

-- Ensure lazy.nvim is bootstrapped
if lazy_bootstrap then
  require('lazy').sync()
end



vim.opt.tabstop = 4
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartcase = true

vim.opt.number = true
vim.opt.relativenumber = false

vim.opt.ruler = true

vim.opt.mouse = "a"
vim.opt.wrapscan = true
