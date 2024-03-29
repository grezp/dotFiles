local status_ok, hlslens = pcall(require, 'hlslens')

if not status_ok then
  vim.notify('hlslens not found!')
  return
end

hlslens.setup({
  -- Enable nvim-hlslens automatically
  auto_enable = true,

  -- When `incsearch` option is on and enable_incsearch is true, add lens
  -- for the current matched instance]
  enable_incsearch =  true,

  -- When the cursor is out of the position range of the matched instance
  -- and calm_down is true, clear all lens
  calm_down = false,

  -- Only add lens for the nearest matched instance and ignore others
  nearest_only = true,

  -- When to open the floating window for the nearest lens.
  --  'auto': floating window will be opened if room isn't enough for virtual text;
  --  'always': always use floating window instead of virtual text;
  --  'never': never use floating window for the nearest lens
  nearest_float_when = 'never',

  -- Winblend of the nearest floating window. `:h winbl` for more details
  float_shadow_blend = 50,

  -- Priority of virtual text, set it lower to overlay others.
  -- `:h nvim_buf_set_extmark` for more details
  virt_priority = 100,

  -- Hackable function for customizing the lens. If you like hacking, you
  --   should search `override_lens` and inspect the corresponding source code.
  --   There's no guarantee that this function will not be changed in the future. If it is
  --   changed, it will be listed in the CHANGES file.
  --   @param bufnr (number) buffer number
  --   @param splist (table) (1,1)-indexed position
  --   @param nearest (boolean) whether nearest lens
  --   @param idx (number) nearest index in the plist
  --   @param relIdx (number) relative index, negative means before current position,
  --          positive means after
  override_lens = function(render, posList, nearest, idx, relIdx)
    local sfw = vim.v.searchforward == 1
    local indicator, text, chunks
    local absRelIdx = math.abs(relIdx)
    if absRelIdx > 1 then
      indicator = ('%d%s'):format(absRelIdx, sfw ~= (relIdx > 1) and '▲' or '▼')
    elseif absRelIdx == 1 then
      indicator = sfw ~= (relIdx == 1) and '▲' or '▼'
    else
      indicator = ''
    end

    local lnum, col = unpack(posList[idx])
    if nearest then
      local cnt = #posList
      if indicator ~= '' then
        text = ('[%s %d/%d]'):format(indicator, idx, cnt)
      else
        text = ('[%d/%d]'):format(idx, cnt)
      end
      chunks = {{' ', 'Ignore'}, {text, 'HlSearchLensNear'}}
    else
      text = ('[%s %d]'):format(indicator, idx)
      chunks = {{' ', 'Ignore'}, {text, 'HlSearchLens'}}
    end
    render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
  end
})

