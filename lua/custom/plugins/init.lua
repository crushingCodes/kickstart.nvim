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
  { 'tpope/vim-obsession' },
  { 'tpope/vim-sleuth' },
  -- {
  --   'rmagatti/auto-session',
  --   opts = {
  --     auto_session_enabled = false,
  --     auto_session_root_dir = vim.fn.stdpath 'data' .. '/sessions/',
  --     auto_save_enabled = true,
  --     auto_restore_enabled = true,
  --     auto_session_suppress_dirs = nil,
  --     auto_session_allowed_dirs = nil,
  --     auto_session_create_enabled = true,
  --     auto_session_enable_last_session = false,
  --     auto_session_use_git_branch = false,
  --     auto_restore_lazy_delay_enabled = true,
  --     log_level = 'error',
  --   },
  --   config = function()
  --     require('auto-session').setup {
  --       log_level = 'error',
  --       -- restore_upcoming_session = false,
  --       auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
  --       -- auto_session_allowed_dirs = { '~/git/*' },
  --       auto_session_suppress_filetypes = { 'octo', 'sql', 'dbout' },
  --       -- post_restore_cmds = { 'Octo pr reload' },
  --       pre_save_cmds = {
  --         -- 'Neotree close',
  --         -- 'DBUIClose',
  --         -- 'DiffviewClose',
  --       },
  --     }
  --   end,
  -- },
  {
    'pocco81/auto-save.nvim',
    opts = {
      condition = function(buf)
        local fn = vim.fn
        local utils = require 'auto-save.utils.data'

        if fn.getbufvar(buf, '&modifiable') == 1 and utils.not_in(fn.getbufvar(buf, '&filetype'), { 'octo', 'sql', 'python', 'gdscript' }) then
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
      -- local api = require 'typescript-tools.api'
      require('typescript-tools').setup {
        settings = {
          handlers = {
            -- ['textDocument/publishDiagnostics'] = api.filter_diagnostics(
            --   -- Ignore 'This may be converted to an async function' diagnostics.
            --   function(diagnostics)
            --     print(vim.inspect(diagnostics))
            --   end
            --   -- { 80006 }
            -- ),
          },
          separate_diagnostic_server = false,
          expose_as_code_action = {
            'add_missing_imports',
            'remove_unused_imports',
            'organize_imports',
          },
          tsserver_file_preferences = {
            importModuleSpecifierPreference = 'non-relative',
            importModuleSpecifierEnding = 'minimal',
          },
          -- CodeLens
          -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
          -- possible values: ("off"|"all"|"implementations_only"|"references_only")
          -- code_lens = 'implementations_only',

          -- tsserver_file_preferences = {
          --   includeInlayParameterNameHints = 'all',
          --   includeCompletionsForModuleExports = true,
          --   quotePreference = 'auto',
          -- },
          jsx_close_tag = {
            enable = true,
            filetypes = { 'javascriptreact', 'typescriptreact' },
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
  -- {
  --   'MeanderingProgrammer/py-requirements.nvim',
  --   dependencies = { 'nvim-lua/plenary.nvim' },
  --   config = function()
  --     require('py-requirements').setup {}
  --   end,
  -- },
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
  { 'kristijanhusak/vim-dadbod-completion' },
  {
    'kristijanhusak/vim-dadbod-ui',
    init = function()
      -- Your DBUI configuration
      --
      vim.g.db_ui_use_nerd_fonts = 1

      vim.g.db_ui_force_echo_notifications = 0
      vim.g.db_ui_use_nvim_notify = 0

      -- ensure the side bar prevents too much indentation
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'dbui',
        callback = function()
          vim.opt_local.shiftwidth = 2
        end,
      })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'dbui',
        callback = function()
          vim.opt_local.cmdheight = 2
        end,
      })
    end,
  },
  { dir = '/Users/gavinboyd/Projects/vim-be-good' },
  { dir = '/Users/personal/Projects/vim-be-good' },
  { 'PeterRincker/vim-argumentative' },
  -- { 'rizzatti/dash.vim' },
  -- {
  --   'stevearc/dressing.nvim',
  --   opts = {},
  -- },
  { 'junegunn/fzf' },
  { 'junegunn/fzf.vim' },
  -- {
  --   'luckasRanarison/nvim-devdocs',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'nvim-telescope/telescope.nvim',
  --     'nvim-treesitter/nvim-treesitter',
  --   },
  --
  --   opts = {
  --     --   previewer_cmd = vim.fn.executable 'glow' == 1 and 'glow' or nil,
  --     --   cmd_args = { '-s', 'dark', '-w', '80' },
  --     --   picker_cmd = true,
  --     --   picker_cmd_args = { '-s', 'dark', '-w', '50' },
  --     --   float_win = { -- passed to nvim_open_win(), see :h api-floatwin
  --     --     relative = 'editor',
  --     --     height = 35,
  --     --     width = 125,
  --     --     border = 'rounded',
  --     --   },
  --     --   after_open = function()
  --     --     -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-\\><C-n>', true, false, true), 'n', true)
  --     --   end,
  --   },
  -- },
  -- {
  --   'mrjones2014/tldr.nvim',
  --   requires = { 'nvim-telescope/telescope.nvim' },
  --   config = function()
  --     require('tldr').setup {
  --       -- the shell command to use
  --       tldr_command = 'tldr',
  --       -- a string of extra arguments to pass to `tldr`, e.g. tldr_args = '--color always'
  --       tldr_args = '',
  --     }
  --   end,
  -- },
  -- TODO: check what duckytype does
  -- {
  --   'kwakzalver/duckytype.nvim',
  --   config = function()
  --     require('duckytype').setup()
  --   end,
  -- },
  -- { 'rhysd/rust-doc.vim' },
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
  -- { 'nvimtools/none-ls.nvim' },
  -- { 'ldelossa/litee.nvim' },
  -- TODO: move this to private repo
  -- { dir = '~/Projects/plugins/neotest-python' },
  -- {
  --   'nvim-neotest/neotest',
  --   dependencies = {
  --     'nvim-neotest/nvim-nio',
  --     'nvim-lua/plenary.nvim',
  --     'antoinemadec/FixCursorHold.nvim',
  --     'nvim-treesitter/nvim-treesitter',
  --     'nvim-neotest/neotest-jest',
  --     -- dir = '~/Projects/plugins/neotest-python',
  --     -- 'nvim-neotest/neotest-python',
  --   },
  --   config = function()
  --     -- require('custom.plugins.neotest_setup').setup_neotest()
  --
  --     require('neotest').setup {
  --       adapters = {
  --         -- require 'neotest-python' {
  --         --   args = { '--keepdb', '--interactive', 'False' },
  --         -- },
  --         require 'neotest-jest' {
  --           jestCommand = 'npm jest --',
  --           jestConfigFile = 'jest.config.ts',
  --           -- env = { CI = true },
  --           cwd = function(path)
  --             return vim.fn.getcwd()
  --           end,
  --         },
  --       },
  --     }
  --   end,
  -- },
  -- { 'ldelossa/gh.nvim' },
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
  --       routes = {
  --         {
  --           view = 'notify',
  --           filter = { event = 'msg_showmode' },
  --         },
  --       },
  --     }
  --     require('telescope').load_extension 'noice'
  --   end,
  -- },
  -- {
  --   dir = '/Users/work/Projects/example-source',
  -- },
  {
    'sindrets/diffview.nvim',
  },
  -- {
  --   'vhyrro/luarocks.nvim',
  --   priority = 1000,
  --   config = true,
  --   opts = {
  --     rocks = { 'lua-curl', 'nvim-nio', 'mimetypes', 'xml2lua' },
  --   },
  -- },
  -- {
  --   'rest-nvim/rest.nvim',
  --   ft = 'http',
  --   dependencies = { 'luarocks.nvim' },
  --   config = function()
  --     require('rest-nvim').setup()
  --   end,
  -- },
  -- { 'folke/lazydev.nvim' },
  {
    'ellisonleao/dotenv.nvim',
    config = function()
      require('dotenv').setup {
        enable_on_load = true, -- will load your .env file upon loading a buffer
        verbose = false, -- show error notification if .env file is not found and if .env is loaded
      }
    end,
  },
  -- { 'mg979/vim-visual-multi' },
  {
    'takac/vim-hardtime',
    config = function()
      -- vim.cmd 'autocmd BufEnter * HardTimeOn'
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  {
    'chrisgrieser/nvim-various-textobjs',
    lazy = false,
    opts = { useDefaultKeymaps = true },
  },
  {
    'obreitwi/vim-sort-folds',
    config = function()
      -- require('vimsortfolds').setup()
    end,
  },
  -- { 'nvim-treesitter/nvim-treesitter-context' },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
    config = function()
      require('ibl').setup()
    end,
  },
  -- {
  --   'ray-x/go.nvim',
  --   dependencies = { -- optional packages
  --     'ray-x/guihua.lua',
  --     'neovim/nvim-lspconfig',
  --     'nvim-treesitter/nvim-treesitter',
  --   },
  --   config = function()
  --     require('go').setup()
  --   end,
  --   event = { 'CmdlineEnter' },
  --   ft = { 'go', 'gomod' },
  --   build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  -- },
  {
    'javiorfo/nvim-ship',
    lazy = true,
    ft = 'ship',
    cmd = { 'ShipCreate', 'ShipCreateEnv' },
    dependencies = {
      'javiorfo/nvim-spinetta',
      'javiorfo/nvim-popcorn',
      'hrsh7th/nvim-cmp', -- nvim-cmp is optional
    },
    opts = {
      -- Not necessary. Only if you want to change the setup.
      -- The following are the default values
      -- view = {
      --   autocomplete = false,
      -- },
      request = {
        timeout = 30,
        autosave = true,
        insecure = false,
      },
      response = {
        show_headers = 'all',
        window_type = 'h',
        --    border_type = require'popcorn.borders'.double_border, -- Only applied for 'p' window_type
        size = 20,
        redraw = true,
      },
      output = {
        save = false,
        override = true,
        folder = 'output',
      },
      internal = {
        log_debug = false,
      },
    },
  },
  -- {
  --   'folke/flash.nvim',
  --   event = 'VeryLazy',
  --   ---@type Flash.Config
  --   opts = {},
  --   -- stylua: ignore
  --   keys = {
  --     { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
  --     { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
  --     { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
  --     { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  --     { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
  --   },
  -- },
  {
    {
      'antosha417/nvim-lsp-file-operations',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-neo-tree/neo-tree.nvim',
      },
      config = function()
        require('lsp-file-operations').setup()
      end,
    },
  },
  -- {
  --   'MunifTanjim/prettier.nvim',
  --
  --   config = function()
  --     local prettier = require 'prettier'
  --
  --     prettier.setup {
  --       bin = 'prettier', -- or `'prettierd'` (v0.23.3+)
  --       filetypes = {
  --         'css',
  --         'graphql',
  --         'html',
  --         'javascript',
  --         'javascriptreact',
  --         'json',
  --         'less',
  --         'markdown',
  --         'scss',
  --         'typescript',
  --         'typescriptreact',
  --         'yaml',
  --       },
  --     }
  --   end,
  -- },
  { 'onsails/lspkind.nvim' },
  { 'habamax/vim-godot', event = 'VimEnter' },
  {
    'utilyre/barbecue.nvim',
    name = 'barbecue',
    version = '*',
    dependencies = {
      'SmiteshP/nvim-navic',
      'nvim-tree/nvim-web-devicons', -- optional dependency
    },
    opts = {
      -- configurations go here
    },
    config = function()
      require('barbecue').setup()
    end,
  },
  {
    'lewis6991/satellite.nvim',
    config = function()
      require('satellite').setup {
        current_only = false,
        winblend = 50,
        zindex = 40,
        excluded_filetypes = {},
        width = 2,
        handlers = {
          cursor = {
            enable = true,
            -- Supports any number of symbols
            symbols = { '⎺', '⎻', '⎼', '⎽' },
            -- symbols = { '⎻', '⎼' }
            -- Highlights:
            -- - SatelliteCursor (default links to NonText
          },
          search = {
            enable = true,
            -- Highlights:
            -- - SatelliteSearch (default links to Search)
            -- - SatelliteSearchCurrent (default links to SearchCurrent)
          },
          diagnostic = {
            enable = true,
            signs = { '-', '=', '≡' },
            min_severity = vim.diagnostic.severity.ERROR,
            -- Highlights:
            -- - SatelliteDiagnosticError (default links to DiagnosticError)
            -- - SatelliteDiagnosticWarn (default links to DiagnosticWarn)
            -- - SatelliteDiagnosticInfo (default links to DiagnosticInfo)
            -- - SatelliteDiagnosticHint (default links to DiagnosticHint)
          },
          gitsigns = {
            enable = true,
            signs = { -- can only be a single character (multibyte is okay)
              add = '│',
              change = '│',
              delete = '-',
            },
            -- Highlights:
            -- SatelliteGitSignsAdd (default links to GitSignsAdd)
            -- SatelliteGitSignsChange (default links to GitSignsChange)
            -- SatelliteGitSignsDelete (default links to GitSignsDelete)
          },
          marks = {
            enable = true,
            show_builtins = false, -- shows the builtin marks like [ ] < >
            key = 'm',
            -- Highlights:
            -- SatelliteMark (default links to Normal)
          },
          quickfix = {
            signs = { '-', '=', '≡' },
            -- Highlights:
            -- SatelliteQuickfix (default links to WarningMsg)
          },
        },
      }
    end,
  },
  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>cs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>cl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },
  {
    'zapling/mason-lock.nvim',
    -- :MasonLock Creates a lockfile that includes all currently installed packages
    -- :MasonLockRestore Re-installs all packages with the version specified in the lockfile
    config = function()
      require('mason-lock').setup {
        lockfile_path = vim.fn.stdpath 'config' .. '/mason-lock.json', -- (default)
      }
      -- lockfile_path =
      --   vim.fn.stdpath 'config' .. '/mason-lock.json', -- (default)
      --   print 'lockfile_path'
      -- print(lockfile_path)
    end,
  },
}
