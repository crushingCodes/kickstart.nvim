return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        -- theme = bubbles_theme,
        -- theme = 'tokyonight',
        component_separators = '',
        -- section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_c = {
          {
            function()
              local buffers = vim.fn.getbufinfo { buflisted = 1 }
              return 'Buffers: ' .. #buffers
            end,
            color = function()
              local buffers = vim.fn.getbufinfo { buflisted = 1 }
              local count = #buffers
              if count >= 10 then
                return { fg = '#ff0000' } -- Red for 10 or more
              elseif count >= 5 then
                return { fg = '#ffff00' } -- Yellow for 5-9
              else
                return { fg = '#00ff00' } -- Green for fewer than 5
              end
            end,
          },
          { 'filename' },
        },
        lualine_x = {
          {
            require('noice').api.statusline.mode.get,
            cond = require('noice').api.statusline.mode.has,
            color = { fg = '#ff9e64' },
          },
        },
      },
    }
  end,
}
