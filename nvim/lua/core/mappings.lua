local toggle_diags = true
local toggle_pairs = true

local opts1 = { noremap = true, silent = true }
local function termcodes(str)
   return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local M = {}

M.general = {

  i = {
    -- navigate within insert mode
    ['<C-h>'] = { '<Left>',   '  move left' },
    ['<C-l>'] = { '<Right>',  '  move right' },
    ['<C-j>'] = { '<Down>',   '  move down' },
    ['<C-k>'] = { '<Up>',     '  move up' },
  },

  n = {
    -- general
    ['<ESC>']     = { ':noh<CR>', '  no highlight' },
    ['<Leader>o'] = { 'o<ESC>',         '  new line below' },
    ['<Leader>O'] = { 'O<ESC>',         '  new line above' },

    -- system file
    ['<Leader>s'] = { '<cmd> w <CR>',  '  saves current file'},
    ['<Leader>q'] = { '<cmd> q <CR>',  '  exit window'},
    ['<Leader>Q'] = { '<cmd> q! <CR>', '  exit window'},

    -- buffers
    ['<Leader>b']  = { name = '  Buffers' },
    ['<Leader>bn'] = { '<cmd> bnext<CR>',                  '  next buffer' },
    ['<Leader>bp'] = { '<cmd> bprev<CR>',                  '  prev buffer' },
    ['<Leader>bd'] = { '<cmd> Bdelete<CR>',                '  delete buffer' },
    ['<Leader>bD'] = { '<cmd> bdelete<CR>',                '  delete buffer' },

    -- windows
    ['<Leader>w'] = { '<C-w>',                   '  window keybind' },
    ['<C-Up>']    = { ':resize +2<CR>',          '  window height' },
    ['<C-Down>']  = { ':resize -2<CR>',          '  window height' },
    ['<C-Left>']  = { ':vertical resize -2<CR>', '  window height' },
    ['<C-Rigth>'] = { ':vertical resize +2<CR>', '  window height' },

    -- misc
    -- keep prev copy in buffer 0
    ["p"] = { '"_dP', opts = { silent = true } },
    ['<Leader>ts'] = { '<cmd> set list!<CR>', '  white Space' },

    ['\\c'] = { ':cd %:p:h<CR>', '  change directory' },

    -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
    -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
    -- empty mode is same as using <cmd> :map
    -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
    ['j']      = { [[v:count || mode(1)[0:1] == 'no' ? 'j' : 'gj']], opts = { expr = true } },
    ['k']      = { [[v:count || mode(1)[0:1] == 'no' ? 'k' : 'gk']], opts = { expr = true } },
    ['<Up>']   = { [[v:count || mode(1)[0:1] == 'no' ? 'k' : 'gk']], opts = { expr = true } },
    ['<Down>'] = { [[v:count || mode(1)[0:1] == 'no' ? 'j' : 'gj']], opts = { expr = true } },

    ['<Leader>']  = { name = '  Custom' },
    ['<Leader>t'] = { name = '  Toggle' },
  },

  t = {
    ["<C-x>"] = { termcodes "<C-\\><C-N>", "   escape terminal mode" },
  },

  v = {
    ['J'] = { [[:move .+1<CR>==]], '  move selected text' },
    ['K'] = { [[:move .-2<CR>==]], '  move selected text' },

    ['j']      = { [[v:count || mode(1)[0:1] == 'no' ? 'j' : 'gj']], opts = { expr = true } },
    ['k']      = { [[v:count || mode(1)[0:1] == 'no' ? 'k' : 'gk']], opts = { expr = true } },
    ['<Up>']   = { [[v:count || mode(1)[0:1] == 'no' ? 'k' : 'gk']], opts = { expr = true } },
    ['<Down>'] = { [[v:count || mode(1)[0:1] == 'no' ? 'j' : 'gj']], opts = { expr = true } },

    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
    ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', opts = { silent = true } },
  },

  x = {
    ['J'] = { [[:move '>+1<CR>gv-gv]], '  move selected text' },
    ['K'] = { [[:move '<-2<CR>gv-gv]], '  move selected text' },
  }

}

M.clear_case = {
  n = {
    ['<Leader>c'] = '  ClearTool',
    ['<Leader>co'] = { '<cmd> !ct co -nc %<CR>',   '  checkout file' },
    ['<Leader>cu'] = { '<cmd> !ct unco -rm %<CR>', '  undo checkout' },
    ['<Leader>ci'] = { '<cmd> !ct ci -nc %<CR>',   '  checkin file' },
    ['<Leader>cl'] = { '<cmd> !ct lsact -l<CR>',   '  list activities' },
  }
}

local tele = require('plugins.telescope.builtins').tele_func
M.telescope = {
  n = {
    ['<Leader>f']  = { name = '  Find Files' },

    -- Dotfiles
    ['<leader>fn'] = { tele('edit_neovim'),       '  Neovim files' },
    ['<leader>fp'] = { tele('installed_plugins'), '  installed Plugins' },

    -- Files
    ['<leader>ff'] = { tele('fd'),                        '  Files' },
    ['<leader>fa'] = { tele('search_all_files'),          '  All files' },
    ['<leader>ft'] = { tele('search_only_certain_files'), '  certain file types' },
    ['<leader>fo'] = { tele('oldfiles'),                  'ﭯ  old files' },

    -- grep Word
    ['<leader>fg'] = { tele('live_grep'),               '縷 Grep files' },
    ['<leader>fw'] = { tele('grep_string'),             '  grep Word on Cursor' },
    ['<leader>fl'] = { tele('grep_last_search'),        '  grep Last word' },
    ['<leader>fc'] = { tele('grep_only_certain_files'), '  grep certain file type' },

    -- Nvim
    ['<Leader>n']  = { name = '  NeoVim' },
    ['<leader>nb'] = { tele('buffers'),           '  opened Buffers' },
    ['<leader>n/'] = { tele('cur_buf_fzy_find'),  '  /pattern' },
    ['<leader>nh'] = { tele('help_tags'),         'ﲉ  neovim Help' },
    ['<leader>no'] = { tele('vim_options'),       'הּ  neovim Options' },
    ['<leader>nm'] = { tele('man_pages'),         '龎 man Pages' },
    ["<leader>n'"] = { tele('marks'),             '  Marks' },
    ['<leader>n"'] = { tele('registers'),         '  Registers' },

    -- Telescope
    ['<leader>n<leader>'] = { tele('builtin'), '  Telescope' },
  },

  c = {
    ['<c-r><c-r>'] = { '<Plug>(TelescopeFuzzyCommandSearch)', '  cmd fuzzy search' }
  }
}

-- git
local signs = require('gitsigns')
M.git = {
  n = {
    ['<Leader>g'] = { name = '  Git' },

    -- Neogit
    ['<Leader>gg'] = { '<cmd> Neogit <CR>', '  Neogit'},

    -- fugitive
    ['<Leader>gf'] = { '<cmd> Git <CR>',   '  Git'},
    ['<Leader>gl'] = { '<cmd> GcLog  <CR>','ﰗ  git Log'},

    -- git signs
    ['<leader>gs'] = { function() signs.stage_hunk() end,      '  Stage hunk' },
    ['<leader>gu'] = { function() signs.undo_stage_hunk() end, '  Unstage hunk' },
    ['<leader>gr'] = { function() signs.reset_hunk() end,      '  Reset hunk' },
    ['<leader>gS'] = { function() signs.stage_buffer() end,    '  Stage buffer' },
    ['<leader>gR'] = { function() signs.reset_buffer() end,    '  Reset buffer' },
    ['<leader>gp'] = { function() signs.preview_hunk() end,    '響 Preview hunk' },
    ['<leader>gd'] = { function() signs.diffthis() end,        '者 Diff this' },
    ['<leader>gb'] = { function ()
      signs.blame_line {
        full=true,
        ignore_whitespace=true
      } end,
      '  Blame hunk'
    },

    -- toggle
    ['<leader>tb'] = { function() signs.toggle_current_line_blame() end, '  git Blame' },
    ['<leader>td'] = { function() signs.toggle_deleted() end,            'ﴗ  git show Deleted' },

    [']c'] = {
      function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() signs.next_hunk() end)
        return '<Ignore>'
      end,
      '  next hunk'
    },
    ['[c'] = {
      function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() signs.prev_hunk() end)
        return '<Ignore>'
      end,
      '  prev hunk'
    },
  },

  v = {
    ['<Leader>g'] = { name = '  Git' },

    -- git signs
    ['<leader>gs'] = { function() signs.stage_hunk() end,      '  Stage hunk' },
    ['<leader>gu'] = { function() signs.undo_stage_hunk() end, '  Unstage hunk' },
    ['<leader>gr'] = { function() signs.reset_hunk() end,      '  Reset hunk' },
  }
}

-- lsp
M.lspconfig = {
  n = {
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    ['<Leader>l'] = { name = '  LSP' },
    ['<Leader>ld'] = { tele('lsp_defs'), '  go to Definition' },
    ['<Leader>lr'] = { tele('lsp_refs'), '  find References' },
    ['<Leader>li'] = { tele('lsp_impl'), '  find Implementation' },
    ['<Leader>lg'] = { tele('lsp_global_symbols'), '  find Global symbols' },
    ['<Leader>lD'] = {
      function() vim.lsp.buf.declaration() end,
      '  go to Declaration'
    },
    ['<Leader>ln'] = {
      function() vim.lsp.buf.rename() end,
      '  reName references'
    },
    ['<Leader>lk'] = {
      function() vim.lsp.buf.hover() end,
      '  display symbol information'
    },
    ['<Leader>lK'] = {
      function() vim.lsp.buf.signature_help() end,
      '  display signature help'
    },
    ['<Leader>lF'] = {
      function() vim.lsp.buf.formatting() end,
      '  Format code'
    },

    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    ['<Leader>e'] = { name = '  Error Diagnostics' },
    ['<Leader>ee'] = {
      function() vim.diagnostic.open_float() end,
      '  show Error diagnostic'
    },
    ['<Leader>ek'] = {
      function() vim.diagnostic.goto_prev({ border = "rounded" }) end,
      '  prev error'
    },
    ['<Leader>ej'] = {
      function() vim.diagnostic.goto_next({ border = "rounded" }) end,
      '  next error'
    },
    ['<Leader>el'] = {
      function() vim.diagnostic.setloclist() end,
      '  List error diagnostic'
    },
    ['<Leader>ed'] = { tele('diagnostic'), '  Diagnostics finder' },
    ['<Leader>te'] = {
      function()
        if toggle_diags then
          toggle_diags = false
          vim.diagnostic.disable()
        else
          toggle_diags = true
          vim.diagnostic.enable()
        end
      end,
      '  Error diagnostic'
    },
  }

}

M.nvimtree = {
   n = {
      -- toggle
      ['<C-n>'] = { '<cmd> NvimTreeToggle <CR>', '   toggle nvimtree' },

      -- focus
      ['<leader>,'] = { '<cmd> NvimTreeFocus <CR>', '   focus nvimtree' },
   },
}

M.bufferline = {
  n = {
    ['<Leader>bb'] = { '<cmd> BufferLinePick <CR>',        '  list buffer, then select' },

    -- cycle through buffers
    ['<TAB>']   = { '<cmd> BufferLineCycleNext <CR>', '  goto next buffer' },
    ['<S-Tab>'] = { '<cmd> BufferLineCyclePrev <CR>', '  goto prev buffer' },

    -- jump to buffer pos
    ['<Leader>b0'] = { '<cmd> lua require("bufferline").go_to_buffer(1, true) <CR>',  '0  goto 1st buffer' },
    ['<Leader>b$'] = { '<cmd> BufferLineGoToBuffer -1 <CR>',                          '$  goto last buffer' },

    -- move buffers
    ['<Leader>bl'] = { '<cmd> BufferLineMoveNext <CR>', '  move buffer right' },
    ['<Leader>bh'] = { '<cmd> BufferLineMovePrev <CR>', '  move buffer left' },

    -- sort buffer
    ['<Leader>be'] = { '<cmd> BufferLineSortByExtension <CR>', '  sort by extension' },
    ['<Leader>bs'] = { '<cmd> BufferLineSortByDirectory <CR>', '  sort by directory' },
  }
}

M.nvterm = {
  t = {
    -- toggle in terminal mode
    ['<A-i>'] = {
      function()
        require('nvterm.terminal').toggle 'float'
      end,
      '   toggle floating term',
    },

    ['<A-h>'] = {
      function()
        require('nvterm.terminal').toggle 'horizontal'
      end,
      '   toggle horizontal term',
    },

    ['<A-v>'] = {
      function()
        require('nvterm.terminal').toggle 'vertical'
      end,
      '   toggle vertical term',
    },
  },

  n = {
    -- toggle in normal mode
    ['<A-i>'] = {
      function()
        require('nvterm.terminal').toggle 'float'
      end,
      '   toggle floating term',
    },

    ['<A-h>'] = {
      function()
        require('nvterm.terminal').toggle 'horizontal'
      end,
      '   toggle horizontal term',
    },

    ['<A-v>'] = {
      function()
        require('nvterm.terminal').toggle 'vertical'
      end,
      '   toggle vertical term',
    },

    -- new
    ['<leader>h'] = {
      function()
        require('nvterm.terminal').new 'horizontal'
      end,
      '   new horizontal term',
    },

    ['<leader>v'] = {
      function()
        require('nvterm.terminal').new 'vertical'
      end,
      '   new vertical term',
    },
  },
}

M.neoclip ={
  n = {
    ['<Leader>nn'] = { '<cmd> Telescope neoclip <CR>', '  neoclip'},
    ['<Leader>nr'] = { ':Telescope neoclip ', '  neoclip -> register'}
  },

  i = {
    ['<C-n>'] = { '<cmd> Telescope neoclip <CR>', '  neoclip'},
  }

}

M.hlslens_tmp = {
  n = {
    ['n']  = { [[:execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], '', opts = opts1 },
    ['N']  = { [[:execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], '', opts = opts1 },
    ['*']  = { [[*<Cmd>lua require('hlslens').start()<CR>]],  '', opts = opts1},
    ['#']  = { [[#<Cmd>lua require('hlslens').start()<CR>]],  '', opts = opts1},
    ['g*'] = { [[g*<Cmd>lua require('hlslens').start()<CR>]], '', opts = opts1},
    ['g#'] = { [[g#<Cmd>lua require('hlslens').start()<CR>]], '', opts = opts1},

    ['<Leader>*'] = {
      [[<cmd>let @/='\<'.expand('<cword>').'\>'<bar>set hlsearch<CR><Cmd>lua require('hlslens').start()<CR>]],
      '  search word on cursor',
    },
  }
}

M.others = {
  n = {
    -- indent_line
    ['<Leader>ti'] = { '<cmd> IndentBlanklineToggle! <CR>', '  indent blank line' },

    -- autopairs
    ['<Leader>tu'] = {
      function()
        if toggle_pairs then
          toggle_pairs = false
          require('nvim-autopairs').disable()
        else
          toggle_pairs = true
          require('nvim-autopairs').enable()
        end
      end,
      '  aUto pairs'
    },

    -- packer
    ['\\\\'] = { '<cmd> source ~/.config/nvim/lua/plugins/packer.lua | PackerSync <CR>', '  Packer Sync' },
  },

  i = {
    -- autopairs
    ['<C-u>'] = {
      function()
        if toggle_pairs then
          toggle_pairs = false
          require('nvim-autopairs').disable()
        else
          toggle_pairs = true
          require('nvim-autopairs').enable()
        end
      end,
      '  aUto pairs'
    },
  }
}


return M
