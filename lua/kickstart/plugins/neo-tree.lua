-- Function to add file to Telescope's recent files
-- function Add_to_telescope_history(file)
--   local telescope_builtin = require 'telescope.builtin'
--   -- Use Telescope's history file path
--   local history_path = vim.fn.stdpath 'data' .. '/telescope_frecency.sqlite3'
--   print('history_path: ', history_path)
--   local cmd = string.format('sqlite3 %s "INSERT OR IGNORE INTO frecency (path, count) VALUES (\'%s\', 1);"', history_path, file)
--   os.execute(cmd)
-- end

-- function Add_to_recent_files(file)
--   -- local sql_wrapper = require 'telescope-all-recent.sql_wrapper'
--   local all_recent = require 'telescope-all-recent.default'
--   all_recent.pickers
--   local default_config = require 'telescope-all-recent.default'
--   local db_path = vim.fn.stdpath 'data' .. '/' .. default_config.database.file
--   print('db_path: ', db_path)
--   -- sql_wrapper.in(self, entry)
--   -- sql_wrapper.add_file(file, db_path)
-- end

-- function Add_to_recent_files(file, cwd)
--   local frecency = require 'telescope-all-recent.frecency'
--   local picker = { name = 'find_files', cwd = cwd }
--   frecency.update_entry(picker, file)
-- end

-- function Get_stashes()
--   local stashes = vim.fn.systemlist 'git stash list'
--   local formatted_stashes = {}
--
--   for i, stash in ipairs(stashes) do
--     local name = stash:match 'stash@{%d+}: (.+)'
--     table.insert(formatted_stashes, { name = name, index = i - 1 })
--   end
--
--   return formatted_stashes
-- end
--
-- function Get_stash_nodes()
--   local nodes = {}
--   local stashes = get_stashes()
--
--   for _, stash in ipairs(stashes) do
--     table.insert(nodes, {
--       name = stash.name,
--       path = tostring(stash.index),
--       type = 'file',
--       id = 'stash_' .. stash.index,
--     })
--   end
--
--   return nodes
-- end
return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    -- dir = '/Users/work/Projects/plugins/example-source',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' } },
    n = 'copy_selector',
    -- Y = 'hello',
  },
  config = function()
    require('neo-tree').setup {
      sources = {
        'filesystem',
        'buffers',
        'git_status',
        -- 'example', -- <-- external sources need to be a fully qualified path to the module
        -- 'prfiles', -- <-- external sources need to be a fully qualified path to the module
        --"my.name.example" <-- Feel free to add to your folder structure to create a namespace,
        -- The name of the source will be the last part, or whatever your module
        -- exports as the `name` field.
        -- 'stashes',
      },
      -- prfiles = {
      --   window = {
      --     mappings = {
      --       ['D'] = 'show_diff',
      --     },
      --   },
      -- },
      -- stashes = {
      --   follow_current_file = true,
      --   window = {
      --     position = 'left',
      --     width = 40,
      --   },
      -- },
      filesystem = {
        use_libuv_file_watcher = true,
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer every time
          --               -- the current file is changed while the tree is open.
          leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
        window = {
          mappings = {
            ['\\'] = 'close_window',
            Y = 'copy_selector',
            ['<space>'] = 'noop',
            --   {
            --   nil,
            --   -- 'toggle_node',
            --   -- nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
            -- },
            ['e'] = 'noop',
          },
        },
      },
      commands = {
        copy_selector = function(state)
          local node = state.tree:get_node()
          local filepath = node:get_id()
          local filename = node.name
          local modify = vim.fn.fnamemodify

          local vals = {
            ['BASENAME'] = modify(filename, ':r'),
            ['FILENAME'] = filename,
            ['PATH (CWD)'] = modify(filepath, ':.'),
            ['PATH (HOME)'] = modify(filepath, ':~'),
            ['PATH'] = filepath,
            ['EXTENSION'] = modify(filename, ':e'),
            ['URI'] = vim.uri_from_fname(filepath),
          }

          local options = vim.tbl_filter(function(val)
            return vals[val] ~= ''
          end, vim.tbl_keys(vals))
          if vim.tbl_isempty(options) then
            vim.notify('No values to copy', vim.log.levels.WARN)
            return
          end
          table.sort(options)
          vim.ui.select(options, {
            prompt = 'Choose to copy to clipboard:',
            format_item = function(item)
              return ('%s: %s'):format(item, vals[item])
            end,
          }, function(choice)
            local result = vals[choice]
            if result then
              vim.notify(('Copied: `%s`'):format(result))
              vim.fn.setreg('+', result)
            end
          end)
        end,
      },
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
            -- Import necessary modules

            -- -- Configure Neo-tree to trigger the function on file open
            -- vim.cmd [[
            -- augroup NeoTreeTelescopeIntegration
            --     autocmd!
            --     autocmd BufEnter * if &filetype ==# 'neo-tree' | autocmd BufEnter * lua Add_to_telescope_history(vim.fn.expand("<afile>")) | endif
            -- augroup END
            -- ]]
            --
          end,
        },
        -- {
        --   event = 'file_open_requested',
        --   handler = function(args)
        --     local state = args.state
        --     local path = args.path
        --     -- local open_cmd = args.open_cmd or "edit"
        --
        --     -- Determine the relative path
        --     local relative_path = vim.fn.fnamemodify(path, ':.' .. state.path)
        --     Add_to_recent_files(relative_path, state.path)
        --   end,
        -- },
      },
    }
  end,
}
