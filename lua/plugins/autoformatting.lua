return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
    'jayp0521/mason-null-ls.nvim', -- ensure dependencies are installed
  },
  config = function()
    local null_ls = require 'null-ls'
    local formatting = null_ls.builtins.formatting -- to setup formatters
    local diagnostics = null_ls.builtins.diagnostics -- to setup linters

    -- Formatters & linters for mason to install
    require('mason-null-ls').setup {
      ensure_installed = {
        'prettier',
        'eslint_d', -- ts/js linter
        'shfmt', -- Shell formatter
        'checkmake', -- linter for Makefiles
        -- 'stylua', -- lua formatter; Already installed via Mason
        -- 'ruff', -- Python linter and formatter; Already installed via Mason
      },
      automatic_installation = true,
    }

    local sources = {
      diagnostics.checkmake,
      require 'none-ls.diagnostics.eslint_d',
      formatting.prettier,
      formatting.stylua.with { extra_args = { '--indent-width', '2' } },
      formatting.shfmt.with { args = { '-i', '4' } },
      formatting.terraform_fmt,
      require 'none-ls.formatting.ruff_format',
    }

    local augroup = vim.api.nvim_create_augroup('LspFormatting', { clear = true })
    local preferred_formatters = {
      c = 'clangd',
      cpp = 'clangd',
      rust = 'rust_analyzer',
    }

    local formatter_for_filetype = function(filetype)
      return preferred_formatters[filetype] or 'null-ls'
    end

    null_ls.setup {
      -- debug = true, -- Enable debug mode. Inspect logs with :NullLsLog.
      sources = sources,
    }

    vim.api.nvim_create_autocmd('LspAttach', {
      group = augroup,
      desc = 'Format supported buffers before saving',
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        local filetype = vim.bo[event.buf].filetype
        local formatter = formatter_for_filetype(filetype)

        if not client or client.name ~= formatter or not client:supports_method 'textDocument/formatting' then
          return
        end

        vim.api.nvim_clear_autocmds { group = augroup, buffer = event.buf }
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = augroup,
          buffer = event.buf,
          desc = 'Format buffer before saving',
          callback = function()
            vim.lsp.buf.format {
              async = false,
              bufnr = event.buf,
              timeout_ms = 5000,
              filter = function(formatting_client)
                return formatting_client.name == formatter
              end,
            }
          end,
        })
      end,
    })

    vim.keymap.set('n', '<leader>f', function()
      local bufnr = vim.api.nvim_get_current_buf()
      local formatter = formatter_for_filetype(vim.bo[bufnr].filetype)
      local clients = vim.lsp.get_clients { bufnr = bufnr, name = formatter }
      local client = clients[1]

      if not client or not client:supports_method 'textDocument/formatting' then
        vim.notify(('No %s formatter is attached to this buffer'):format(formatter), vim.log.levels.WARN)
        return
      end

      vim.lsp.buf.format {
        async = false,
        bufnr = bufnr,
        timeout_ms = 5000,
        filter = function(formatting_client)
          return formatting_client.name == formatter
        end,
      }
    end, { desc = 'Format buffer' })
  end,
}
