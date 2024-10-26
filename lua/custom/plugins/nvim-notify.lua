return {
  'rcarriga/nvim-notify',
  keys = {
    '<leader>N',
    '<cmd>Telescope notify<cr>',
    desc = 'Notification History',
  },
  opts = {
    timeout = 3000,
    render = 'compact',
    stages = 'fade',
    top_down = false,
    max_height = 5,
  },
}
