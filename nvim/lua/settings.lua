HOME = os.getenv("HOME")
vim.g.mapleader = " "

-- basic/misc settings
vim.o.encoding = "utf-8"
vim.o.hidden = true                         -- change buffer w/o saving
vim.o.mouse = 'a'                           -- enable mouse
vim.o.history = 1000                        -- save cmd history
vim.o.backspace = "indent,eol,start"        -- backspace works on every char in insert mode
vim.o.completeopt = 'menuone,noselect'      -- insert mode completion list options
vim.o.dictionary = '/usr/share/dict/words'  -- dictionary file
vim.o.shortmess = 'aWF'

-- display settings
vim.o.wrap = false                  -- do not wrap long lines onto next
vim.o.scrolloff = 2                 -- leave lines above & below cursor
vim.o.synmaxcol = 300               -- stop syntax highlight after x lines for performance
vim.o.laststatus = 2                -- always show status line
vim.o.foldenable = false            -- don't auto fold when file is opened
vim.o.foldlevel = 4                 -- limit folding to 4 levels
-- vim.o.foldmethod = 'syntax'         -- use language syntax to generate folds
-- vim.o.foldmethod = 'indent'         -- use language syntax to generate folds
vim.o.splitbelow = true             -- open horiz splits below
vim.o.splitright = true             -- open vert splits to the right

-- status line
vim.o.showmode = false      -- always display mode (insert, visual, etc.)
vim.o.showcmd = true        -- show cmd on bottom line

-- auto completion
vim.o.wildmenu = true                   -- cmd line completion
vim.o.wildignorecase = true             -- auto complete w/o case sensitivity
vim.o.wildmode = 'longest:full,full'
vim.o.wildignore = '*/build/*,*.bak'    -- don't auto complete these patters

-- mapping timeout
vim.o.timeout = false
vim.o.ttimeout = true
vim.o.ttimeoutlen = 100

-- searching
vim.o.incsearch = true      -- find pattern as you type
vim.o.ignorecase = true     -- ignore case when searching
vim.o.smartcase = true      -- stop ignorecase when caps are used
vim.o.hlsearch = true       -- highlight all prev and next search patterns

-- white characters
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.expandtab = true              -- convert tabs to spaces
vim.o.tabstop = 4                   -- set tab space to 4
vim.o.shiftwidth = 4                -- shift line by 4 spaces (<< and >>)
vim.o.list = true                   -- how tab, eol, & trail chars
vim.o.listchars = 'tab:▸ ,trail:●' -- char to show for tab and trail
vim.o.showbreak= '↪'                -- character to show when line is broken

-- backup files
vim.o.backup = true                             -- use backup files
vim.o.swapfile = false                          -- no swap files created
vim.o.undodir = HOME .. '/.vim/tmp/undo//'      -- undo file location
vim.o.backupdir = HOME .. '/.vim/tmp/backup//'  -- backup location

-- tags
-- set tags+=/u/pgutierr/Projects/Qualcomm/thor/drivers/thorTags/tags
-- vim.o.tags = './tags;,tags,~/tags/tags-unison,~/tags/tags-methods,~/tags/tags-plugins'
vim.cmd[[ set tags+=~/tags/tags-unison,~/tags/tags-methods,~/tags/tags-plugins ]]

-- set ruby path -> improves startup time
-- vim.g.ruby_path = '/usr/share/gems/gems/abrt-0.0.6/lib,/usr/share/rubygems,/usr/share/ruby,/usr/lib64/ruby/'
vim.g.ruby_path = ''

-- PLUGINGS --

-- lsp


--```lua
--  Commands:
--  - ClangdSwitchSourceHeader: Switch between source/header
--  
--  Default Values:
--    capabilities = default capabilities, with offsetEncoding utf-8
--    cmd = { "clangd" }
--    filetypes = { "c", "cpp", "objc", "objcpp" }
--    root_dir = root_pattern("compile_commands.json", "compile_flags.txt", ".git") or dirname
--    single_file_support = true
--```


-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- local opts = { noremap=true, silent=true }
-- vim.api.nvim_set_keymap('n', '<Leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
-- vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<Leader>el', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
-- 
-- -- Use an on_attach function to only map the following keys
-- -- after the language server attaches to the current buffer
-- local on_attach = function(client, bufnr)
--   -- Enable completion triggered by <c-x><c-o>
--   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
-- 
--   -- Mappings.
--   -- See `:help vim.lsp.*` for documentation on any of the below functions
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
-- end

-- nerd commenter
vim.g.NERDSpaceDelims = 1           -- adds space between comment & char
vim.g.NERDDefaultAlign = 'left'     -- flush single line comments
vim.g.NERDCommentEmptyLines = 1     -- comment empty lines

-- indent blankline
vim.g.indent_blankline_char = '┊'

-- AutoPairs
-- let g:AutoPairsShortcutToggle = '<another key>'
-- vim.g.AutoPairsShortcutToggle = '<Leader>pp'
