return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  opts = {},
  keys = {
    {
      '<leader>ld',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Workspace diagnostics',
    },
    {
      '<leader>lD',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer diagnostics',
    },
  },
}
