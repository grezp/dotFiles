-- basic/misc settings
vim.o.encoding = 'utf-8'
vim.o.hidden = true                         -- change buffer w/o saving
vim.o.mouse = 'a'                           -- enable mouse
vim.o.history = 1000                        -- save cmd history
vim.o.backspace = 'indent,eol,start'        -- backspace works on every char in insert mode
vim.o.dictionary = '/usr/share/dict/words'  -- dictionary file
vim.o.shortmess = 'aWF'

-- display settings
vim.o.wrap = false                  -- do not wrap long lines onto next
vim.o.scrolloff = 2                 -- leave lines above & below cursor
vim.o.synmaxcol = 300               -- stop syntax highlight after x lines for performance
vim.o.laststatus = 2                -- always show status line
vim.o.splitbelow = true             -- open horiz splits below
vim.o.splitright = true             -- open vert splits to the right

-- status line
vim.o.showmode = false      -- always display mode (insert, visual, etc.)
vim.o.showcmd = true        -- show cmd on bottom line

-- auto completion
vim.o.wildmenu = true                   -- cmd line completion
vim.o.wildignorecase = true             -- auto complete w/o case sensitivity
vim.o.wildmode = 'longest:full'         -- complete longest string, then start wildmenu
vim.o.wildignore = '*/build/*,*.bak'    -- don't auto complete these patters
vim.o.completeopt = 'menu,menuone,noselect' -- use popup menu, use popup for 1 match, don't select match in menu

-- mapping timeout
vim.o.timeout = true
vim.o.timeoutlen = 500

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

-- folding
vim.o.foldenable = false            -- don't auto fold when file is opened
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.fillchars = 'fold:-'
vim.o.foldnestmax = 10

-- reformats folds to be fix indentation + {...}
function _G.custom_fold_text()
  local line_count = vim.v.foldend - vim.v.foldstart + 1
  local line = vim.fn.getline(vim.v.foldstart)

  -- trim trailing white space
  for _=1, string.len(line) do
    if line:sub(-1) == ' ' then
      line = line:sub(1, -2)
    else break
    end
  end

  -- append curly bracket on last char
  if line:sub(-1) ~= '{' then
    line = line .. ' {'
  end

  return line .. '...} : ' .. line_count .. ' lines '
end
vim.o.foldtext = 'v:lua.custom_fold_text()'

-- set ruby path -> improves startup time
-- vim.g.ruby_path = '/usr/share/gems/gems/abrt-0.0.6/lib,/usr/share/rubygems,/usr/share/ruby,/usr/lib64/ruby/'
vim.g.ruby_path = ''

-- -- setup global tags
-- function file_exists(name)
--    local f=io.open(name,'r')
--    if f~=nil then io.close(f) return true else return false end
-- end
--
-- local l_tags = ''
-- if file_exists(HOME .. '/tags/tags-unison')  then l_tags = l_tags .. ',' .. HOME .. '/tags/tags-unison,'  end
-- if file_exists(HOME .. '/tags/tags-methods') then l_tags = l_tags .. ',' .. HOME .. '/tags/tags-methods,' end
-- if file_exists(HOME .. '/tags/tags-plugins') then l_tags = l_tags .. ',' .. HOME .. '/tags/tags-plugins,' end
-- vim.o.tags = vim.o.tags .. l_tags

