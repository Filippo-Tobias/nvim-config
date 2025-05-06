vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "
_G.diagnostic_float_win = nil

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false, -- This plugin is already lazy
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
    }
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate'
  },
  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*.rs",
  callback = function()
    -- Manually request diagnostics
    vim.lsp.buf.document_highlight()
    vim.lsp.buf_request(0, "textDocument/diagnostic", {
      textDocument = { uri = vim.uri_from_bufnr(0) },
    }, function() end)
  end,
})

function OpenURLUnderCursor()
  local url = vim.fn.expand('<cWORD>')
  if string.match(url, '^https?://') then
    vim.fn.jobstart({ 'xdg-open', url }, { detach = true })
  else
    vim.cmd('normal! <C-]>')
  end
end

--keymaps
vim.api.nvim_set_keymap('n', '<C-Space>', ':lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-LeftMouse>', [[:lua OpenURLUnderCursor()<CR>]], { noremap = true, silent = true })
vim.keymap.set('n', 'dd', function()
  if vim.fn.getline('.'):match('^%s*$') then
    return '"_dd'
  else
    return 'dd'
  end
end, { expr = true, silent = true })

