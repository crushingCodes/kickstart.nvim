return {
  'stevanmilic/nvim-lspimport',
  config = function()
    vim.keymap.set('n', '<leader>a', require('lspimport').import, { noremap = true })
    vim.keymap.set('n', '<leader>li', require('lspimport').import, { noremap = true, desc = 'Python import' })
  end,
}
