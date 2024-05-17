-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  { 'tpope/vim-surround' },
  { 'tpope/vim-abolish' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-obsession' },
<<<<<<< Updated upstream
  -- {
  --   'Shatur/neovim-ayu',
  --   config = function()
  --     require('ayu').setup {}
  --     vim.cmd.colorscheme 'ayu-dark'
  --   end,
  --   priority = 1000,
  -- },
=======
  {
    'Shatur/neovim-ayu',
    config = function()
      require('ayu').setup {}
      vim.cmd.colorscheme 'ayu-dark'
    end,
    priority = 1000,
  },
>>>>>>> Stashed changes
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration

      -- Only one of these is needed, not both.
      'nvim-telescope/telescope.nvim', -- optional
      -- "ibhagwan/fzf-lua",              -- optional
    },
    config = true,
  },
  {
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      -- OR 'ibhagwan/fzf-lua',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('octo').setup()
    end,
  },
<<<<<<< Updated upstream
  {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup {
        log_level = 'error',
        auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
      }
    end,
  },
=======
>>>>>>> Stashed changes
}
