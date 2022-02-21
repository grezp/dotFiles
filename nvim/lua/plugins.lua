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
  end
}
