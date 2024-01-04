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
}
