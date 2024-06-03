return {
  -- Other plugin configurations
  {
    'mfussenegger/nvim-dap',
    config = function()
      -- Optional dap configuration
    end
  },
  {
    'nvim-neotest/nvim-nio',
    config = function()
      -- Configuration for nvim-nio if needed
    end
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    config = function()
      require('nvim-dap-virtual-text').setup()
    end
  },
  {
    'rcarriga/nvim-dap-ui',
    config = function()
      require('dapui').setup()
    end,
    dependencies = {
      'nvim-neotest/nvim-nio'
    }
  },
}
