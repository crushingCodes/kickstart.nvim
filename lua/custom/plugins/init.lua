-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
--

-- See the kickstart.nvim README for more information
return {
  { 'tpope/vim-surround' },
  { 'tpope/vim-abolish' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-unimpaired' },
  -- { 'tpope/vim-obsession' },
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration
      -- Only one of these is needed, not both.
      'nvim-telescope/telescope.nvim', -- optional
      -- "ibhagwan/fzf-lua",              -- optional
    },
    -- config = true,
    -- Configure the event hooks
    config = function()
      hooks = {
        require('neogit').setup {

          post_status_buffer_close = function()
            -- Refresh all buffers when the Neogit status buffer is closed
            vim.cmd 'checktime'
          end,
        },
      }
    end,
  },
  {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup {
        log_level = 'error',
        -- restore_upcoming_session = false,
        auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
        -- auto_session_allowed_dirs = { '~/git/*' },
        auto_session_suppress_filetypes = { 'octo', 'sql', 'dbout' },
        -- post_restore_cmds = { 'Octo pr reload' },
        pre_save_cmds = {
          -- 'Neotree close',
          -- 'DBUIClose',
          -- 'DiffviewClose',
        },
      }
    end,
  },
  {
    'pocco81/auto-save.nvim',
    opts = {
      condition = function(buf)
        local fn = vim.fn
        local utils = require 'auto-save.utils.data'

        if fn.getbufvar(buf, '&modifiable') == 1 and utils.not_in(fn.getbufvar(buf, '&filetype'), { 'octo', 'sql', 'python' }) then
          return true -- met condition(s), can save
        end
        return false -- can't save
      end,
    },
  },
  { 'nvim-lua/plenary.nvim' },
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    config = function()
      require('typescript-tools').setup {
        settings = {
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
  {
    'stevanmilic/nvim-lspimport',
    config = function()
      vim.keymap.set('n', '<leader>a', require('lspimport').import, { noremap = true })
      vim.keymap.set('n', '<leader>li', require('lspimport').import, { noremap = true, desc = 'Python import' })
    end,
  },
  {
    'MeanderingProgrammer/py-requirements.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('py-requirements').setup {}
    end,
  },
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
    opts = {
      -- Your options go here
      -- name = "venv",
      auto_refresh = false,
    },
    branch = 'regexp', -- This is the regexp branch, use this for the new version
    event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    keys = {
      -- Keymap to open VenvSelector to pick a venv.
      { '<leader>v', '<cmd>VenvSelect<cr>' },
      -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
      -- { '<leader>vv', '<cmd>VenvSelectCached<cr>' },
    },
  },
  {
    'tpope/vim-fugitive',
  },
  { 'tpope/vim-dadbod' },
  { 'kristijanhusak/vim-dadbod-ui' },
  -- TODO: get this to work
  -- { 'kristijanhusak/vim-dadbod-completion' },
  { dir = '/Users/gavinboyd/Projects/vim-be-good' },
  { 'PeterRincker/vim-argumentative' },
  { 'rizzatti/dash.vim' },
  {
    'stevearc/dressing.nvim',
    opts = {},
  },
  { 'junegunn/fzf' },
  { 'junegunn/fzf.vim' },
  {
    'luckasRanarison/nvim-devdocs',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-treesitter/nvim-treesitter',
    },

    opts = {
      --   previewer_cmd = vim.fn.executable 'glow' == 1 and 'glow' or nil,
      --   cmd_args = { '-s', 'dark', '-w', '80' },
      --   picker_cmd = true,
      --   picker_cmd_args = { '-s', 'dark', '-w', '50' },
      --   float_win = { -- passed to nvim_open_win(), see :h api-floatwin
      --     relative = 'editor',
      --     height = 35,
      --     width = 125,
      --     border = 'rounded',
      --   },
      --   after_open = function()
      --     -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-\\><C-n>', true, false, true), 'n', true)
      --   end,
    },
  },
  {
    'mrjones2014/tldr.nvim',
    requires = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require('tldr').setup {
        -- the shell command to use
        tldr_command = 'tldr',
        -- a string of extra arguments to pass to `tldr`, e.g. tldr_args = '--color always'
        tldr_args = '',
      }
    end,
  },
  {
    'kwakzalver/duckytype.nvim',
    config = function()
      require('duckytype').setup()
    end,
  },
  { 'rhysd/rust-doc.vim' },
  {
    'danielfalk/smart-open.nvim',
    branch = '0.2.x',
    config = function()
      require('telescope').load_extension 'smart_open'
    end,
    dependencies = {
      'kkharji/sqlite.lua',
      -- Only required if using match_algorithm fzf
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      -- Optional.  If installed, native fzy will be used when match_algorithm is fzy
      { 'nvim-telescope/telescope-fzy-native.nvim' },
    },
  },
  { 'nvimtools/none-ls.nvim' },
  { 'ldelossa/litee.nvim' },
  -- TODO: move this to private repo
  -- { dir = '~/Projects/plugins/neotest-python' },
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-jest',
      -- dir = '~/Projects/plugins/neotest-python',
      -- 'nvim-neotest/neotest-python',
    },
    config = function()
      -- require('custom.plugins.neotest_setup').setup_neotest()

      require('neotest').setup {
        adapters = {
          -- require 'neotest-python' {
          --   args = { '--keepdb', '--interactive', 'False' },
          -- },
          require 'neotest-jest' {
            jestCommand = 'npm jest --',
            jestConfigFile = 'jest.config.ts',
            -- env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          },
        },
      }
    end,
  },
  { 'ldelossa/gh.nvim' },
  -- {
  --   'folke/noice.nvim',
  --   event = 'VeryLazy',
  --   opts = {
  --     -- add any options here
  --   },
  --   dependencies = {
  --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --     'MunifTanjim/nui.nvim',
  --     -- OPTIONAL:
  --     --   `nvim-notify` is only needed, if you want to use the notification view.
  --     --   If not available, we use `mini` as the fallback
  --     'rcarriga/nvim-notify',
  --   },
  --   config = function()
  --     require('noice').setup {
  --       lsp = {
  --         -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
  --         override = {
  --           ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
  --           ['vim.lsp.util.stylize_markdown'] = true,
  --           ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
  --         },
  --       },
  --       -- you can enable a preset for easier configuration
  --       presets = {
  --         bottom_search = true, -- use a classic bottom cmdline for search
  --         command_palette = true, -- position the cmdline and popupmenu together
  --         long_message_to_split = true, -- long messages will be sent to a split
  --         inc_rename = false, -- enables an input dialog for inc-rename.nvim
  --         lsp_doc_border = false, -- add a border to hover docs and signature help
  --       },
  --     }
  --   end,
  -- },
  -- {
  --   dir = '/Users/work/Projects/example-source',
  -- },
  {
    'sindrets/diffview.nvim',
  },
  {
    'vhyrro/luarocks.nvim',
    priority = 1000,
    config = true,
    opts = {
      rocks = { 'lua-curl', 'nvim-nio', 'mimetypes', 'xml2lua' },
    },
  },
  {
    'rest-nvim/rest.nvim',
    ft = 'http',
    dependencies = { 'luarocks.nvim' },
    config = function()
      require('rest-nvim').setup()
    end,
  },
  { 'folke/lazydev.nvim' },
  {
    'ellisonleao/dotenv.nvim',
    config = function()
      require('dotenv').setup {
        enable_on_load = true, -- will load your .env file upon loading a buffer
        verbose = false, -- show error notification if .env file is not found and if .env is loaded
      }
    end,
  },
  { 'mg979/vim-visual-multi' },
  { 'kevinhwang91/promise-async' },
  { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' },
  { 'takac/vim-hardtime' },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  {
    'chrisgrieser/nvim-various-textobjs',
    lazy = false,
    opts = { useDefaultKeymaps = true },
  },
  { 'obreitwi/vim-sort-folds' },
  { 'nvim-treesitter/nvim-treesitter-context' },
}
