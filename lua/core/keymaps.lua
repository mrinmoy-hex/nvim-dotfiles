-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- For conciseness
local opts = { noremap = true, silent = true }

-- save file
vim.keymap.set('n', '<C-s>', '<cmd>write<CR>', { desc = 'Save and format file', noremap = true, silent = true })

-- save file without auto-formatting
vim.keymap.set('n', '<leader>sn', '<cmd>noautocmd w <CR>', opts)

-- quit file
vim.keymap.set('n', '<C-q>', '<cmd> q <CR>', opts)

-- delete single char without copying into register
vim.keymap.set('n', 'x', '"_x', opts)

local function move_lines(direction)
  local buf = vim.api.nvim_get_current_buf()
  local visual = vim.fn.mode():match('[vV\22]') ~= nil
  local anchor = visual and vim.fn.getpos('v') or nil
  local cursor = vim.api.nvim_win_get_cursor(0)
  local start_row = visual and math.min(anchor[2], cursor[1]) - 1 or cursor[1] - 1
  local end_row = visual and math.max(anchor[2], cursor[1]) - 1 or start_row
  local line_count = vim.api.nvim_buf_line_count(buf)

  if (direction < 0 and start_row == 0) or (direction > 0 and end_row == line_count - 1) then
    return
  end

  local first_row = direction < 0 and start_row - 1 or start_row
  local last_row = direction > 0 and end_row + 1 or end_row
  local lines = vim.api.nvim_buf_get_lines(buf, first_row, last_row + 1, false)

  if direction < 0 then
    table.insert(lines, end_row - start_row + 2, table.remove(lines, 1))
  else
    table.insert(lines, 1, table.remove(lines))
  end

  vim.api.nvim_buf_set_lines(buf, first_row, last_row + 1, false, lines)

  local cursor_row = cursor[1] - 1
  if cursor_row >= start_row and cursor_row <= end_row then
    cursor_row = cursor_row + direction
  end
  local cursor_line = vim.api.nvim_buf_get_lines(buf, cursor_row, cursor_row + 1, false)[1]
  vim.api.nvim_win_set_cursor(0, { cursor_row + 1, math.min(cursor[2], #cursor_line) })

  if visual then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'nx', false)
    vim.api.nvim_win_set_cursor(0, { start_row + direction + 1, 0 })
    vim.cmd('normal! V')
    vim.api.nvim_win_set_cursor(0, { end_row + direction + 1, 0 })
  end
end

local function duplicate_line(direction)
  local buf = vim.api.nvim_get_current_buf()
  local row = vim.api.nvim_win_get_cursor(0)[1] - 1
  local line = vim.api.nvim_buf_get_lines(buf, row, row + 1, false)
  local insert_at = direction > 0 and row + 1 or row

  vim.api.nvim_buf_set_lines(buf, insert_at, insert_at, false, line)
  vim.api.nvim_win_set_cursor(0, { insert_at + 1, vim.api.nvim_win_get_cursor(0)[2] })
end

vim.keymap.set('n', '<A-j>', function() move_lines(1) end, { desc = 'Move line down' })
vim.keymap.set('n', '<A-k>', function() move_lines(-1) end, { desc = 'Move line up' })
vim.keymap.set('v', '<A-j>', function() move_lines(1) end, { desc = 'Move selected lines down' })
vim.keymap.set('v', '<A-k>', function() move_lines(-1) end, { desc = 'Move selected lines up' })
vim.keymap.set('n', '<leader>yd', function() duplicate_line(1) end, { desc = 'Duplicate line down' })
vim.keymap.set('n', '<leader>yu', function() duplicate_line(-1) end, { desc = 'Duplicate line up' })

-- resize with arrows
vim.keymap.set('n', '<Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>', opts)

-- buffers
vim.keymap.set('n', '<Tab>', ':bnext<CR>', opts)
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', opts)
vim.keymap.set('n', '<leader>x', ':Bdelete!<CR>', opts)     -- close buffer
vim.keymap.set('n', '<leader>b', '<cmd> enew <Cr>', opts)   -- new buffer

-- window management
vim.keymap.set('n', '<leader>v', '<C-w>v', opts)    -- split window vertical
vim.keymap.set('n', '<leader>h', '<C-w>s', opts)    -- split window horizontal
vim.keymap.set('n', '<leader>se', '<C-w>=', opts)    -- make split windows equal width & height
vim.keymap.set('n', '<leader>xs', ':close<CR>', opts)   -- close current split window

-- navigate between splits
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', opts)
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', opts)
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', opts)
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', opts)

-- tabs
vim.keymap.set('n', '<leader>to', ':tabnew<CR>', opts) -- open new tab
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', opts) -- close current tab
vim.keymap.set('n', '<leader>tn', ':tabn<CR>', opts) --  go to next tab
vim.keymap.set('n', '<leader>tp', ':tabp<CR>', opts) --  go to previous tab


-- Toggle line wrapping
vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)

-- Toggle diagnostics
local diagnostics_active = true

vim.keymap.set('n', '<leader>do', function()
  diagnostics_active = not diagnostics_active

  if diagnostics_active then
    vim.diagnostic.enable(true)
  else
    vim.diagnostic.enable(false)
  end
end)

-- Diagnostic keymaps
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = 'Go to previous diagnostic message' })

vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Go to next diagnostic message' })

vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Save and load session
vim.keymap.set('n', '<leader>sm', ':mksession! .session.vim<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>sl', ':source .session.vim<CR>', { noremap = true, silent = false })

-- Toggle comments (built-in gc/gcc operator, since Neovim 0.10).
-- remap = true is required here, noremap would not trigger the operator.
vim.keymap.set('n', '<C-_>', 'gcc', { remap = true, silent = true })
vim.keymap.set('n', '<C-c>', 'gcc', { remap = true, silent = true })
vim.keymap.set('n', '<C-/>', 'gcc', { remap = true, silent = true })
vim.keymap.set('v', '<C-_>', 'gc', { remap = true, silent = true })
vim.keymap.set('v', '<C-c>', 'gc', { remap = true, silent = true })
vim.keymap.set('v', '<C-/>', 'gc', { remap = true, silent = true })






