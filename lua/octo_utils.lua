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

local function run_command(command, callback)
  local stdout = vim.loop.new_pipe(false)
  local stderr = vim.loop.new_pipe(false)

  local handle
  local function on_exit()
    vim.schedule(function()
      stdout:read_stop()
      stderr:read_stop()
      stdout:close()
      stderr:close()
      handle:close()
    end)
  end

  handle = vim.loop.spawn(
    command[1],
    {
      args = command[2],
      stdio = { stdout, stderr },
    },
    vim.schedule_wrap(function()
      on_exit()
    end)
  )

  local output = {}
  local function on_read(err, data)
    if err then
      print('ERROR: ', err)
    end
    if data then
      table.insert(output, data)
    end
  end

  stdout:read_start(on_read)
  stderr:read_start(on_read)

  vim.loop.spawn(
    command[1],
    {
      args = command[2],
      stdio = { stdout, stderr },
    },
    vim.schedule_wrap(function()
      callback(table.concat(output, ''))
    end)
  )
end

local function format_results(title, results)
  return '## ' .. title .. '\n' .. results .. '\n'
end

function M.show_overview()
  local repo = M.get_current_repo()
  if repo == '' then
    print 'Current repository could not be determined.'
    return
  end

  local buffer_content = ''

  local function on_complete()
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(buffer_content, '\n'))
    vim.api.nvim_set_current_buf(buf)
  end

  run_command({ 'gh', { 'pr', 'list', '--author', '@me', '--repo', repo } }, function(output)
    buffer_content = buffer_content .. format_results('Pull Requests Created by Me', output)
    run_command({ 'gh', { 'pr', 'list', '--review-requested', '@me', '--repo', repo } }, function(output)
      buffer_content = buffer_content .. format_results('Review Requested Pull Requests', output)
      run_command({ 'gh', { 'pr', 'list', '--repo', repo, '--state', 'open' } }, function(output)
        buffer_content = buffer_content .. format_results('All Open Pull Requests', output)
        on_complete()
      end)
    end)
  end)
end

return M
