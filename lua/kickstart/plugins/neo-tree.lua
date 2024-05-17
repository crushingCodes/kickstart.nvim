-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' } },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
  config = function()
    require('neo-tree').setup {
      close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
      auto_clean_after_session_restore = true, -- Automatically clean up broken neo-tree buffers saved in sessions
      event_handlers = {
        {
          event = 'before_render',
          handler = function(state)
            -- add something to the state that can be used by custom components
          end,
        },
        {
          event = 'file_opened',
          handler = function(file_path)
            --auto close
            require('neo-tree.command').execute { action = 'close' }
          end,
        },
      },
    }
  end,
}
