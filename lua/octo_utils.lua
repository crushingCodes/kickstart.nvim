local M = {}

function M.get_current_repo()
  local handle = io.popen 'git remote get-url origin'
  if handle then
    local result = handle:read '*a'
    handle:close()
    local repo = result:match '([^/:]+/[^/]+)%.git'
    return repo or ''
  end
  return ''
end

function M.search_prs(filter)
  local repo = M.get_current_repo()
  if repo ~= '' then
    return vim.cmd('Octo search is:pr ' .. filter .. ' repo:' .. repo)
  else
    return print 'Current repository could not be determined.'
  end
end

return M
