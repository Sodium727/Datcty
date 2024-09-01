-- Ensure packer.nvim is installed
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

-- Auto-reload Neovim whenever you save this file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Install your plugins here
packer.startup(function(use)
  use 'wbthomason/packer.nvim' -- Let packer manage itself

  -- Add your plugins here
  -- use 'nvim-treesitter/nvim-treesitter'
  -- use 'neovim/nvim-lspconfig'
  -- use 'hrsh7th/nvim-cmp'
  -- use 'hrsh7th/cmp-nvim-lsp'
  use 'windwp/nvim-autopairs'
  -- use 'nvim-treesitter/playground'
  use 'numToStr/Comment.nvim'
  use 'simrat39/symbols-outline.nvim'
  -- use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'tanvirtin/monokai.nvim'
  use 'navarasu/onedark.nvim'
  use 'L3MON4D3/LuaSnip'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons' }
  }
end)



-- Open folds when jumping to them
vim.cmd([[
  autocmd CursorMoved * normal! zvzz
]])

-- Auto pairs configuration
require('nvim-autopairs').setup{}

require('Comment').setup()

-- Keybinding for commenting
vim.api.nvim_set_keymap('n', '<C-_>', ':lua require("Comment.api").toggle.linewise.current()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-_>', ':lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { noremap = true, silent = true })

-- Configure symbols-outline
require('symbols-outline').setup()

-- Keybinding for symbols outline
-- vim.api.nvim_set_keymap('n', '<leader>o', ':SymbolsOutline<CR>', { noremap = true, silent = true })

-- Configure monokai theme
-- require('monokai').setup {}
-- require('monokai').setup { palette = require('monokai').pro }
-- require('monokai').setup { palette = require('monokai').soda }
-- require('monokai').setup { palette = require('monokai').ristretto }

--Configure onedark theme
require('onedark').setup {
  style = 'darker',
  transparent = false,
}
require('onedark').load()

-- Configure Lualine
-- Lualine setup
require('lualine').setup {
  options = {
    icons_enabled = true,
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

-- Function to copy selected text to system clipboard
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true, silent = true })

-- Function to paste text from system clipboard
vim.api.nvim_set_keymap('n', '<C-v>', '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-v>', '<C-r>+', { noremap = true, silent = true })

-- Common shortcuts similar to other editors
-- vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:w<CR>a', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-a>', 'ggVG', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<C-x>', '"+d', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('v', '<C-x>', '"+d', { noremap = true, silent = true })

-- Undo and Redo
-- vim.api.nvim_set_keymap('n', '<C-z>', 'u', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('i', '<C-z>', '<Esc>u', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<C-y>', '<C-r>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('i', '<C-y>', '<Esc><C-r>', { noremap = true, silent = true })


vim.opt.tabstop = 2
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
vim.opt.wrap = true

