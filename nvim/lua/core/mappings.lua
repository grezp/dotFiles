local toggle_diags = true
local toggle_pairs = true

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
    ['<ESC>']     = { '<cmd> noh <CR>', '  no highlight' },
    ['<Leader>o'] = { 'o<ESC>',         '  new line below' },
    ['<Leader>O'] = { 'o<ESC>',         '  new line above' },

    -- system file
    ['<Leader>s'] = { '<cmd> w <CR>',  '  saves current file'},
    ['<Leader>q'] = { '<cmd> q <CR>',  '  exit window'},
    ['<Leader>Q'] = { '<cmd> q! <CR>', '  exit window'},

    -- buffers
    ['<Leader>b']  = { name = '  Buffers' },
    ['<Leader>bb'] = { '<cmd> ls <CR><cmd> buffer<Space>', '  list buffer, then select' },
    ['<Leader>bl'] = { '<cmd> ls<CR>',                     '  list buffer' },
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
    ['<Leader>*'] = { [[<cmd>let @/='\<'.expand('<cword>').'\>'<bar>set hlsearch<CR>]], '  search word on cursor' },
    -- keep prev copy in buffer 0
    ["p"] = { '"_dP', opts = { silent = true } },
    ['<Leader>ts'] = { '<cmd> set list!<CR>', '  white Space' },

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
M.git = {
  n = {
    ['<Leader>g'] = { name = '  Git' },

    -- Neogit
    ['<Leader>gg'] = { '<cmd> Neogit <CR>', 'Neogit'},

    -- fugitive
    ['<Leader>gf'] = { '<cmd> Git <CR>',   'Git'},
    ['<Leader>gl'] = { '<cmd> GcLog  <CR>','git Log'},

    -- git signs
    ['<leader>gs'] = { require('gitsigns').stage_hunk,      '  Stage hunk' },
    ['<leader>gu'] = { require('gitsigns').undo_stage_hunk, '  Unstage hunk' },
    ['<leader>gr'] = { require('gitsigns').reset_hunk,      '  Reset hunk' },
    ['<leader>gS'] = { require('gitsigns').stage_buffer,    '  Stage buffer' },
    ['<leader>gR'] = { require('gitsigns').reset_buffer,    '  Reset buffer' },
    ['<leader>gp'] = { require('gitsigns').preview_hunk,    '響 Preview hunk' },
    ['<leader>gd'] = { require('gitsigns').diffthis,        '者 Diff this' },
    ['<leader>gb'] = { function ()
      require"gitsigns".blame_line {
        full=true,
        ignore_whitespace=true
      } end,
      '  Blame hunk'
    },

    -- toggle
    ['<leader>tb'] = { require('gitsigns').toggle_current_line_blame, '  git Blame' },
    ['<leader>td'] = { require('gitsigns').toggle_deleted,            'ﴗ  git show Deleted' },

    [']c'] = {
      function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() require('gitsigns').next_hunk() end)
        return '<Ignore>'
      end,
      '  next hunk'
    },
    ['[c'] = {
      function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() require('gitsigns').prev_hunk() end)
        return '<Ignore>'
      end,
      '  prev hunk'
    },
  },

  v = {
    ['<Leader>g'] = { name = '  Git' },

    -- git signs
    ['<leader>gs'] = { require('gitsigns').stage_hunk,      '  Stage hunk' },
    ['<leader>gu'] = { require('gitsigns').undo_stage_hunk, '  Unstage hunk' },
    ['<leader>gr'] = { require('gitsigns').reset_hunk,      '  Reset hunk' },
  }
}


-- lsp
M.lspconfig = {
  n = {
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    ['<Leader>l'] = { name = '  LSP' },
    ['<Leader>ld'] = { tele('lsp_defs'), '  go to Definition' },
    ['<Leader>lr'] = { tele('lsp_refs'), '  find References' },
    ['<Leader>li'] = { tele('lsp_impl'), '  find Implementation' },
    ['<Leader>lg'] = { tele('lsp_global_symbols'), '  find Global symbols' },
    ['<Leader>lD'] = {
      function() vim.lsp.buf.declaration() end,
      '  go to Declaration'
    },
    ['<Leader>ln'] = {
      function() vim.lsp.buf.rename() end,
      '  reName references'
    },
    ['<Leader>lk'] = {
      function() vim.lsp.buf.hover() end,
      '  display symbol information'
    },
    ['<Leader>lK'] = {
      function() vim.lsp.buf.signature_help() end,
      '  display signature help'
    },
    ['<Leader>lF'] = {
      function() vim.lsp.buf.formatting() end,
      '  Format code'
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
