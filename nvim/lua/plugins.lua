return require('packer').startup{
  function(use)
    use 'wbthomason/packer.nvim'                -- Packer can manage itself

    -- utility
    use 'tpope/vim-fugitive'              -- git wrapper for vim
    use 'chrisbra/NrrwRgn'                -- narrow code snippets like emacs
    use 'numToStr/Comment.nvim'           -- comment code w/ vi movements
    use 'folke/which-key.nvim'            -- shows what keys do + auto show buffers/registers
    use 'ggandor/lightspeed.nvim'         -- jump to text quickly by matching 2 chars
    use 'kevinhwang91/nvim-hlslens'       -- improves search by placing tags to jump to
    use 'famiu/bufdelete.nvim'            -- deletes buffer w/o closing/changing panes
    use 'jghauser/mkdir.nvim'             -- create missing dir(s) like 'mkdir -p'
    use 'L3MON4D3/LuaSnip'                -- create custom snippets

    -- searching
    use {
      'nvim-telescope/telescope.nvim',          -- fuzzy finder
      requires = {
        { 'nvim-lua/plenary.nvim' },                                  -- additional neovim APIs
        { 'kyazdani42/nvim-web-devicons' },                           -- icons
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }, -- FZF
      }
    }

    -- performance
    use 'nathom/filetype.nvim'                  -- improves filetype startup time

    -- nvim native
    use 'neovim/nvim-lspconfig'                 -- Collection of configurations for the built-in LSP client
    use {                                       -- nvim hl based on syntax
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
    }

    -- completion
    use {
      'hrsh7th/nvim-cmp',                             -- autocompletion engine
      requires = {
        { 'hrsh7th/cmp-buffer' },                     -- autocomplete from buffer & enable '/' search
        { 'hrsh7th/cmp-path' },                       -- autocomplete directory path
        { 'hrsh7th/cmp-nvim-lua' },                   -- autocomplete Lua API
        { 'hrsh7th/cmp-nvim-lsp' },                   -- autocomplete from LSP
        { 'hrsh7th/cmp-nvim-lsp-document-symbol' },   -- allow '/@' to search for func defs
        { 'saadparwaiz1/cmp_luasnip' },               -- enable luasnip as cmp snippet engine
        { 'onsails/lspkind-nvim' },                   -- display group tags on cmp (e.g. LSP, buffer, etc.)
      }
    }

    -- aesthesics
    use 'NTBBloodbath/doom-one.nvim'
    use 'lukas-reineke/indent-blankline.nvim'   -- create indent line for spaces

  end
}
