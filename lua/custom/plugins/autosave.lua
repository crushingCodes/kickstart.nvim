return {
  -- 'pocco81/auto-save.nvim',
  'okuuva/auto-save.nvim',
  cmd = 'ASToggle', -- optional for lazy loading on command
  event = { 'InsertLeave', 'TextChanged' }, -- optional for lazy loading on trigger events
  opts = {
    -- execution_message = {
    --   enabled = false,
    -- },
    condition = function(buf)
      local fn = vim.fn
      local utils = require 'auto-save.utils.data'

      if fn.getbufvar(buf, '&modifiable') == 1 and utils.not_in(fn.getbufvar(buf, '&filetype'), { 'octo', 'sql', 'python', 'gdscript' }) then
        return true -- met condition(s), can save
      end
      return false -- can't save
    end,
  },
}
