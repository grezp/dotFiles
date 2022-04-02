local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify('packer not found!')
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- packer installs plugins here
return packer.startup {
  function(use)
    use 'wbthomason/packer.nvim'                -- Packer can manage itself

    -- utility --
    use 'chrisbra/NrrwRgn'                -- narrow code snippets like emacs
    use 'numToStr/Comment.nvim'           -- comment code w/ vi movements
    use 'folke/which-key.nvim'            -- shows what keys do + auto show buffers/registers
    use 'ggandor/lightspeed.nvim'         -- jump to text quickly by matching 2 chars
    use 'kevinhwang91/nvim-hlslens'       -- improves search by placing tags to jump to
    use 'famiu/bufdelete.nvim'            -- deletes buffer w/o closing/changing panes
    use 'jghauser/mkdir.nvim'             -- create missing dir(s) like 'mkdir -p'

    -- snippets --
    use {
      'L3MON4D3/LuaSnip',                     -- snippet engine
      requires = {
        { "rafamadriz/friendly-snippets" },   -- collection of snippets for several langs
      }
    }

    -- git --
    use 'tpope/vim-fugitive'              -- git wrapper for vim
    use 'sindrets/diffview.nvim'          -- provides inline diffs
    use {                                 -- displays inline git changes + blame
      'lewis6991/gitsigns.nvim',
      requires = {
        'nvim-lua/plenary.nvim'
      }
    }
    use {                                 -- magit clone
      'TimUntersberger/neogit',
      requires = {
        'nvim-lua/plenary.nvim'
      }
    }

    -- searching --
    use {
      'nvim-telescope/telescope.nvim',          -- fuzzy finder
      requires = {
        { 'nvim-lua/plenary.nvim' },                                  -- additional neovim APIs
        { 'kyazdani42/nvim-web-devicons' },                           -- icons
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }, -- FZF
      }
    }

    -- performance --
    use 'nathom/filetype.nvim'        -- improves filetype startup time

    -- lsp --
    use 'neovim/nvim-lspconfig'           -- Collection of configurations for the built-in LSP client
    use 'williamboman/nvim-lsp-installer' -- install lang servers in ~/.local/share/nvim/lsp_servers

    -- treesitter
    use {                                       -- nvim hl based on syntax
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
    }

    -- completion --
    use {
      'hrsh7th/nvim-cmp',                             -- autocompletion engine
      branch = 'dev',
      requires = {
        { 'hrsh7th/cmp-buffer' },                     -- autocomplete from buffer & enable '/' search
        { 'hrsh7th/cmp-path' },                       -- autocomplete directory path
        { 'hrsh7th/cmp-nvim-lua' },                   -- autocomplete Lua API
        { 'hrsh7th/cmp-nvim-lsp' },                   -- autocomplete from LSP
        { 'hrsh7th/cmp-nvim-lsp-document-symbol' },   -- allow '/@' to search for func defs
        { 'saadparwaiz1/cmp_luasnip' },               -- enable luasnip as cmp snippet engine
      }
    }

    -- aesthesics --
    use 'folke/tokyonight.nvim'
    use 'lukas-reineke/indent-blankline.nvim'   -- create indent line for spaces

    -- Automatically set up your configuration after cloning packer.nvim
    if PACKER_BOOTSTRAP then
      require("packer").sync()
    end
  end
}
