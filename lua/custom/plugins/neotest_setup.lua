local M = {}

-- Variable to keep the current state of the --keepdb flag
M.keepdb_enabled = true

function M.toggle_keepdb()
  M.keepdb_enabled = not M.keepdb_enabled
  M.setup_neotest()
  print('KeepDB is now ' .. (M.keepdb_enabled and 'enabled' or 'disabled'))
  M.close_neotest_windows()
  require('lazy').reload { plugins = { 'neotest' } }
end
-- Function to close Neotest summary and output panels
function M.close_neotest_windows()
  local lib = require 'neotest.lib'
  -- Close the output window
  local output_win = lib.windows.output.get_win_id()
  if output_win and vim.api.nvim_win_is_valid(output_win) then
    vim.api.nvim_win_close(output_win, true)
  end
  -- Close the summary window
  local summary_win = lib.windows.summary.get_win_id()
  if summary_win and vim.api.nvim_win_is_valid(summary_win) then
    vim.api.nvim_win_close(summary_win, true)
  end
end
function M.setup_neotest()
  require('neotest').setup {
    adapters = {
      require 'neotest-python' {
        args = {
          '--interactive',
          'False',
          M.keepdb_enabled and '--keepdb',
        },
      },
    },
  }
end

return M
