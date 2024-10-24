return {
  'jackMort/ChatGPT.nvim',
  -- event = 'VeryLazy',
  lazy = true,
  keys = {
    { '<leader>c', '<cmd>ChatGPT<cr>', desc = 'ChatGPT' },
  },
  config = function()
    local home = vim.fn.expand '$HOME'
    -- print(vim.cmd('gpg --decrypt --no-symkey-cache ' .. home .. '/openai.txt.gpg'))
    require('chatgpt').setup {
      -- this config assumes you have OPENAI_API_KEY environment variable set
      api_key_cmd = 'gpg --decrypt --no-symkey-cache ' .. home .. '/openai.txt.gpg',
      openai_params = {
        -- NOTE: model can be a function returning the model name
        -- this is useful if you want to change the model on the fly
        -- using commands
        -- Example:
        -- model = function()
        --     if some_condition() then
        --         return "gpt-4-1106-preview"
        --     else
        --         return "gpt-3.5-turbo"
        --     end
        -- end,
        -- model = 'gpt-4-1106-preview',
        model = 'gpt-4o-mini',
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 4095,
        temperature = 0.2,
        top_p = 0.1,
        n = 1,
      },
    }
  end,
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'folke/trouble.nvim', -- optional
    'nvim-telescope/telescope.nvim',
  },
}