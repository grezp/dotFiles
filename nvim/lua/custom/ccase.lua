local M = {}
local fn = vim.fn

-- ===========================================================================
local get_file_path = function(fname)
-- Determine full path name of the clearcase element:
-- ---------------------------------------------------------------------------
  if fname == nil or fname == '' then
    fname = fn.resolve(fn.expand('%:p'))
  else
    fname = fn.resolve(fname)
  end

  return fname
end

-- ===========================================================================
local is_cc_element = function(fname)
-- Check if the file is a clearcase element or not:
-- ---------------------------------------------------------------------------
  local fname_and_ver = fn.system('cleartool des -s -cview ' .. fname)

  if not string.find(fname_and_ver, '@@') then
    vim.api.nvim_echo({{
        'This buffer does not contain clearcase element.',
        'Error',
      }}, true, {}
    )
    return false
  end

  return true
end

-- ===========================================================================
M.CtShowViewName = function()
-- Show the name of the current clearcase view.
-- ---------------------------------------------------------------------------
  -- Get current clearcase view name:
  local view_name = fn.system('cleartool pwv')

  local dir_str = '^Working directory view: \\(.\\{-}\\)\\n.*'
  local dir_view = fn.substitute(view_name, dir_str, '\\1', '')

  local view_str = '.*Set view: \\(.\\{-}\\)\\n'
  local set_view = fn.substitute(view_name, view_str, '\\1', '')

  -- Show the view name:
  vim.api.nvim_echo({{
      'Set view: ' .. set_view .. '\nDirectory view: ' .. dir_view .. '\n\n',
      'Question',
    }}, true, {}
  )
end

-- ===========================================================================
-- function! s:CtAnnotate( fname )
M.CtAnnotate = function(fname)
-- Clearcase annotate the specified/active clearcase element. The reault will
-- be captured in a buffer named "cleartool_annotate".
-- ---------------------------------------------------------------------------

  -- Determine full path name of the clearcase element:
  fname = get_file_path(fname)

  -- Check if the file is a clearcase element or not:
  if not is_cc_element(fname) then
    return false
  end

  -- -- Execute clearcase annotate command, capture output in the
  -- -- "cleartool_annotate" buffer. The '%' symbol should be carefully escaped
  -- -- here, otherwise it will be expanded to the active filename, and mess up
  -- -- the format string totally.
  local cmd = "cleartool annotate -nco -out - -fmt '\\%-8.8u \\%-16.16Vn | ' "
  M.CtCmd(cmd .. fname, 'cleartool_annotate')

  return true
end

