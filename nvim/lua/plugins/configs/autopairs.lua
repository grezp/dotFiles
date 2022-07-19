local status_ok, autopairs = pcall(require, 'nvim-autopairs')

if not status_ok then
  vim.notify('nvim-autopairs not found!')
  return
end

autopairs.setup({
  disable_filetype = { "TelescopePrompt" },
  -- disable when recording or executing a macro
  disable_in_macro = false,
 -- disable when insert after visual block mode
  disable_in_visualblock = false,
  ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]],"%s+", ""),
  enable_moveright = true,
  -- add bracket pairs after quote
  enable_afterquote = true,
  -- check bracket in same line
  enable_check_bracket_line = true,
  enable_bracket_in_quote = true,
  -- run treesitter
  check_ts = true,
  -- map the <CR> key
  map_cr = true,
  -- map the <BS> key
  map_bs = true,
  -- Map the <C-h> key to delete a pair
  map_c_h = false,
 -- map <c-w> to delete a pair if possible
  map_c_w = false,
})

