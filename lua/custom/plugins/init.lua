-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
--

function _G.close_all_floating_wins()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= '' then
      vim.api.nvim_win_close(win, false)
    end
  end
end
-- See the kickstart.nvim README for more information
return {
  { 'tpope/vim-surround' },
  { 'tpope/vim-abolish' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-obsession' },
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      -- 'sindrets/diffview.nvim', -- optional - Diff integration
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
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      -- OR 'ibhagwan/fzf-lua',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {},
    config = function()
      require('octo').setup {
        enable_builtin = true,
        suppress_missing_scope = {
          projects_v2 = true,
        },
      }
      local whichkey = require 'which-key'
      local mappings = {
        h = {
          name = 'Git[h]ub',
          ['r'] = { '<cmd>Octo pr reload<cr>', 'Reload PR' },
          ['l'] = { '<cmd>Octo pr list<cr>', 'PR list' },
          ['b'] = { '<cmd>Octo pr browser<cr>', 'Open PR in browser' },
          ['R'] = { '<cmd>Octo review start<cr>', 'Review start' },
          ['u'] = { '<cmd>Octo pr url<cr>', 'Copy URL to system clipboard' },
          gf = { '<cmd>Octo file<cr>', 'Go to file' },
          ['n'] = { '<cmd>Octo changed-file next<cr>', 'Move to previous changed file' },
          ['p'] = { '<cmd>Octo changed-file prev<cr>', 'Move to next changed file' },
          ['v'] = { '<cmd>Octo viewed toggle<cr>', 'Toggle viewer viewed state' },
          o = { '<cmd>Octo<cr>', 'Octo' },
          C = { '<cmd>Octo pr checkout<cr>', 'Checkout PR' },
          c = { '<cmd>Octo pr commits<cr>', 'List PR commits' },
          f = { '<cmd>Octo pr files<cr>', 'List PR changed files' },
          d = { '<cmd>Octo pr diff<cr>', 'Show PR diff' },
        },
      }
      whichkey.register(mappings, { prefix = '<leader>' })
    end,
  },
  {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup {
        log_level = 'error',
        auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
        auto_session_suppress_filetypes = { 'octo', 'sql', 'dbout' },
        pre_save_cmds = { _G.close_all_floating_wins, 'Neotree close', 'DBUIClose' },
        -- post_restore_cmds = { 'Neotree filesystem show' },
      }
    end,
  },
  {
    'pocco81/auto-save.nvim',
    opts = {
      condition = function(buf)
        local fn = vim.fn
        local utils = require 'auto-save.utils.data'

        print('filetype', vim.bo[buf].filetype)
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
    event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    keys = {
      -- Keymap to open VenvSelector to pick a venv.
      { '<leader>vs', '<cmd>VenvSelect<cr>' },
      -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
      { '<leader>vv', '<cmd>VenvSelectCached<cr>' },
    },
  },
  {
    'tpope/vim-fugitive',
  },
  { 'tpope/vim-dadbod' },
  { 'kristijanhusak/vim-dadbod-ui' },
  { 'kristijanhusak/vim-dadbod-completion' },
  
}
