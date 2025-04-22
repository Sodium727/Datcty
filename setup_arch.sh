#!/usr/bin/env bash

# Bash script to automate Neovim (mainly C/C++), Wine setup for Arch-based systems

# Update the system and install required packages using pacman
# Install required packages: Neovim, Git, build tools, clangd, etc.
sudo pacman -Sy --needed archlinux-keyring 
sudo pacman-key --init
sudo pacman-key --populate archlinux

sudo pacman -Syu --needed wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses ocl-icd lib32-ocl-icd libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader wine-staging winetricks vulkan-headers lib32-mesa lib32-vulkan-icd-loader mesa vulkan-intel gnutls lib32-gnutls vulkan-intel lib32-vulkan-intel wine-mono git base-devel clang xclip dos2unix tree fastfetch qbittorrent htop gdb ripgrep neovim imv dosfstools ntfs-3g noto-fonts-cjk noto-fonts-emoji noto-fonts-extra noto-fonts

winetricks d3dcompiler_47 d3d9 d3d11 dxvk vulkan

yay -S --noconfirm --needed ttf-jetbrains-mono-nerd flashplayer-standalone

# Install Packer plugin manager for Neovim
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

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
  use 'rust-lang/rust.vim'
  use 'folke/tokyonight.nvim'
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
  keymap(bufnr, 'n', 'ga', ':lopen<CR>', opts)
  keymap(bufnr, 'n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)

-- Global diagnostics configuration
vim.diagnostic.config({
  virtual_text = true,  -- Enable virtual text (e.g., inline error/warning markers)
  signs = true,         -- Show signs (icons in the gutter for errors/warnings)
  underline = true,     -- Underline the text with issues
  update_in_insert = false,  -- Prevent updating diagnostics while typing (you can set this to  for real-time updates)
  severity_sort = true,  -- Sort diagnostics by severity (errors, warnings, etc.)

  -- Customize the floating window appearance
  float = {
    border = "rounded",  -- Border style: can be 'none', 'single', 'double', 'rounded', 'solid'
    source = "always",   -- Always show the source of the diagnostic (e.g., LSP or plugin)
    header = "",         -- Custom header text (you can leave it empty or add something)
    prefix = "",         -- Custom prefix for each diagnostic (e.g., "Error:", "Warning:", etc.)
  },
})

-- Customize the diagnostics signs (optional)
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

end

local on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
end

-- Rust LSP setup
lspconfig.rust_analyzer.setup({
  cmd = { "rust-analyzer" }, -- Ensure  is installed and in your PATH
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
-- lspconfig.clangd.setup({ on_attach = on_attach, capabilities = capabilities })
 lspconfig.clangd.setup({
   on_attach = on_attach,
   capabilities= capabilities,
   cmd = { "clangd" },
   filetypes = { "c", "cpp", "objc", "objcpp" },
   root_dir = require('lspconfig.util').root_pattern("compile_commands.json", ".git"),
 })


local luasnip = require('luasnip')
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
    { name = 'buffer', keyword_length = 1 }, -- Suggestions from buffers
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
vim.opt.relativenumber = false
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
vim.g.neoformat_notify = 0
vim.cmd [[autocmd BufWritePre *.cpp,*.h,*c Neoformat]]

vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
EOL

# Install Neovim plugins using Packer
nvim +PackerInstall

# Setup Hyprland + Preconfigured setup
git clone --depth 1 https://github.com/JaKooLit/Arch-Hyprland.git ~/Arch-Hyprland
cd ~/Arch-Hyprland
chmod +x install.sh
./install.sh

echo "Setup complete!"

# Extras
cat <<EOF
IF SOME PACKAGES CANNOT BE INSTALLED:
--> CHECK /etc/pacman.conf, AND ADD THESE REPOS:

[core-testing]
Include = /etc/pacman.d/mirrorlist
[core]
Include = /etc/pacman.d/mirrorlist
[extra-testing]
Include = /etc/pacman.d/mirrorlist
[extra]
Include = /etc/pacman.d/mirrorlist
[multilib-testing]
Include = /etc/pacman.d/mirrorlist
[multilib]
Include = /etc/pacman.d/mirrorlist
[chaotic-aur]
SigLevel = Never
Server = https://cdn-mirror.chaotic.cx/chaotic-aur/$arch

GOOD LUCK.
EOF
