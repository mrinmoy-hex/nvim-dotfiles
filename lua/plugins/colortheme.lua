return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  config = function()
    local transparent_background = true

    local setup_theme = function()
      require('catppuccin').setup {
        flavour = 'mocha',
        transparent_background = transparent_background,
        integrations = {
          gitsigns = true,
          neotree = true,
          telescope = {
            enabled = true,
          },
        },
      }
      vim.cmd.colorscheme 'catppuccin'
    end

    setup_theme()

    vim.keymap.set('n', '<leader>bg', function()
      transparent_background = not transparent_background
      setup_theme()
    end, { desc = 'Toggle transparent background', silent = true })
  end,
}
