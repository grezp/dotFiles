return require('packer').startup{
  function(use)
    use 'wbthomason/packer.nvim'                -- Packer can manage itself
    use 'preservim/nerdcommenter'               -- comment code easily
    use 'junegunn/fzf'                          -- command line fuzzy finder
    use 'junegunn/fzf.vim'                      -- fzf embeded into vim
    use 'tpope/vim-fugitive'                    -- git wrapper for vim
    use 'lukas-reineke/indent-blankline.nvim'   -- create indent line for spaces
    use 'chrisbra/NrrwRgn'                      -- narrow code snippets like emacs
    use 'nathom/filetype.nvim'                  -- improves filetype startup time

    use {                                       -- nvim hl based on syntax
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
    }
    use 'neovim/nvim-lspconfig'                 -- Collection of configurations for the built-in LSP client

    use 'L3MON4D3/LuaSnip'

    -- completion
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-nvim-lua"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lsp-document-symbol"  -- TODO: test this later
    use "saadparwaiz1/cmp_luasnip"

    use "hrsh7th/cmp-cmdline"

    -- rice
    -- use "kyazdani42/nvim-web-devicons"
    use "onsails/lspkind-nvim"
  end
}
