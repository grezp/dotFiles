
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

-- setup global tags
local file_exists = function (name)
   local f=io.open(name,'r')
   if f~=nil then io.close(f) return true else return false end
end

local l_tags = ''
if file_exists(HOME .. '/tags/tags-unison')  then l_tags = l_tags .. ',' .. HOME .. '/tags/tags-unison,'  end
if file_exists(HOME .. '/tags/tags-methods') then l_tags = l_tags .. ',' .. HOME .. '/tags/tags-methods,' end
if file_exists(HOME .. '/tags/tags-plugins') then l_tags = l_tags .. ',' .. HOME .. '/tags/tags-plugins,' end

-- Neovim options --
--------------------

local options = {
-- basic/misc settings
encoding = 'utf-8',
hidden = true,                         -- change buffer w/o saving
mouse = 'n',                           -- enable mouse
history = 1000,                        -- save cmd history
backspace = 'indent,eol,start',        -- backspace works on every char in insert mode
dictionary = '/usr/share/dict/words',  -- dictionary file
shortmess = 'aWF',

-- display settings
wrap = false,             -- do not wrap long lines onto next
scrolloff = 2,            -- leave lines above & below cursor
synmaxcol = 300,          -- stop syntax highlight after x lines for performance
laststatus = 2,           -- always show status line
splitbelow = true,        -- open horiz splits below
splitright = true,        -- open vert splits to the right
termguicolors = true,     -- 24 bit colors

-- status line
showmode = false,      -- always display mode (insert, visual, etc.)
showcmd = true,        -- show cmd on bottom line

-- auto completion
wildmenu = true,                        -- cmd line completion
wildignorecase = true,                  -- auto complete w/o case sensitivity
wildmode = 'longest:full',              -- complete longest string, then start wildmenu
wildignore = '*/build/*,*.bak',         -- don't auto complete these patters
completeopt = 'menu,menuone,noselect',  -- use popup menu, use popup for 1 match, don't select match in menu

-- mapping timeout
timeout = true,
timeoutlen = 500,

-- searching
incsearch = true,     -- find pattern as you type
ignorecase = true,    -- ignore case when searching
smartcase = true,     -- stop ignorecase when caps are used
hlsearch = true,      -- highlight all prev and next search patterns

-- white characters
autoindent = true,
smartindent = true,
expandtab = true,             -- convert tabs to spaces
tabstop = 4,                  -- set tab space to 4
shiftwidth = 4,               -- shift line by 4 spaces (<< and >>)
list = true,                  -- how tab, eol, & trail chars
listchars = 'tab:▸ ,trail:●', -- char to show for tab and trail
showbreak= '↪',               -- character to show when line is broken

-- backup files
backup = true,                             -- use backup files
swapfile = false,                          -- no swap files created
undodir = HOME .. '/.vim/tmp/undo//',      -- undo file location
backupdir = HOME .. '/.vim/tmp/backup//',  -- backup location

-- folding
foldenable = false,            -- don't auto fold when file is opened
foldmethod = 'expr',
foldexpr = 'nvim_treesitter#foldexpr()',
fillchars = 'fold:-',
foldnestmax = 10,
foldtext = 'v:lua.custom_fold_text()',

-- tags
tags = vim.o.tags .. l_tags,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- set ruby path -> improves startup time
vim.g.ruby_path = ''
