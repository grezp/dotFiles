return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'preservim/nerdcommenter'               -- comment code easily
  use 'junegunn/fzf'                          -- command line fuzzy finder
  use 'junegunn/fzf.vim'                      -- fzf embeded into vim
  use 'tpope/vim-fugitive'                    -- git wrapper for vim
  -- use 'ludovicchabant/vim-gutentags'          -- ctag manager
  -- use 'jiangmiao/auto-pairs'                  -- auto gen matching brackets
  use 'chrisbra/NrrwRgn'                      -- narrow code snippets like emacs
  use 'lukas-reineke/indent-blankline.nvim'   -- create indent line for spaces
  -- use 'neovim/nvim-lspconfig'                 -- Collection of configurations for the built-in LSP client
  -- use 'vim-ruby/vim-ruby'

end)

