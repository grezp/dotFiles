-- local status_ok, telescope = pcall(require, 'telescope')
-- if not status_ok then
--   vim.notify('telescope not found!')
--   return
-- end

local M = {}
local telescope = require('telescope')
local a = require('telescope.actions')

M.setup = function()
  telescope.setup {
    defaults = {

      prompt_prefix = ' ',
      selection_caret = ' ',
      path_display = { 'smart' },
      initial_mode = 'insert',
      selection_strategy = 'reset',
      sorting_strategy = 'ascending',
      layout_strategy = 'bottom_pane',
      winblend = 10,

      layout_config = {
        width = 0.90,
        height = 0.50,

        cursor = {
          width = 0.65,
          height = 0.4,
        },
        horizontal = {
          prompt_position = 'top',
          anchor = 'S',
          mirror = false
        },
      },

      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        -- '--ignore-file=' .. HOME .. '/.fdignore'
      },

      mappings = {
        i = {
          ['<C-n>'] = a.move_selection_next,
          ['<C-p>'] = a.move_selection_previous,

          ['<C-j>'] = a.cycle_history_next,
          ['<C-k>'] = a.cycle_history_prev,

          ['<C-c>'] = a.close,

          ['<Down>'] = a.move_selection_next,
          ['<Up>'] = a.move_selection_previous,

          ['<CR>'] = a.select_default,
          ['<C-x>'] = a.select_horizontal,
          ['<C-v>'] = a.select_vertical,
          ['<C-t>'] = a.select_tab,

          ['<C-u>'] = a.preview_scrolling_up,
          ['<C-d>'] = a.preview_scrolling_down,

          ['<PageUp>'] = a.results_scrolling_up,
          ['<PageDown>'] = a.results_scrolling_down,

          ['<Tab>'] = a.toggle_selection + a.move_selection_worse,
          ['<S-Tab>'] = a.toggle_selection + a.move_selection_better,
          ['<C-q>'] = a.send_to_qflist + a.open_qflist,
          ['<M-q>'] = a.send_selected_to_qflist + a.open_qflist,
          ['<C-l>'] = a.complete_tag,

          ['<C-/>'] = a.which_key,
        },

        n = {
          ['<esc>'] = a.close,
          ['<CR>'] = a.select_default,
          ['<C-x>'] = a.select_horizontal,
          ['<C-v>'] = a.select_vertical,
          ['<C-t>'] = a.select_tab,

          ['<Tab>'] = a.toggle_selection + a.move_selection_worse,
          ['<S-Tab>'] = a.toggle_selection + a.move_selection_better,
          ['<C-q>'] = a.send_to_qflist + a.open_qflist,
          ['<M-q>'] = a.send_selected_to_qflist + a.open_qflist,

          ['j'] = a.move_selection_next,
          ['k'] = a.move_selection_previous,
          ['H'] = a.move_to_top,
          ['M'] = a.move_to_middle,
          ['L'] = a.move_to_bottom,

          ['<Down>'] = a.move_selection_next,
          ['<Up>'] = a.move_selection_previous,
          ['gg'] = a.move_to_top,
          ['G'] = a.move_to_bottom,

          ['<C-u>'] = a.preview_scrolling_up,
          ['<C-d>'] = a.preview_scrolling_down,

          ['<PageUp>'] = a.results_scrolling_up,
          ['<PageDown>'] = a.results_scrolling_down,

          ['?'] = a.which_key,
        },
      },
    },

    pickers = {
      find_files = {
        find_command = {
          "fd",
          "--type",
          "f",
          -- "--strip-cwd-prefix"  -- remove ./ (hidden files)
        },
      }
    },

    extensions = {

      -- 'pattern   -> exact match
      -- ^pattern   -> prefix match
      -- .pattern   -> suffix match
      -- !pattern   -> inverse match
      -- !^pattern  -> inverse prefix match
      -- !.pattern  -> inverse suffix match
      fzf = {
        -- false will only do exact matching
        fuzzy = true,
        -- override the generic sorter
        override_generic_sorter = true,
         -- override the file sorter
        override_file_sorter = true,
        -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
        case_mode = "smart_case",
      },

      bookmarks = {
        -- Available: 'chrome', 'chrome_beta', 'safari', 'firefox'
        selected_browser = 'safari',
        -- Either provide a shell command to open the URL
        url_open_command = 'open',
        -- Or provide the plugin name which is already installed
        -- Available: 'vim_external', 'open_browser'
        url_open_plugin = nil,
        -- Show the full path to the bookmark instead of just the bookmark name
        full_path = true,
        -- Provide a custom profile name for Firefox
        firefox_profile_name = nil,
      },
    },
  }

  -- must be ran after telescope setup
  telescope.load_extension('fzf')
  telescope.load_extension('bookmarks')
end

return M

