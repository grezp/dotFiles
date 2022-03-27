local ls = require "luasnip"
local types = require "luasnip.util.types"

-- s(<trigger>, <nodes>)
local s = ls.s

-- format node.
-- takes a format string, and a list of nodes
-- fmt(<fmt_string>, {...nodes})
local fmt = require("luasnip.extras.fmt").fmt

-- insert node
-- takes a position (like $1) and optionally some default text
-- i(<position>, [default_text])
local i = ls.insert_node

-- table node
local t = ls.text_node

-- Repeats a node
-- rep(<position>)
local rep = require("luasnip.extras").rep

-- choice snippet. You can move through with <c-l>
--  c(1, { t {"hello"}, t {"world"}, }),
--
-- The first argument is the jump position
-- The second argument is a table of possible nodes.
--  Note, one thing that's nice is you don't have to include
--  the jump position for nodes that normally require one (can be nil)
local c = ls.choice_node

-- load vscode style snippets (rafamadriz/friendly-snippets)
require("luasnip.loaders.from_vscode").lazy_load()

ls.config.set_config {
  -- This tells LuaSnip to remember to keep around the last snippet.
  -- You can jump back into it even if you move outside of the selection
  history = true,

  -- This one is cool cause if you have dynamic snippets, it updates as you type!
  updateevents = "TextChanged,TextChangedI",

  -- Autosnippets:
  -- enable_autosnippets = true,

  -- highlights
  -- ext_opts = nil,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { " <- Current Choice", "NonTest" } },
      },
    },
  },
}


ls.snippets = {
  all = {
  },

  lua = {
    -- examples
    -- ls.parser.parse_snippet('expand', '-- this is comment'),
    -- ls.parser.parse_snippet('lf', 'local $1 = function($2)\n  $0\nend')
    -- s('req', fmt("local {} = require('{}')", { i(1, 'default'), rep(1)}))
  }
}




-- <c-k> expansion key
-- expand the current item or jump to the next item within the snippet.
vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

-- <c-j> jump backwards key.
-- moves to the previous item within the snippet
vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

-- <c-l> selecting within a list of options.
-- this is useful for choice nodes
vim.keymap.set("i", "<c-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

vim.keymap.set("i", "<c-u>", require "luasnip.extras.select_choice")