-- ===========================================================================
M.CtDiff = function(fname, diff_version)
-- Requires: +diff
-- Do a diff of the given filename with its cleartool predecessor or user
-- specified version. The version to compare with is determined by
-- diff_version:
--   If diff_version begins with '/' or '\', take it as targer version.
--   0: Ask user which version to compare with.
--   1: Compare with the previous version.
--   2: Compare with first version on the current branch.
-- ---------------------------------------------------------------------------

  if not fn.has('diff') then
    vim.api.nvim_echo({{
        'Unable to use console diff function.  Requires +diff compiled in',
        'Error',
      }}, true, {}
    )
    return false
  end

  -- Determine full path name of the clearcase element
  fname = get_file_path(fname)

  -- Determine root of the filename.  Necessary when the file we are editting
  -- already as an '@@' version qualifier.
  local fname_and_ver = fn.system('cleartool des -s -cview ' .. fname)
  fname_and_ver = string.gsub(fname_and_ver, '\n', '')

  -- Check if the file is a clearcase element or not:
  if not is_cc_element(fname) then
    return false
  end

  -- Determine version of the source file:
  local cmp_from_ver = string.gsub(fname_and_ver, '^[^@]*@@', '', 1)
  local cmp_to_ver = nil

  -- check if diff_version is nil
  if diff_version == nil then
    vim.api.nvim_echo({{
        'Version to diff is nil',
        'WarningMsg',
      }}, true, {}
    )
    return false

  -- check if diff_version is comparing file
  ------------------------------------------
  elseif string.find(diff_version, '^[/]') then
    -- The version begins with '/', take it as target version literally:
    cmp_to_ver = diff_version
    print('before input: ' .. cmp_to_ver)

  -- check if diff_version is comparing version num
  -------------------------------------------------
  elseif diff_version == 0 then
    -- cmp_to_ver = ''
    local ver_num = nil
    local prompt_text = 'Give version to compare to: '

    -- While we aren't getting anything, keep prompting
    vim.cmd([[echohl Question]])
    while ver_num == nil do
      ver_num = fn.input(prompt_text)
      print('\n')

      -- this is dumb... but lua doesn't offer many regex ops
      -- check if 1st char is integer
      -- if not, then check if 1st char is 'p'
      -- if not, then check if 1st char is 'q'
      local match = string.find(ver_num, '^%d')
      if not match then
        match = string.find(ver_num, '^p')
      end
      if not match then
        match = string.find(ver_num, '^q')
      end

      if not match then
        ver_num = nil
        vim.api.nvim_echo({{
            'Invalid input. \nEnter an interger or "p". \n"q" to quit',
            'WarningMsg',
          }}, true, {}
        )
      end
    end
    vim.cmd([[echohl None]])

    -- find current version num and remove
    cmp_to_ver = string.gsub(cmp_from_ver, '[^/]*$', '', 1)
    -- append input version num
    cmp_to_ver = cmp_to_ver .. ver_num

    -- Give user a chance to abort
    if ver_num:find('^q') then
      vim.api.nvim_echo({{
          'CCASE diff operation canceled!',
          'WarningMsg',
        }}, true, {}
      )
      return false
    end

    -- If they change their mind and want predecessor, allow that
    if ver_num:find('^p') then
      print('Comparing to predecessor...')
      cmp_to_ver = fn.system('cleartool des -s -pre "' .. fname_and_ver .. '"')

      print('cmp_to_ver: ' .. cmp_to_ver)
    end

  -- check if diff_version is comparing predecessor
  -------------------------------------------------
  elseif diff_version == 1 then
    print('Comparing to predecessor...')
    cmp_to_ver = fn.system('cleartool des -s -pre "' .. fname_and_ver .. '"')

    print('Predecessor version: ' .. cmp_to_ver)

  -- check if diff_version is comparing predecessor
  elseif diff_version == 2 then
    print('Comparing to first version on the current branch ...')

    -- Determine first version on the current branch.
    cmp_to_ver = string.gsub(cmp_from_ver, '[^/]*$', '', 1)
    -- append first version number
    cmp_to_ver = cmp_to_ver .. '0'

    print('First version on current branch: ' .. cmp_to_ver)

  else
      vim.api.nvim_echo({{
          'Cannot determine which version to compare to!',
          'Error',
        }}, true, {}
      )
      return false
  end

  -- Sanity check: Make sure we are not comparing to the same version.
  -- I'm not sure whether we should ignore case or not:
  if string.find(string.lower(cmp_to_ver), string.lower(cmp_from_ver)) then
      vim.api.nvim_echo({{
          'CCASE diff: Compare to the same version, abort!',
          'WarningMsg',
        }}, true, {}
      )
      return false
  end

  -- Strip the file version information out
  fname = string.gsub(fname_and_ver, '@@[^@]*$', '', 1)

  local split = ':vert diffsplit '
  vim.cmd(split .. fname .. '@@' .. cmp_to_ver)

  return true
end

-- ===========================================================================
M.CtCmd = function(cmd_str, name)
-- Execute ClearCase 'cleartool' command, and put the output into a results
-- buffer.
--
-- cmd_string - clearcase shell command to execute, and capture output for
-- ...        - optional scratch buffer name string
-- ===========================================================================
  if cmd_str ~= nil then
    local tmp_file = vim.fn.tempname()

    -- Capture output in a genfn.tempname()ed temp file
    fn.system(cmd_str .. ' > ' .. tmp_file)

    -- overwrite name if not passed
    if name ~= nil then
      name = 'ccase_results'
    end

    -- Now see if a results window is already there
    local bufnr = fn.bufnr(name)
    if bufnr > 0 then
      vim.cmd('bw! ' .. name)
    end

    -- Open a new results buffer, brackets are added here so that no false
    -- positives match in trying to determine l:results_bufno above.
    -- silent exe "topleft new [".l:results_name."]"
    vim.cmd('tab new [' .. name .. ']')
    local ol = vim.opt_local
    ol.modifiable = true

    -- Read in the output from our command
    vim.cmd('0r ' .. tmp_file)

    -- Setup the buffer to be a "special buffer"
    ol.swapfile = false
    ol.buftype = 'nofile'
    ol.bufhidden = 'delete'
    ol.modifiable = false

    -- Get rid of temp file
    fn.system('rm ' .. tmp_file)
  end
end


return M
