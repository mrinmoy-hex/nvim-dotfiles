return {
  'akinsho/bufferline.nvim',
  dependencies = {
    'moll/vim-bbye',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local diagnostic_icons = {
      error = ' ',
      warning = ' ',
      info = ' ',
      hint = '󰌵 ',
    }

    require('bufferline').setup {
      options = {
        mode = 'buffers', -- set to "tabs" to only show tabpages instead
        themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
        numbers = 'none', -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
        close_command = 'Bdelete! %d', -- can be a string | function, see "Mouse actions"
        buffer_close_icon = '×',
        close_icon = '×',
        path_components = 1, -- Show only the file name without the directory
        modified_icon = '●',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 24,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        tab_size = 18,
        diagnostics = 'nvim_lsp',
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level)
          local icon = diagnostic_icons[level]
          return icon and (' ' .. icon .. count) or (' ' .. count)
        end,
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = false,
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        separator_style = 'thin',
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        show_tab_indicators = false,
        indicator = {
          style = 'underline',
        },
        icon_pinned = '󰐃',
        minimum_padding = 1,
        maximum_padding = 5,
        sort_by = 'insert_at_end',
      },
      highlights = require('catppuccin.special.bufferline').get_theme {
        styles = { 'bold' },
        custom = {
          mocha = {
            buffer_selected = {
              underline = true,
              sp = '#cba6f7',
            },
          },
        },
      },
    }
  end,
}
