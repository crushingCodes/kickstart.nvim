-- Print a message to confirm the script is running
print 'Executing smart-open-weights.lua'

-- Ensure the 'smart_open' extension is loaded
require('telescope').load_extension 'smart_open'

-- Attempt to require the weights module
local status, weights = pcall(require, 'telescope._extensions.smart_open.weights')
if status then
  print 'Successfully loaded weights module'

  -- Override the default_weights
  weights.default_weights = {
    path_fzf = 140,
    path_fzy = 140,
    virtual_name_fzy = 131,
    virtual_name_fzf = 131,
    open = 3,
    alt = 4,
    proximity = 13,
    project = 10,
    frecency = 0,
    -- Try making recency the most important
    recency = 100,
  }
else
  print('Failed to load weights module: ' .. weights)
end
