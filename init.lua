--[[
-
=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>lq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>lR', ':LspRestart<CR>', { desc = 'Restart LSP' })

local map = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { desc = desc })
end

-- Toggles
vim.api.nvim_set_keymap('n', '<leader>;a', ':ASToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>;m', ':lua vim.bo.modifiable = not vim.bo.modifiable<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>;w', ':set wrap!<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>;r', ':set relativenumber!<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>;h', ':HardTimeToggle<CR>', { noremap = true, silent = true })

-- Format and Save
-- vim.api.nvim_set_keymap('n', '<leader>w', ':lua vim.lsp.buf.formatting_sync(nil, 1000)<CR>:w<CR>', { noremap = true, silent = true, desc = 'Format & Write' })
-- vim.api.nvim_set_keymap('n', '<leader>w', ':lua vim.lsp.buf.format()<CR>:w<CR>', { noremap = true, silent = true, desc = 'Format & Write' })
-- vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true, silent = true, desc = 'Format & Write' })

-- Format
vim.api.nvim_set_keymap('n', '<leader>f', ':lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true, desc = 'Format' })
local test
vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

-- map('<leader>q', ':q<CR>', '[q]uit')
function Delete_all_buffers()
  vim.cmd '%bd!'
  -- vim.cmd 'SessionSave'
end

map('<leader>bo', ':%bd|e#|bd#<CR>', '[d]elete other buffers')
map('<leader>bd', ':bd<CR>', '[d]elete current buffer')
map('<leader>bD', Delete_all_buffers, '[d]elete all buffers')
map('<leader>bn', ':enew<CR>', '[n]ew buffer')

-- Merge conflicts
-- map('<leader>mm', ':Gdiffsplit!<CR>', 'View [m]erge conflicts')
-- map('<leader>mM', ':Gwrite<CR>', 'Save [M]erge resolution')
-- map('<leader>mc', ':Neotree git_status<CR>', 'Show [c]onflicts in Neotree')
-- map('<leader>mn', ':Neotree git_status<CR>', 'Show [c]onflicts in Neotree')
-- TODO: next and previous conflict

-- if vim.fn.filereadable 'Session.vim' == 1 then
--   -- vim.cmd 'source Session.vim'
-- else
--   -- vim.api.nvim_create_autocmd('VimEnter', { pattern = '*', command = 'Obsession' })
-- end

-- map('<leader>SS', ':Obsess<CR>', 'Create [S]ession')
-- map('<leader>SL', ':source Session.vim<CR>', '[L]oad Session')
-- map('<leader>SD', ':Obsess!<CR>', '[D]elete Session')

-- Function to confirm and undo the last commit
local function confirm_undo_last_commit()
  local confirm = vim.fn.confirm('Are you sure you want to undo the last commit?', '&Yes\n&No', 2)
  if confirm == 1 then
    vim.cmd 'G reset HEAD~1'
  end
end

-- Ensure the function is accessible globally
_G.confirm_undo_last_commit = confirm_undo_last_commit

map('<leader>gU', ':lua confirm_undo_last_commit()<CR>', '[U]ndo last commit')
map('<leader>gH', ':lua require("telescope").extensions.git_file_history.git_file_history()<CR>', 'File History')
map('<leader>gd', ':Gvdiffsplit!<CR>', 'Open [d]iff in 3 way split')

-- Utils for getting file paths
map('<leader>Yr', ':let @*=expand("%")<CR>', '[r]elative file path')
map('<leader>Yp', ':let @*=expand("%:p")<CR>', 'full file [p]ath')
map('<leader>Yn', ':let @*=expand("%:t")<CR>', 'file [n]ame')
map('<leader>Yd', ':let @*=expand("%:p:h")<CR>', 'directory [n]ame')
map('<leader>Yt', ':lua _G.get_test_path()<CR>', 'Python [t]est path')

map('<leader>t/', ':tabnew<CR>|:terminal<CR>', 'New Terminal')
map('<leader>tn', ':tabnew<CR>', '[N]ew Tab')
map('<leader>tq', ':tabclose<CR>', '[Q]uit Tab')

function OpenDbInTab()
  vim.cmd 'tabnew'
  vim.cmd 'DBUIToggle'
end

-- DBUI
vim.keymap.set('n', '<leader>d', '<cmd>lua OpenDbInTab()<cr>', { desc = 'Open Database' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Resizing
vim.keymap.set('n', '<C-Left>', '<C-w><C->>', { desc = 'Increase window size left' })
vim.keymap.set('n', '<C-Right>', '<C-w><C-<>', { desc = 'Increase window size right' })
vim.keymap.set('n', '<C-Down>', '<C-w><C-->', { desc = 'Increase window size down' })
vim.keymap.set('n', '<C-Up>', '<C-w><C-+>', { desc = 'Increase window size up' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --
  --  This is equivalent to:
  --    require('Comment').setup({})

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()
      -- TODO: work out how to get this going
      -- Hydra mode is a special mode that keeps the popup open until you hit <esc>.
      -- require('which-key').show {
      --   keys = '<c-w>',
      --   loop = true, -- this will keep the popup open until you hit <esc>
      -- }

      -- Document existing key chains
      require('which-key').add {
        { '<leader>c', group = 'Code' },
        { '<leader>s', group = 'Search' },
        { '<leader>;', group = 'Toggle' },
        { '<leader>l', group = 'Lsp' },
        { '<leader>b', group = 'Buffers' },
        { '<leader>g', group = 'Git' },
        { '<leader>Y', group = 'Yank' },
        { '<leader>r', group = 'Rest' },
        -- { '<leader>m', group = 'Merge' },
        { '<leader>t', group = 'Tabs' },
        { '<leader>n', group = 'Notes' },
      }
    end,
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
      -- { 'nvim-telescope/telescope-github.nvim' },
      -- { dir = '/Users/work/Projects/plugins/telescope-github.nvim' },
      { 'crushingCodes/telescope-github.nvim' },
      -- {
      --   'ahmedkhalf/project.nvim',
      --   config = function()
      --     require('project_nvim').setup {
      --       manual_mode = true,
      --       patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json', 'requirements.txt', 'pyproject.toml', 'manage.py' },
      --
      --       -- your configuration comes here
      --       -- or leave it empty to use the default settings
      --       -- refer to the configuration section below
      --     }
      --   end,
      -- },
      {
        'isak102/telescope-git-file-history.nvim',
        dependencies = { 'tpope/vim-fugitive' },
      },
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-lua/popup.nvim' },
      { 'jvgrootveld/telescope-zoxide' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      require('telescope').load_extension 'gh'
      require('telescope').load_extension 'zoxide'

      local z_utils = require 'telescope._extensions.zoxide.utils'
      -- require('telescope').load_extension 'projects'
      -- map('<leader>p', ':lua require("telescope").extensions.projects.projects()<CR>', 'Projects')
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!
      --
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        defaults = {
          layout_strategy = 'vertical',
          -- other settings if you have any
          -- vertical = { bottom_pane = {
          --   height = 25,
          --   preview_cutoff = 1000,
          --   prompt_position = 'top',
          -- } },
          path_display = { 'smart' },
        },
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown {},
          },
          zoxide = {
            prompt_title = '[ Walking on the shoulders of TJ ]',
            mappings = {
              default = {
                after_action = function(selection)
                  print('Update to (' .. selection.z_score .. ') ' .. selection.path)
                end,
              },
              ['<C-s>'] = {
                before_action = function(selection)
                  print 'before C-s'
                end,
                action = function(selection)
                  vim.cmd.edit(selection.path)
                end,
              },
              -- Opens the selected entry in a new split
              ['<C-q>'] = { action = z_utils.create_basic_command 'split' },
            },
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- vim.api.nvim_set_keymap('n', '<leader>ca', ':Telescope lsp_code_actions<CR>', { noremap = true, silent = true })

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', function()
        require('telescope.builtin').help_tags()
      end, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', function()
        require('telescope.builtin').keymaps()
      end, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', function()
        require('telescope.builtin').find_files()
      end, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', function()
        require('telescope.builtin').builtin()
      end, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', function()
        require('telescope.builtin').grep_string()
      end, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', function()
        require('telescope.builtin').live_grep()
      end, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', function()
        require('telescope.builtin').diagnostics()
      end, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', function()
        require('telescope.builtin').resume()
      end, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', function()
        require('telescope.builtin').oldfiles()
      end, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', function()
        -- require('telescope.builtin').buffers()
        -- vim.cmd ':Neotree buffers'
        --
        require('telescope').extensions.smart_open.smart_open {
          match_algorithm = 'fzf',
          cwd_only = true,
        }
      end, { desc = '[ ] Find existing buffers' })

      -- Custom
      vim.keymap.set('n', '<leader>e', ':Neotree toggle<cr>', { desc = 'Open filetree' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
  { 'kkharji/sqlite.lua' },
  {
    'prochri/telescope-all-recent.nvim',
    -- priority = 10000,
    codependencies = {
      'nvim-telescope/telescope.nvim',
      'kkharji/sqlite.lua',
      -- optional, if using telescope for vim.ui.select
      -- 'stevearc/dressing.nvim',
    },
    config = function()
      require('telescope-all-recent').setup {
        pickers = { -- allows you to overwrite the default settings for each picker
          buffers = { -- enable man_pages picker. Disable cwd and use frecency sorting.
            disable = false,
            use_cwd = true,
            sorting = 'recent',
          },
          -- find_files = { -- enable man_pages picker. Disable cwd and use frecency sorting.
          --   disable = false,
          --   use_cwd = true,
          --   sorting = 'recent',
          -- },

          -- change settings for a telescope extension.
          -- To find out about extensions, you can use `print(vim.inspect(require'telescope'.extensions))`
          -- ['extension_name#extension_method'] = {
          --   -- [...]
          -- },
        },
      }
    end,
  },
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', function()
            require('telescope.builtin').lsp_references {
              -- show_line = false,
              fname_width = 80,
            }
          end, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>K', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ls', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>lS', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>lr', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>la', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap.
          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          function _G.get_test_path()
            local current_file = vim.fn.expand '%:.'
            local test_class = ''
            local test_method = vim.fn.expand '<cword>'

            -- Get the lines from the start to the current line
            local lines = vim.api.nvim_buf_get_lines(0, 0, vim.fn.line '.', false)

            -- Find the current class and method under cursor
            for _, line in ipairs(lines) do
              local class_name = line:match '^%s*class%s+([%w_]+)'
              if class_name then
                test_class = class_name
              end
            end

            -- Convert the file path to a dotted module path (relative to project root)
            local module_path = current_file:gsub('/', '.'):gsub('.py$', '')

            -- Format the test path
            local test_path = string.format('%s.%s.%s', module_path, test_class, test_method)

            -- Copy to clipboard
            vim.fn.setreg('+', test_path)
            print('Copied to clipboard: ' .. test_path)
          end

          -- Map the function to a key
          -- vim.api.nvim_set_keymap('n', '<leader>Yt', ':lua _G.get_test_path()<CR>', { noremap = true, silent = true, desc = 'Python test path' })

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following autocommand is used to enable inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            map('<leader>lh', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      local lspconfig = require 'lspconfig'

      lspconfig.gdscript.setup {
        capabilities = capabilities,
      }
      -- Set global defaults for all servers
      lspconfig.util.default_config = vim.tbl_extend('force', lspconfig.util.default_config, {
        capabilities = vim.tbl_deep_extend(
          'force',
          vim.lsp.protocol.make_client_capabilities(),
          -- returns configured operations if setup() was already called
          -- or default operations if not
          require('lsp-file-operations').default_capabilities()
        ),
      })

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers =
        {
          -- clangd = {},
          -- gopls = {},
          pyright = {
            -- single_file_support = true,
            settings = {
              python = {
                analysis = {
                  autoImportCompletions = true,
                  autoSearchPaths = true,
                  diagnosticMode = 'workspace', -- openFilesOnly, workspace
                  typeCheckingMode = 'basic', -- off, basic, strict
                  useLibraryCodeForTypes = true,
                  extraPaths = { '/opt/homebrew/opt/python@3.10/Frameworks/Python.framework/Versions/3.10/lib/python3.10/site-packages' },
                },
              },
            },
          },
          -- rust_analyzer = {},
          -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
          --
          -- Some languages (like typescript) have entire language plugins that can be useful:
          --    https://github.com/pmizio/typescript-tools.nvim
          --
          -- But for many setups, the LSP (`tsserver`) will work just fine
          -- tsserver = {},
          --

          lua_ls = {
            -- cmd = {...},
            -- filetypes = { ...},
            -- capabilities = {},
            settings = {
              Lua = {
                completion = {
                  callSnippet = 'Replace',
                },
                -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                -- diagnostics = { disable = { 'missing-fields' } },
              },
            },
          },
          eslint = {

            settings = {
              -- codeAction = {
              --   disableRuleComment = {
              --     enable = true,
              --     location = 'separateLine',
              --   },
              --   showDocumentation = {
              --     enable = true,
              --   },
              -- },
              -- codeActionOnSave = {
              --   enable = false,
              --   mode = 'all',
              -- },
              -- experimental = {
              --   useFlatConfig = false,
              -- },
              format = false,
              -- nodePath = '',
              -- onIgnoredFiles = 'off',
              problems = {
                shortenToSingleLine = true,
              },
              -- quiet = false,
              -- run = 'onType',
              -- useESLintClass = false,
              -- validate = 'on',
              -- workingDirectory = {
              --   mode = 'location',
              -- },
              rulesCustomizations = {
                -- Customize ESLint rules here
                { rule = '*', severity = 'warn' },
                { rule = 'max-lines-per-function', severity = 'off' },
              },
            },
          },
        },
        -- Ensure the servers and tools above are installed
        --  To check the current status of installed tools and/or manually install
        --  other tools, you can run
        --    :Mason
        --
        --  You can press `g?` for help in this menu.
        require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
        -- 'black',
        'eslint',
        -- 'typescript-language-server',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = false, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
      {
        '<leader>w',
        function()
          require('conform').format { async = false, lsp_fallback = true }
          vim.cmd 'w'
        end,
        mode = '',
        desc = 'Format & Save Buffer',
      },
    },
    opts = {
      log_level = vim.log.levels.ERROR,
      -- notify_on_error = false,
      -- format_on_save = function(bufnr)
      --   -- Disable "format_on_save lsp_fallback" for languages that don't
      --   -- have a well standardized coding style. You can add additional
      --   -- languages here or re-enable it for the disabled ones.
      --   local disable_filetypes = { c = true, cpp = true }
      --   return {
      --     timeout_ms = 500,
      --     lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      --   }
      -- end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        python = { 'black' },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        -- javascript = { { 'prettierd', 'prettier' } },
        go = { 'goimports', 'gofmt' },
        javascript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescript = { 'prettier' },
        typescriptreact = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },
      },
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/nvim-cmp',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },
          ['<CR>'] = cmp.mapping.confirm { select = true },

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          --['<CR>'] = cmp.mapping.confirm { select = true },
          --['<Tab>'] = cmp.mapping.select_next_item(),
          --['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          { name = 'nvim_lsp', priority = 1000 },
          { name = 'luasnip' },
          { name = 'path', priority = 800 },
        },
      }
      cmp.setup.filetype({ 'sql' }, {
        sources = {
          { name = 'vim-dadbod-completion', priority = 900 },
          -- { name = 'buffer' },
          { name = 'buffer', max_item_count = 5, priority = 1 }, -- Reduce the number of suggestions
        },
      })
      local lspkind = require 'lspkind'
      cmp.setup {
        formatting = {
          format = lspkind.cmp_format(),
        },
      }
    end,
  },
  {
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.cmd.colorscheme 'tokyonight-night'
      vim.cmd.hi 'Comment gui=none'
    end,
    config = function()
      require('tokyonight').setup {
        on_highlights = function(highlights, colors)
          highlights.GitSignsAdd = { fg = colors.green, bg = colors.none, bold = true }
          highlights.GitSignsChange = { fg = colors.orange, bg = colors.none, bold = true }
          highlights.GitSignsDelete = { fg = colors.red, bg = colors.none, bold = true }
        end,
      }
    end,
  },
  -- -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- require('mini.animate').setup()
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'vim',
        'vimdoc',
        'python',
        'requirements',
        'xml',
        'http',
        'json',
        'graphql',
        'gdscript',
        'sql',
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },
      textobjects = {
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            -- Built-in captures.
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            -- You can optionally set descriptions to the mappings (used in the desc parameter of
            -- nvim_buf_set_keymap) which plugins like which-key display
            ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
          },
          -- You can choose the select mode (default is charwise 'v')
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * method: eg 'v' or 'o'
          -- and should return the mode ('v', 'V', or '<c-v>') or a table
          -- mapping query_strings to modes.
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V', -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
        },
        move = {
          -- https://www.josean.com/posts/nvim-treesitter-and-textobjects
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            -- [']f'] = { query = '@call.outer', desc = 'Next function call start' },
            [']f'] = { query = '@function.outer', desc = 'Next method/function def start' },
            [']v'] = { query = '@assignment.outer', desc = 'Next assignment/variable start' },
            [']c'] = { query = '@class.outer', desc = 'Next class start' },
            [']i'] = { query = '@conditional.outer', desc = 'Next conditional start' },
            [']l'] = { query = '@loop.outer', desc = 'Next loop start' },

            -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
            -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
            [']s'] = { query = '@scope', query_group = 'locals', desc = 'Next scope' },
            [']z'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
          },
          goto_next_end = {
            -- [']F'] = { query = '@call.outer', desc = 'Next function call end' },
            [']F'] = { query = '@function.outer', desc = 'Next method/function def end' },
            [']V'] = { query = '@assignment.outer', desc = 'Next assignment/variable end' },
            [']C'] = { query = '@class.outer', desc = 'Next class end' },
            [']I'] = { query = '@conditional.outer', desc = 'Next conditional end' },
            [']L'] = { query = '@loop.outer', desc = 'Next loop end' },
          },
          goto_previous_start = {
            -- ['[f'] = { query = '@call.outer', desc = 'Prev function call start' },
            ['[f'] = { query = '@function.outer', desc = 'Prev method/function def start' },
            ['[v'] = { query = '@assignment.outer', desc = 'Prev assignment/variable start' },
            ['[c'] = { query = '@class.outer', desc = 'Prev class start' },
            ['[i'] = { query = '@conditional.outer', desc = 'Prev conditional start' },
            ['[l'] = { query = '@loop.outer', desc = 'Prev loop start' },
          },
          goto_previous_end = {
            --   ['[F'] = { query = '@call.outer', desc = 'Prev function call end' },
            ['[F'] = { query = '@function.outer', desc = 'Prev method/function def end' },
            ['[V'] = { query = '@assignment.outer', desc = 'Prev assignment/variable end' },
            ['[C'] = { query = '@class.outer', desc = 'Prev class end' },
            ['[I'] = { query = '@conditional.outer', desc = 'Prev conditional end' },
            ['[L'] = { query = '@loop.outer', desc = 'Prev loop end' },
          },
        },
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- custom_captures = {
        --   ['sql'] = 'SQL',
        -- },
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        -- additional_vim_regex_highlighting = { 'ruby' },
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      -- Prefer git instead of curl in order to improve connectivity in some environments
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
      local ts_repeat_move = require 'nvim-treesitter.textobjects.repeatable_move'

      -- vim way: ; goes to the direction you were moving.
      vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
      vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite)

      -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
      vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f)
      vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F)
      vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t)
      vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T)
    end,
  },

  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  require 'custom.plugins',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  -- { import = 'custom.plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- restore last cursor position
-- https://github.com/neovim/neovim/issues/16339#issuecomment-1457394370
vim.api.nvim_create_autocmd('BufRead', {
  callback = function(opts)
    vim.api.nvim_create_autocmd('BufWinEnter', {
      once = true,
      buffer = opts.buf,
      callback = function()
        local ft = vim.bo[opts.buf].filetype
        local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
        if not (ft:match 'commit' and ft:match 'rebase') and last_known_line > 1 and last_known_line <= vim.api.nvim_buf_line_count(opts.buf) then
          vim.api.nvim_feedkeys([[g`"]], 'nx', false)
        end
      end,
    })
  end,
})

-- vim.treesitter.language.add('markdown', 'octo')
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

-- Enable paste to be repeatable
-- https://vi.stackexchange.com/a/34860/48283
vim.api.nvim_set_keymap('x', 'p', 'c<c-r><c-r>0<esc>', { noremap = true, silent = true })

-- Visual mode paste from the system clipboard
vim.api.nvim_set_keymap('x', 'p', '"_d"+P', { noremap = true, silent = true })

-- Neogit
-- Define the autocommand to refresh buffers when the Neogit status buffer is closed
vim.api.nvim_create_augroup('NeogitRefresh', { clear = true })
vim.api.nvim_create_autocmd('BufWinLeave', {
  group = 'NeogitRefresh',
  pattern = 'NeogitStatus',
  callback = function()
    vim.cmd 'checktime'
  end,
})

-- set auto reload
-- https://superuser.com/a/1090762/1573671
vim.cmd 'set autoread'
vim.cmd 'au CursorHold * checktime'

-- Custom function to close all buffers with a warning if there are unsaved changes
function Close_all_buffers()
  local unsaved_buffers = {}

  -- Iterate through all buffers and check for unsaved changes
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_option(bufnr, 'modified') then
      table.insert(unsaved_buffers, bufnr)
    end
  end

  if #unsaved_buffers > 0 then
    -- Show a dialog with the list of unsaved buffers
    local unsaved_files = {}
    for _, bufnr in ipairs(unsaved_buffers) do
      table.insert(unsaved_files, vim.api.nvim_buf_get_name(bufnr))
    end
    local message = 'There are unsaved changes in the following files:\n'
    message = message .. table.concat(unsaved_files, '\n')
    message = message .. '\nDo you really want to close all buffers? (y/n)'

    -- Prompt the user for confirmation
    local answer = vim.fn.input(message .. ' ')
    if answer:lower() == 'y' then
      -- Force close all buffers
      vim.cmd 'qa!'
    else
      print 'Cancelled closing buffers.'
    end
  else
    -- No unsaved changes, force close all buffers
    vim.cmd 'qa!'
  end
end

-- Quit all with confirmation
-- map('<leader>Q', ':lua Close_all_buffers()<CR>', '[Q]uit all')

-- Function to checkout PR and run DiffviewPR
vim.api.nvim_set_keymap('n', '<leader>hh', ':Telescope gh pull_request<CR>', { noremap = true, silent = true })

-- map('<leader>rr', ':Rest run<CR>', 'Rest run')
-- map('<leader>rl', ':Rest run last<CR>', 'Rest run last')

-- Function to perform the required actions
function Neotest_actions()
  require('neotest').run.run()
  require('neotest').output_panel.open()
  require('neotest').summary.open()
end

vim.api.nvim_set_keymap('n', '<leader>T', ':lua Neotest_actions()<CR>', { noremap = true, silent = true })
map('<leader>.', ':DotEnv<CR>', 'Load .env')

local diffview_custom = require 'diffview_custom'

local diffview = require 'diffview'
diffview.setup {
  keymaps = {
    view = {
      {
        'n',
        '<leader>hv',
        function()
          diffview_custom.Toggle_viewed()
        end,
        { desc = 'Toggle viewed' },
      },
    },
    file_panel = {
      {
        'n',
        '<leader>hv',
        function()
          diffview_custom.Toggle_viewed()
        end,
        { desc = 'Toggle viewed' },
      },
    },
  },
}
vim.api.nvim_create_autocmd('User', { pattern = 'TelescopePROpenPR', callback = _G.Open_Diffview_PR })

-- -- Code folding
-- https://www.jackfranklin.co.uk/blog/code-folding-in-vim-neovim/
vim.o.foldenable = true
vim.o.foldcolumn = '1'
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldtext = ''
vim.o.foldlevel = 99
-- vim.o.foldlevelstart = 1
vim.o.foldnestmax = 4
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- ~/DevVault
-- Telescope grep with the following cwd

function Search_notes()
  vim.cmd 'Telescope live_grep cwd=~/DevVault'
end

function Add_to_recent_files(file, cwd)
  local frecency = require 'telescope-all-recent.frecency'
  local picker = { name = 'find_files', cwd = cwd }
  frecency.update_entry(picker, file)
end

function Create_note()
  local title = vim.fn.input 'Enter title: '
  local file = title .. '.md'
  local cwd = '~/DevVault'
  local file_path = cwd .. '/' .. file
  vim.cmd('e ' .. file_path)
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { '# ' .. title })
  vim.cmd ':w'
  local cwd_full_path = vim.fn.expand(cwd)
  -- run this a few times to ensure its treated as the most recent
  Add_to_recent_files(file, cwd_full_path)
  Add_to_recent_files(file, cwd_full_path)
  Add_to_recent_files(file, cwd_full_path)
end

function Recent_notes()
  vim.cmd 'lua require("telescope.builtin").find_files({cwd="~/DevVault/"})'
end

local wk = require 'which-key'
function _G.close_all_floating_wins()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= '' then
      vim.api.nvim_win_close(win, false)
    end
  end
end

-- cleanup on exit nvim
vim.cmd [[
  augroup dbui_cleanup
    autocmd!
    autocmd VimLeavePre * lua _G.close_all_floating_wins()
    autocmd VimLeavePre * DBUIClose
    autocmd VimLeavePre * Neotree close
    autocmd VimLeavePre * DBUIClose
    autocmd VimLeavePre * DiffviewClose
  augroup END
]]
vim.cmd 'autocmd User DBUIOpened setlocal number relativenumber'
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  callback = function()
    vim.wo.relativenumber = true
  end,
})

-- adds the Cfilter to allow filtering quickfix list results
vim.cmd 'packadd cfilter'

vim.cmd 'let g:hardtime_default_on = 1'
vim.cmd 'let g:hardtime_ignore_quickfix = 1'
vim.cmd 'let g:hardtime_showmsg = 1'

function Open_notes_workspace_Tab()
  vim.cmd 'tabnew'
  local new_cwd = '~/DevVault'
  local cmd = 'lcd ' .. new_cwd
  vim.cmd(cmd)
  -- vim.cmd 'Neotree dir=./'
end

wk.add {
  -- name = '+[N]otes',
  { '<leader>ns', Search_notes, desc = 'Search' },
  { '<leader>nn', Create_note, desc = 'New' },
  { '<leader>nr', Recent_notes, desc = 'Recent' },
  { '<leader>nw', Open_notes_workspace_Tab, desc = 'Workspace Tab' },
}

-- map('<leader>rr', ':Rest run<CR>', 'Rest run')
-- map('<leader>rl', ':Rest run last<CR>', 'Rest run last')
-- wk.add {
--   ['<leader>r'] = {
--     name = 'Ship',
--     -- TODO: make it create a folder for ship and do global ignore
--     -- c = { vim.cmd('ShipCreate', 'Ship Create') },
--     -- r = { vim.cmd('ShipCreate', 'Ship') },
--   },
-- }

vim.keymap.set('n', 'dsi', function()
  -- select outer indentation
  require('various-textobjs').indentation('outer', 'outer')

  -- plugin only switches to visual mode when a textobj has been found
  local indentationFound = vim.fn.mode():find 'V'
  if not indentationFound then
    return
  end

  -- dedent indentation
  vim.cmd.normal { '<', bang = true }

  -- delete surrounding lines
  local endBorderLn = vim.api.nvim_buf_get_mark(0, '>')[1]
  local startBorderLn = vim.api.nvim_buf_get_mark(0, '<')[1]
  vim.cmd(tostring(endBorderLn) .. ' delete') -- delete end first so line index is not shifted
  vim.cmd(tostring(startBorderLn) .. ' delete')
end, { desc = 'Delete Surrounding Indentation' })

vim.g.python3_host_prog = vim.fn.expand '$HOME/.local/venv/nvim/bin/python'

local wk = require 'which-key'
-- wk.add { '<leader>gG', ':DiffviewOpen<CR>', desc = '[G]it changes' }
wk.add { '<leader>gg', ':G<CR>', desc = '[G]it Fugitive' }
wk.add { '<leader>gS', ':Gwrite<CR>', desc = 'Gwrite - [S]tage current buffer' }

wk.add { '<leader>gb', ':G branch --sort=-committerdate<CR>', desc = 'Git [b]ranches' }
-- wk.add { '<leader>gb', ':Telescope git_branches<CR>', desc = 'Git [b]ranches' }
wk.add { '<leader>gB', ':G blame <CR>', desc = 'Git [B]lame' }

-- TODO:
-- local builtin = require 'telescope.builtin'
-- -- Create a custom function to pass the sorting option
-- function _G.custom_git_branches()
--   builtin.git_branches {
--     -- pattern = '--sort=-committerdate',
--     pattern = { '--sort', '-committerdate' },
--   }
-- end
-- wk.add { '<leader>gb', ':lua _G.custom_git_branches()<CR>', desc = 'Git [b]ranches' }

-- Map the custom function to a keybinding
-- vim.api.nvim_set_keymap('n', '<leader>gb', ':lua custom_git_branches()<CR>', { noremap = true, silent = true })

-- Devdocs
-- wk.add { '<leader>Do', ':DevdocsOpen<CR>', desc = 'Devdocs [O]pen' }
-- wk.add { '<leader>Di', ':DevdocsInstall<CR>', desc = 'Devdocs [I]nstall' }
-- wk.add { '<leader>Du', ':DevdocsUpdateAll<CR>', desc = 'Devdocs [U]pdate All' }
-- wk.add { '<leader>Dg', ':lua Devdocs_grep()<CR>', desc = 'Devdocs [G]rep' }
-- wk.add { '<leader>Dt', ':Telescope tldr<CR>', desc = 'TLDR' }

-- add easier map to goto the middle of the line
vim.api.nvim_set_keymap('n', 'gm', ":call cursor(0, virtcol('$')/2)<CR>", { noremap = true, silent = true })

-- local null_ls = require 'null-ls'

-- null_ls.setup {
--   sources = {
--     -- null_ls.builtins.formatting.stylua,
--     -- null_ls.builtins.completion.spell,
--     -- require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
--     null_ls.builtins.formatting.sqlfluff.with {
--       extra_args = { '--dialect', 'sqlite' }, -- change to your dialect
--     },
--     null_ls.builtins.diagnostics.sqlfluff.with {
--       extra_args = { '--dialect', 'sqlite' }, -- change to your dialect
--     },
--   },
-- }

-- print(vim.inspect(vim.treesitter.("python", "injections")))

-- Keymap for showing git status in neotree
vim.api.nvim_set_keymap('n', '<leader>gG', ':Neotree source=git_status reveal=true<CR>', { noremap = true, silent = true, desc = 'Open Git Status in Neotree' })

-- Keymap for navigating quickfix list
vim.api.nvim_set_keymap('n', ']q', ':cnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[q', ':cprev<CR>', { noremap = true, silent = true })

-- Keymap for reselecting pasted text
-- vim.api.nvim_set_keymap('n', 'gp', '`[v`]', { noremap = true, silent = true })
