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


    -----------------
    -- performance --
    -----------------
    use {
      'lewis6991/impatient.nvim',     --Speed up loading Lua modules
      config = function()
        require('impatient')
      end,
    }

    use 'nathom/filetype.nvim'        -- improves filetype startup time


    ----------------
    -- aesthesics --
    ----------------
    -- theme
    use 'folke/tokyonight.nvim'
    -- icons
    use 'kyazdani42/nvim-web-devicons'

    use {
      -- create indent line for spaces
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        require('indent_blankline').setup {
          char = '┊',
          show_current_context = true,
        }
      end,
    }


    ----------------
    -- treesitter --
    ----------------
    use {
      -- nvim hl based on syntax
      'nvim-treesitter/nvim-treesitter',
      run = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
      end,
      config = function()
        require('plugins.configs.treesitter')
      end,
    }


    ---------
    -- git --
    ---------
    use {
      -- git wrapper for vim
      'tpope/vim-fugitive',
      -- TODO: write git branch name for status line
      -- cmd = { 'Git', 'Gstatus', 'Gblame', 'Gpush', 'Gpull', 'Gvdiffsplit' },
    }

    use {
      -- displays inline git changes + blame
      'lewis6991/gitsigns.nvim',
      ft = 'gitcommit',
      setup = function()
        require('core.lazy_load').gitsigns()
      end,
      config = function()
        require('plugins.configs.gitsigns')
      end
    }

    use {
      -- magit clone
      'TimUntersberger/neogit',
      cmd = 'Neogit',
      config = function()
        require('plugins.configs.neogit')
      end
    }

    use {
      -- provides inline diffs
      'sindrets/diffview.nvim',
      cmd = { 'DiffviewOpen', 'DiffviewFileHistory', 'DiffviewLog' }
    }


    ---------
    -- lsp --
    ---------
    use {
      -- install lang servers in ~/.local/share/nvim/lsp_servers
      'williamboman/nvim-lsp-installer',
      opt = true,
      cmd = require('core.lazy_load').lsp_cmds,
      setup = function()
        require('core.lazy_load').on_file_open('nvim-lsp-installer')
      end,
    }

    use {
      -- Collection of configurations for the built-in LSP client
      'neovim/nvim-lspconfig',
      after = 'nvim-lsp-installer',
      module = 'lspconfig',
      config = function()
        require('plugins.lsp')
      end,
    }


    --------------
    -- snippets --
    --------------
    use {
      -- collection of snippets for several langs
      'rafamadriz/friendly-snippets',
      module = 'cmp_nvim_lsp',
      event = 'InsertEnter',
    }

    use {
      -- snippet engine
      'L3MON4D3/LuaSnip',
      wants = 'friendly-snippets',
      after = 'friendly-snippets',
      config = function()
        require('plugins.configs.luasnips')
      end,
    }


    ----------------
    -- completion --
    ----------------
    use {
      -- autocompletion engine
      'hrsh7th/nvim-cmp',
      after = 'LuaSnip',
      config = function()
        require('plugins.configs.cmp')
      end,
    }

    use {
        -- enable luasnip as cmp snippet engine
      'saadparwaiz1/cmp_luasnip',
      after = 'nvim-cmp',
    }

    use {
      -- autocomplete Lua API
      'hrsh7th/cmp-nvim-lua',
      after = 'cmp_luasnip',
    }

    use {
      -- autocomplete from LSP
      'hrsh7th/cmp-nvim-lsp',
      after = 'cmp-nvim-lua',
    }

    use {
      -- autocomplete from buffer & enable '/' search
      'hrsh7th/cmp-buffer',
      after = 'cmp-nvim-lsp',
    }

    use {
      -- autocomplete directory path
      'hrsh7th/cmp-path',
      after = 'cmp-buffer',
    }

    use {
      -- autocomplete cmd line
      'hrsh7th/cmp-cmdline',
      after = 'cmp-path'
    }


    ---------------
    -- searching --
    ---------------
    use {
      -- fuzzy finder
      'nvim-telescope/telescope.nvim',
      config = function()
        require('plugins.telescope')
      end,
    }

    use {
      'nvim-telescope/telescope-fzf-native.nvim',   -- FZF
      run = 'make',
    }

    use {
      'nvim-telescope/telescope-frecency.nvim',     -- improves file selection base on history
      requires = { 'tami5/sqlite.lua' },
    }


    -------------
    -- utility --
    -------------
    use {
      -- comment code w/ vi movements
      'numToStr/Comment.nvim',
      module = 'Comment',
      keys = { 'gc', 'gb', 'vgc', 'vgb'  },
      config = function()
        require('plugins.configs.comment')
      end,
    }

    use {
      -- jump to text quickly by matching 2 chars
      'ggandor/leap.nvim',
      -- module = 'leap',
      requires = { 'tpope/vim-repeat' },
      config = function()
        require('leap').add_default_mappings()
        local opts = {
          labels = { 'a', 'r', 's', 't', 'n', 'e', 'i', 'o', 'g', 'm', 'd', 'h',
                     'c', 'x', 'z', 'p', 'f', 'w', 'q', 'l', 'u', 'y', 'v', 'k' },
        }
        require('leap').setup(opts)
      end,
    }

    use {
      -- jump to text quickly by matching 1 chars
      'ggandor/flit.nvim',
      -- module = 'leap',
      config = function()
        require('flit').setup()
      end,
    }

    use {
      -- improves search by placing tags to jump to
      'kevinhwang91/nvim-hlslens',
      module = 'hlslens',
      config = function()
        require('plugins.configs.hlslens')
      end
    }

    use {
      -- deletes buffer w/o closing/changing panes
      'famiu/bufdelete.nvim',
      cmd = { 'Bdelete', 'Bwipeout' },
    }

    use {
      -- create missing dir(s) like 'mkdir -p'
      'jghauser/mkdir.nvim',
      event = 'BufWrite',
    }

    use {
      -- display startup time
      'dstein64/vim-startuptime',
      cmd = { 'StartupTime' },
    }

    use {
      'kylechui/nvim-surround',
      config = function()
          require("nvim-surround").setup()
      end
    }

    use {
      -- auto completes pairs: {}, (), [], "", ''
      'windwp/nvim-autopairs',
      after = 'nvim-cmp',
      config = function()
        require('plugins.configs.autopairs')
      end,
    }

    use {
      -- file explorer
      'kyazdani42/nvim-tree.lua',
      cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
      config = function()
        require('plugins.configs.nvimtree')
      end,
    }

    use {
      -- clipboard manager
      'AckslD/nvim-neoclip.lua',
      requires = {
        { 'kkharji/sqlite.lua' },
        { 'nvim-telescope/telescope.nvim' },
      },
      config = function()
        require('plugins.configs.neoclip')
      end,
    }

    use {
      -- nvim terminal
      'NvChad/nvterm',
      module = 'nvterm',
      config = function()
        require('plugins.configs.nvterm')
      end,
    }

    use {
       -- edit csv files in vim
      'chrisbra/csv.vim',
      ft = 'csv',
      config = function()
        vim.g.no_csv_maps = 1
      end
    }

    use {
      -- display buffer int tabline
      'akinsho/bufferline.nvim',
      tag = '*',
      config = function()
        require('plugins.configs.bufferline')
      end
    }

    use {
      -- shows what keys do + auto show buffers/registers
      'folke/which-key.nvim',
      module = 'which-key',
      config = function()
        require('plugins.configs.which-key')
      end,
    }

    -- Automatically set up your configuration after cloning packer.nvim
    if PACKER_BOOTSTRAP then
      require('packer').sync()
    end
  end
}
