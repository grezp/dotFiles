return require('packer').startup{
  function(use)
    use 'wbthomason/packer.nvim'                -- Packer can manage itself

    -- utility
    use 'tpope/vim-fugitive'                    -- git wrapper for vim
    use 'chrisbra/NrrwRgn'                      -- narrow code snippets like emacs
    use 'numToStr/Comment.nvim'                 -- comment code w/ vi movements
    use 'ggandor/lightspeed.nvim'               -- jump to text quickly

    -- searching
    use 'junegunn/fzf'                          -- command line fuzzy finder
    use 'junegunn/fzf.vim'                      -- fzf embeded into vim

    -- performance
    use 'nathom/filetype.nvim'                  -- improves filetype startup time

    -- nvim native
    use 'neovim/nvim-lspconfig'                 -- Collection of configurations for the built-in LSP client
    use {                                       -- nvim hl based on syntax
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
    }

    use 'L3MON4D3/LuaSnip'

    -- completion
    use "hrsh7th/nvim-cmp"                      -- autocompletion engine
    use "hrsh7th/cmp-buffer"                    -- autocomplete from buffer & enable '/' search
    use "hrsh7th/cmp-path"                      -- autocomplete directory path
    use "hrsh7th/cmp-nvim-lua"                  -- autocomplete Lua API
    use "hrsh7th/cmp-nvim-lsp"                  -- autocomplete from LSP
    use "hrsh7th/cmp-nvim-lsp-document-symbol"  -- allow '/@' to search for func defs
    use "saadparwaiz1/cmp_luasnip"              -- enable luasnip as cmp snippet engine
    use "onsails/lspkind-nvim"                  -- display group tags on cmp (e.g. LSP, buffer, etc.)

    -- aesthesics
    use 'NTBBloodbath/doom-one.nvim'
    use 'lukas-reineke/indent-blankline.nvim'   -- create indent line for spaces
    use {                                       -- shows what keys do + auto show buffers/registers
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup{}
      end
    }
  end
}
