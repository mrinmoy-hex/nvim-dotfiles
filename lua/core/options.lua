vim.o.hlsearch = false -- Set highlight on search
vim.wo.number = true -- Make line numbers default
vim.o.mouse = 'a' -- Enable mouse mode
vim.o.clipboard = 'unnamedplus' -- Sync clipboard between OS and Neovim.
vim.o.breakindent = true -- Enable break indent
vim.o.undofile = true -- Save undo history
vim.o.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search
vim.o.smartcase = true -- smart case
vim.wo.signcolumn = 'yes' -- Keep signcolumn on by default
vim.o.updatetime = 250 -- Decrease update time
vim.o.timeoutlen = 300 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.o.backup = false -- creates a backup file
vim.o.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.o.completeopt = 'menuone,noselect' -- Set completeopt to have a better completion experience
vim.opt.termguicolors = true -- set termguicolors to enable highlight groups
vim.o.whichwrap = 'bs<>[]hl' -- which "horizontal" keys are allowed to travel to prev/next line
vim.o.wrap = false -- display lines as one long line
vim.o.linebreak = true -- companion to wrap don't split words
vim.o.scrolloff = 4 -- minimal number of screen lines to keep above and below the cursor
vim.o.sidescrolloff = 8 -- minimal number of screen columns either side of cursor if wrap is `false`
vim.o.relativenumber = true -- set relative numbered lines
vim.o.numberwidth = 4 -- set number column width to 2 {default 4}
vim.o.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.o.tabstop = 4 -- insert n spaces for a tab
vim.o.softtabstop = 4 -- Number of spaces that a tab counts for while performing editing operations
vim.o.expandtab = true -- convert tabs to spaces
vim.o.cursorline = true -- highlight the current line
vim.o.splitbelow = true -- force all horizontal splits to go below current window
vim.o.splitright = true -- force all vertical splits to go to the right of current window
vim.o.swapfile = false -- creates a swapfile
vim.o.smartindent = true -- make indenting smarter again
vim.o.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.o.showtabline = 1 -- show if there are at least two tabs
vim.o.backspace = 'indent,eol,start' -- allow backspace on
vim.o.pumheight = 10 -- pop up menu height
vim.o.conceallevel = 0 -- so that `` is visible in markdown files
vim.o.fileencoding = 'utf-8' -- the encoding written to a file
vim.o.cmdheight = 1 -- more space in the neovim command line for displaying messages
vim.o.autoindent = true -- copy indent from current line when starting new one
vim.opt.shortmess:append 'c' -- don't give |ins-completion-menu| messages
vim.opt.iskeyword:append '-' -- hyphenated words recognized by searches
vim.opt.formatoptions:remove { 'c', 'r', 'o' } -- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
vim.opt.runtimepath:remove '/usr/share/vim/vimfiles' -- separate vim plugins from neovim in case vim still in use

local indent_width_by_filetype = {
  astro = 2,
  c = 2,
  cpp = 2,
  css = 2,
  graphql = 2,
  handlebars = 2,
  html = 2,
  htmlangular = 2,
  javascript = 2,
  javascriptreact = 2,
  json = 2,
  json5 = 2,
  jsonc = 2,
  less = 2,
  lua = 2,
  ['markdown.mdx'] = 2,
  markdown = 2,
  scss = 2,
  svelte = 2,
  rust = 4,
  terraform = 2,
  ['terraform-vars'] = 2,
  tf = 2,
  typescript = 2,
  typescriptreact = 2,
  vue = 2,
  yaml = 2,
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = vim.tbl_keys(indent_width_by_filetype),
  callback = function(event)
    local width = indent_width_by_filetype[vim.bo[event.buf].filetype]
    vim.bo[event.buf].expandtab = true
    vim.bo[event.buf].shiftwidth = width
    vim.bo[event.buf].softtabstop = width
    vim.bo[event.buf].tabstop = width
  end,
  desc = 'Set default indentation for common filetypes',
})
