_G.jtest_is_test_file = function(file_path)
  local is_test_file = vim.endswith(file_path, '.test.tsx')
    or vim.endswith(file_path, '.jest.tsx')
    or vim.endswith(file_path, '.test.ts')
    or vim.endswith(file_path, '.jest.ts')
    or vim.endswith(file_path, '.test.tsx')
    or vim.endswith(file_path, '.jest.jsx')
    or vim.endswith(file_path, '.test.js')
    or vim.endswith(file_path, '.jest.js')
  return is_test_file
end
return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-jest',
    'nvim-neotest/neotest-python',
    'mfussenegger/nvim-dap-python',
    'rouge8/neotest-rust',
  },
  config = function()
    require('custom.plugins.neotest_setup').setup_neotest()

    local mason_path = vim.fn.glob(vim.fn.stdpath 'data' .. '/mason/')
    print(mason_path)
    local codelldb_path = mason_path .. 'bin/codelldb'
    local dap = require 'dap'
    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        command = codelldb_path,
        args = { '--port', '${port}' },
      },
    }
    require('neotest').setup {
      adapters = {
        require 'neotest-python' {
          args = { '--keepdb' },
        },
        require 'neotest-jest' {

          jestCommand = 'npm run jest -- --coverage',
          jestConfigFile = 'jest.config.ts',
          -- env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
          require 'neotest-rust' {
            -- args = { '--no-capture' },
            -- dap_adapter = 'lldb',
          },
        },
      },
    }

    local jest_adapter = require 'neotest-jest'
    jest_adapter.is_test_file = _G.jtest_is_test_file
  end,
}
