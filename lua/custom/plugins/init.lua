-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'Shatur/neovim-ayu',
    config = function()
      require('ayu').setup({})
      vim.cmd.colorscheme 'ayu-dark'
    end,
    priority = 1000,
  },
  { 'nvim-tree/nvim-tree.lua', config = true },
  { 'nvim-tree/nvim-web-devicons' },
   {
    'pmizio/typescript-tools.nvim',
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("typescript-tools").setup({
        settings = {
          --separate_diagnostic_server = false,
          expose_as_code_action = {
            "add_missing_imports", "remove_unused_imports", "organize_imports"
          },
          tsserver_file_preferences = {
            importModuleSpecifierPreference = "non-relative",
            importModuleSpecifierEnding = "minimal",
          },
        }
      })
    end,
  }, 
  { 'tpope/vim-dadbod' },
  { 'kristijanhusak/vim-dadbod-ui' },
}
