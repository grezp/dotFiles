local map_tele = require('plugins.telescope.builtins').map_tele
local keymap = require('core.utils').keymap

keymap('c', '<c-r><c-r>', '<Plug>(TelescopeFuzzyCommandSearch)')

-- Dotfiles
map_tele('<leader>fn', 'edit_neovim')
map_tele('<leader>fp', 'installed_plugins')

-- Files
map_tele('<leader>ff', 'fd')
map_tele('<leader>fa', 'search_all_files')
map_tele('<leader>ft', 'search_only_certain_files')
map_tele('<leader>fo', 'oldfiles')

-- grep Word
map_tele('<leader>fg', 'live_grep')
map_tele('<leader>fw', 'grep_string')
map_tele('<leader>fl', 'grep_last_search')
map_tele('<leader>ft', 'grep_only_certain_files')

-- Nvim
map_tele('<leader>nb', 'buffers')
map_tele('<leader>n/', 'current_buffer_fuzzy_find')
map_tele('<leader>nh', 'help_tags')
map_tele('<leader>nv', 'vim_options')
map_tele('<leader>nm', 'man_pages')
map_tele("<leader>n'", 'marks')
map_tele('<leader>n"', 'registers')

-- Telescope Meta
map_tele('<leader>n<leader>', 'builtin')

-- extensions
-- map_tele('<leader>fs', 'bookmarks')
