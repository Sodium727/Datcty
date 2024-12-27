#!/usr/bin/env bash
# Bash to automate neovim setup (for C/C++)



# Update and install Neovim, Git, build-essential, and clangd
sudo apt update 
sudo apt upgrade -y

# Make sure to manually install the latest neovim version first (through .deb package)
# https://github.com/neovim/neovim-releases/releases
# sudo apt install ./nvim-linux64.deb

# If doesn't work, remove the old neovim:
# sudo apt remove neovim -y
# sudo apt remove neovim-runtime -y

sudo apt install -y git build-essential clangd clang-format gdb

# Install Packer plugin manager
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Create Neovim config directory if it doesn't exist
mkdir -p ~/.config/nvim

# Write the Neovim configuration to init.lua
cat <<EOL > ~/.config/nvim/init.lua
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
  use 'ray-x/lsp_signature.nvim'
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use  branch for the latest features
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
  use 'akinsho/bufferline.nvim'
  use 'nvim-tree/nvim-tree.lua'
end)

-- Treesitter Configuration
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "cpp", "lua", "javascript", "rust", "python", "html", "css" },
  highlight = { enable = true },
  auto_install = true,
}

-- LSP Setup
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  keymap(bufnr, 'n', 'gT', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
end

local on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
end

-- Rust LSP setup
lspconfig.rust_analyzer.setup({
  cmd = { "rust-analyzer" }, -- Ensure `rust-analyzer` is installed and in your PATH
  on_attach = function(client, bufnr)
    lsp_keymaps(bufnr)
    client.server_capabilities.semanticTokensProvider = nil -- Fix for some issues with diagnostics
  end,
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      assist = {
        importGranularity = "module",
        importPrefix = "by_self",
      },
      cargo = {
        loadOutDirsFromCheck = true,
      },
      procMacro = {
        enable = true,
      },
      checkOnSave = {
        command = "clippy", -- Enables Clippy linting for better diagnostics
      },
    },
  },
})

-- Additional LSPs
lspconfig.clangd.setup({ on_attach = on_attach, capabilities = capabilities })

local cmp = require'cmp'
-- nvim-cmp Configuration (for better appearance)
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<Tab>'] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      elseif cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer', keyword_length = 4 }, -- Suggestions from buffers
    { name = 'path' },
    { name = 'luasnip' },
  }),
  window = {
    documentation = cmp.config.window.bordered(), -- Adds borders to the documentation box
    completion = cmp.config.window.bordered(),   -- Borders around the completion menu
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        buffer = "[Buffer]",
        path = "[Path]",
        luasnip = "[Snip]",
      })[entry.source.name]
      return vim_item
    end,
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

vim.cmd('colo tokyonight-storm')

require'lsp_signature'.setup({
  bind = true,
  handler_opts = { border = "rounded" },
  hint_enable = true,
  hi_parameter = "Search",
})

local opt = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
-- Keybinding for signature help (argument hints)
keymap('n', '<C-a>', 'ggVG', opt)
keymap('n', '<C-k>', '<cmd>lua require"lsp_signature".signature_help()<CR>', opt)

-- Map <Leader>t to open a terminal in a horizontal split
keymap('n', '<Leader>t', ':vs | te<CR>', opt)
keymap('n', '<C-s>', ':w<CR>', opt)
keymap('t', 'jk', [[<C-\><C-n>]], opt)

-- Quick navigation in terminal mode
keymap('t', '<C-h>', [[<C-\><C-n><C-w>h]], opt)
keymap('t', '<C-j>', [[<C-\><C-n><C-w>j]], opt)
keymap('t', '<C-k>', [[<C-\><C-n><C-w>k]], opt)
keymap('t', '<C-l>', [[<C-\><C-n><C-w>l]], opt)

-- Snippet navigation with LuaSnip
local luasnip = require("luasnip")

-- Move to next placeholder in a snippet
keymap('i', '<C-Tab>', [[<Cmd>lua require'luasnip'.jump(1)<CR>]], opt)

-- Move to previous placeholder in a snippet
keymap('i', '<C-S-Tab>', [[<Cmd>lua require'luasnip'.jump(-1)<CR>]], opt)

vim.opt.wrap = true
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

vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
EOL

# Install Neovim plugins using Packer
nvim +PackerInstall

cat << 'EOF' > c.sh
#!/bin/bash

# Check if the file name is provided
if [ -z "$1" ]; then
  echo "Usage: ./c.sh <filename.cpp>"
  exit 1
fi

# Extract file name without extension
filename="${1%.*}"

# Compile the C++ file with g++
echo "Compiling $1..."
g++ -O2 -std=c++14 -w -o "$filename" "$1"

# Check if compilation was successful
if [ $? -eq 0 ]; then
  echo "Compilation successful. Running $filename..."
  echo "------------------------------"
  ./"$filename"
  echo
  echo "------------------------------"
  rm "$filename"
else
  echo "Compilation failed."
fi
EOF

# Create the ~/scripts directory if it doesn't exist
mkdir -p ~/scripts

# Move cpp.sh into ~/scripts
mv c.sh ~/scripts/c.sh

# Make cpp.sh executable
chmod u+x ~/scripts/c.sh

# Add ~/scripts to the PATH if it's not already in there
if ! echo "$PATH" | grep -q "$HOME/scripts"; then
  echo 'export PATH="$PATH:$HOME/scripts"' >> ~/.bashrc
  source ~/.bashrc
fi


echo "C/C++ setup complete!"
