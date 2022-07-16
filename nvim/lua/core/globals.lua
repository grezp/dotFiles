
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

