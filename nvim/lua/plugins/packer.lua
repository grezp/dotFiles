local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
  print 'Installing packer close and reopen Neovim...'
  vim.cmd [[packadd packer.nvim]]
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  vim.notify('packer not found!')
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

-- packer installs plugins here
return packer.startup {
  function(use)
    use 'wbthomason/packer.nvim'    -- Packer can manage itself
    use 'nvim-lua/plenary.nvim'


    -- performance --
    use {
      'lewis6991/impatient.nvim',     --Speed up loading Lua modules
      config = function()
        require('plugins.configs.others').impatient()
      end,
    }
    use 'nathom/filetype.nvim'        -- improves filetype startup time


    -- aesthesics --
    use 'folke/tokyonight.nvim'
    use 'kyazdani42/nvim-web-devicons'        -- icons
    use {
      'lukas-reineke/indent-blankline.nvim',  -- create indent line for spaces
      config = function()
        require('plugins.configs.others').blankline()
      end
    }


    -- treesitter
    use {                                       -- nvim hl based on syntax
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
    }


    -- git --
    use 'tpope/vim-fugitive'              -- git wrapper for vim
    use 'sindrets/diffview.nvim'          -- provides inline diffs
    use 'lewis6991/gitsigns.nvim'         -- displays inline git changes + blame
    use 'TimUntersberger/neogit'          -- magit clone


    -- lsp --
    use 'neovim/nvim-lspconfig'           -- Collection of configurations for the built-in LSP client
    use 'williamboman/nvim-lsp-installer' -- install lang servers in ~/.local/share/nvim/lsp_servers


    -- snippets --
    use 'L3MON4D3/LuaSnip'              -- snippet engine
    use 'rafamadriz/friendly-snippets'  -- collection of snippets for several langs


    -- completion --
    use 'hrsh7th/nvim-cmp'                        -- autocompletion engine
    use 'hrsh7th/cmp-buffer'                      -- autocomplete from buffer & enable '/' search
    use 'hrsh7th/cmp-path'                        -- autocomplete directory path
    use 'hrsh7th/cmp-cmdline'                     -- autocomplete cmd line
    use 'hrsh7th/cmp-nvim-lua'                    -- autocomplete Lua API
    use 'hrsh7th/cmp-nvim-lsp'                    -- autocomplete from LSP
    use 'hrsh7th/cmp-nvim-lsp-document-symbol'    -- allow '/@' to search for func defs
    use 'saadparwaiz1/cmp_luasnip'                -- enable luasnip as cmp snippet engine


    -- searching --
    use 'nvim-telescope/telescope.nvim'             -- fuzzy finder
    use {
      'nvim-telescope/telescope-fzf-native.nvim',   -- FZF
      run = 'make'
    }
    use {
      'nvim-telescope/telescope-frecency.nvim',     -- improves file selection base on history
      requires = { 'tami5/sqlite.lua' },
    }


    -- utility --
    use 'numToStr/Comment.nvim'           -- comment code w/ vi movements
    use 'folke/which-key.nvim'            -- shows what keys do + auto show buffers/registers
    use 'ggandor/lightspeed.nvim'         -- jump to text quickly by matching 2 chars
    use 'kevinhwang91/nvim-hlslens'       -- improves search by placing tags to jump to
    use 'famiu/bufdelete.nvim'            -- deletes buffer w/o closing/changing panes
    use 'jghauser/mkdir.nvim'             -- create missing dir(s) like 'mkdir -p'
    use 'tpope/vim-surround'              -- surround selected text with chars (e.g. '/")
    use 'tpope/vim-repeat'                -- repeat plugins with .
    use 'windwp/nvim-autopairs'           -- auto completes pairs: {}, (), [], "", ''
    use "kyazdani42/nvim-tree.lua"        -- file explorer
    use {
      'chrisbra/csv.vim',                 -- edit csv files in vim
      config = function()
        require('plugins.configs.others').csv()
      end
    }

    -- Automatically set up your configuration after cloning packer.nvim
    if PACKER_BOOTSTRAP then
      require('packer').sync()
    end
  end
}
