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
  {
    'prochri/telescope-all-recent.nvim',
    priority = 10000,
    dependencies = { 'kkharji/sqlite.lua' },
    config = function()
      require('telescope-all-recent').setup {}
    end,
  },
  {
    'stevearc/dressing.nvim',
    opts = {},
  },
  { 'sindrets/diffview.nvim' },
  {
    'github/copilot.vim',
    config = function()
      require 'custom.plugins.configs.copilot'
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {}, -- this is equalent to setup({}) function
  },
}
