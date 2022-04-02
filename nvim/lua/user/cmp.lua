local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  vim.notify('cmp not found!')
  return
end

-- nerdfond icons
-- more here: https://www.nerdfonts.com/cheat-sheet
local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "ﰠ",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "塞",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "פּ",
  Event = "",
  Operator = "",
  TypeParameter = ""
}

cmp.setup {
  -- configure mappings
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<tab>'] = cmp.config.disable,
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
  },

  -- these are like cmp 'plugins'
  -- order signifies which completions are shown first
  sources = {
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer', keyword_length = 5 },
  },

  -- shows where autocomplete is comming from
  formatting = {
    fields = { "abbr", "kind", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        luasnip = "[Snipet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },

  -- sorting = {
  --   comparators = {
  --     cmp.config.compare.offset,
  --     cmp.config.compare.exact,
  --     cmp.config.compare.score,
  --     cmp.recently_used,
  --
  --     -- copied from cmp-under, but I don't think I need the plugin for this.
  --     function(entry1, entry2)
  --       local _, entry1_under = entry1.completion_item.label:find '^_+'
  --       local _, entry2_under = entry2.completion_item.label:find '^_+'
  --       entry1_under = entry1_under or 0
  --       entry2_under = entry2_under or 0
  --       if entry1_under > entry2_under then
  --         return false
  --       elseif entry1_under < entry2_under then
  --         return true
  --       end
  --     end,
  --
  --     cmp.config.compare.kind,
  --     cmp.config.compare.sort_text,
  --     cmp.config.compare.length,
  --     cmp.config.compare.order,
  --   },
  -- },

  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },

  window = {
    completion = {
      border = 'rounded',
      -- scrollbar = '║',
      scrollbar = 'x',
    },

    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
  },

  experimental = {
    ghost_text = true,
  },
}

-- search setup
-- /@ look for function and var defs
cmp.setup.cmdline('/', {
  sources = cmp.config.sources(
  { name = 'nvim_lsp_document_symbol' },
  {{
    name = 'buffer',
    max_item_count = 20,
    keyword_length = 3,
  }})
})
