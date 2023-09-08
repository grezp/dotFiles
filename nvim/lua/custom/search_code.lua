local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local conf = require('telescope.config').values
local make_entry = require 'telescope.make_entry'
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'
local M = {}

PROJECTS = 'U1909_SPR_seti'
local seti_projects = {
  'ASLX_VS1250_seti',
  'CURI_seti',
  'ITE2_2_X_seti',
  'LICENSING_TOOLS_seti',
  'R15_7_X_seti',
  'R15_8_X_seti',
  'SETI_2011_seti',
  'TRANSLATE_AND_REPORT_seti',
  'U1703_seti',
  'U1709_CPHY_seti',
  'U1709_OLT_seti',
  'U1709_seti',
  'U1803_seti',
  'U1809_seti',
  'U1909_BOBCAT_seti',
  'U1909_CONTAINERS_seti',
  'U1909_FPD2_seti',
  'U1909_FPVI2_seti',
  'U1909_HSI2XD_seti',
  'U1909_HSI2XTTR_seti',
  'U1909_PMICTTR_seti',
  'U1909_PMIC_seti',
  'U1909_PMIC_VI100_GEST_seti',
  'U1909_PORTMUX_seti',
  'U1909_RDBASE_seti',
  'U1909_RDCTR_seti',
  'U1909_RDIF_seti',
  'U1909_RFTTR_seti',
  'U1909_RF_seti',
  'U1909_seti',
  'U1909_SPR_seti',
  'U1909_TESTIP_seti',
  'U2023_seti',
  'U2109_seti',
  'U4_2_X_seti',
  'U4_3_X_seti',
  'U4_4_X_seti',
  'U4_X_seti',
  'U5_1_X_seti',
  'U5_2_X_seti',
  'UNISON_TOOLS_LINUX_NEXT_seti',
  'UNISON_TOOLS_seti',
  'UNISON_TOOLS_SPR_seti',
  'UNISON_TOOLS_TPGEN_seti',
  'UNISON_TOOLS_WS_seti',
  'UTL_seti',
}

local escape_chars = function(string)
  return string.gsub(string, '[%(|%)|\\|%[|%]|%-|%{%}|%?|%+|%*|%^|%$|%.]', {
    ['\\'] = '\\\\',
    ['-'] = '\\-',
    ['('] = '\\(',
    [')'] = '\\)',
    ['['] = '\\[',
    [']'] = '\\]',
    ['{'] = '\\{',
    ['}'] = '\\}',
    ['?'] = '\\?',
    ['+'] = '\\+',
    ['*'] = '\\*',
    ['^'] = '\\^',
    ['$'] = '\\$',
    ['.'] = '\\.',
  })
end

local sc_output = function(pattern)

  local cmd = 'sc -p %s %s'
  local proj = PROJECTS
  cmd = string.format(cmd, proj, pattern)
  local string = vim.fn.system(cmd)

  -- place each line into table
  local data = {}
  for x in string:gmatch('.-[\r\n]') do
    -- remove last char in sc '\'
    x = x:sub(1, -2)
    table.insert(data, x)
  end

  return data
end

local sc_input = function()
  local prompt = 'Search Code Pattern: '
  return vim.fn.input(prompt)
end


-- ===========================================================================
M.pick_seti_proj = function(opts)
-- Choose seti project
-- ===========================================================================
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = 'Pick SETI Project',
    finder = finders.new_table {
      results = seti_projects
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
     actions.select_default:replace(function()
       actions.close(prompt_bufnr)
       PROJECTS = action_state.get_selected_entry()[1]
     end)
     return true
   end,
  }):find()
end

-- ===========================================================================
M.search_code = function(opts)
-- use 'sc' algo to search clear case projects
-- search can be done by current highlighted word
-- or user input can be entered to search pattern
-- ===========================================================================
  opts = opts or {}
  local vimgrep_arguments = conf.vimgrep_arguments
  local word = vim.fn.expand '<cword>'
  local search = escape_chars(word)

  -- ask for user input
  if opts.sc_input then
    search = sc_input()
    word = search
  end
  local file_list = sc_output(search)

  search = { '--', search }
  local args = vim.tbl_flatten {
    vimgrep_arguments,
    search,
    file_list,
  }

  opts.entry_maker = opts.entry_maker or make_entry.gen_from_vimgrep(opts)
  local finder = finders.new_oneshot_job(args, opts)

  -- if file_list is emply display nothing
  if next(file_list) == nil then
    finder = finders.new_table {
      results = {}
    }
  end

  pickers
    .new(opts, {
      prompt_title = 'sc (' .. word:gsub('\n', '\\n') .. ') in ' .. PROJECTS,
      finder = finder,
      previewer = conf.grep_previewer(opts),
      sorter = conf.generic_sorter(opts),
    })
    :find()
end
-- REDDRAGONVerifySystemEvm

return M
