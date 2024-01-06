-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'Shatur/neovim-ayu',
    config = function()
      require('ayu').setup {}
      vim.cmd.colorscheme 'ayu-dark'
    end,
    priority = 1000,
  },
  {
    'nvim-tree/nvim-tree.lua',
    config = true,
    opts = function()
      return require '.custom.plugins.configs.nvim-tree'
    end,
  },
  { 'nvim-tree/nvim-web-devicons' },
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    config = function()
      require('typescript-tools').setup {
        settings = {
          --separate_diagnostic_server = false,
          expose_as_code_action = {
            'add_missing_imports',
            'remove_unused_imports',
            'organize_imports',
          },
          tsserver_file_preferences = {
            importModuleSpecifierPreference = 'non-relative',
            importModuleSpecifierEnding = 'minimal',
          },
        },
      }
    end,
  },
  { 'tpope/vim-dadbod' },
  { 'kristijanhusak/vim-dadbod-ui' },
  {
    'jose-elias-alvarez/null-ls.nvim',
    opts = function()
      return require 'custom.plugins.configs.null-ls'
    end,
  },
  -- TODO: get it to load commands
  -- {
  --   'mrjones2014/legendary.nvim',
  --   -- since legendary.nvim handles all your keymaps/commands,
  --   -- its recommended to load legendary.nvim before other plugins
  --   priority = 10002,
  --   lazy = false,
  --   -- sqlite is only needed if you want to use frecency sorting
  --   dependencies = { 'kkharji/sqlite.lua', 'stevearc/dressing.nvim', 'folke/which-key.nvim', 'folke/lazy.nvim' },
  --   config = function()
  --     local wk = require 'which-key'
  --     wk.setup()
  --     local legendary = require 'legendary'
  --     legendary.setup {
  --       lazy_nvim = {
  --         auto_register = true,
  --       },
  --       which_key = {
  --         auto_register = true,
  --         -- do_binding = false,
  --         -- controls whether to use legendary.nvim item groups
  --         -- matching your which-key.nvim groups; if false, all keymaps
  --         -- are added at toplevel instead of in a group.
  --         use_groups = true,
  --       },
  --       extensions = {
  --         nvim_tree = true,
  --         diffview = true,
  --       },
  --     }
  --   end,
  -- },
  {
    'prochri/telescope-all-recent.nvim',
    priority = 10001,
    dependencies = { 'kkharji/sqlite.lua' },
    config = function()
      require('telescope-all-recent').setup {
        -- your config goes here
      }
    end,
  },
  {
    'LintaoAmons/easy-commands.nvim',
    event = 'VeryLazy',
    config = function()
      require('easy-commands').setup {
        disabledCommands = { 'CopyFilename' }, -- You can disable the commands you don't want

        aliases = {                            -- You can have a alias to a specific command
          { from = 'GitListCommits', to = 'GitLog' },
        },

        -- It always welcome to send me back your good commands and usecases
        ---@type EasyCommand.Command[]
        myCommands = {
          -- You can add your own commands
          {
            name = 'MyCommand',
            callback = 'lua vim.print("easy command user command")',
            description = 'A demo command definition',
          },
          -- You can overwrite the current implementation
          {
            name = 'EasyCommand',
            callback = 'lua vim.print("Overwrite easy-command builtin command")',
            description = 'The default implementation is overwrited',
          },
          -- You can use the utils provided by the plugin to build your own command
          {
            name = 'JqQuery',
            callback = function()
              local sys = require 'easy-commands.impl.util.base.sys'
              local editor = require 'easy-commands.impl.util.editor'

              vim.ui.input({ prompt = 'Query pattern, e.g. `.[] | .["@message"].message`' }, function(pattern)
                local absPath = editor.buf.read.get_buf_abs_path()
                local stdout, _, stderr = sys.run_sync({ 'jq', pattern, absPath }, '.')
                local result = stdout or stderr
                editor.split_and_write(result, { vertical = true })
              end)
            end,
            description = 'use `jq` to query current json file',
          },
        },
      }
    end,
  },
  {
    -- This is used with
    'stevearc/dressing.nvim',
    opts = {},
  },
  { 'sindrets/diffview.nvim' },
}
