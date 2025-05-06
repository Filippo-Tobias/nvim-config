require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
local cmp = require('cmp')

local mapping = cmp.mapping

cmp.setup({
  mapping = {
    ['<S-j>'] = mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<S-k>'] = mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ['<Tab>'] = mapping.confirm({ select = true }),
    ['<C-a>'] = mapping.complete(),
    ['<CR>'] = mapping(function(fallback)
      fallback() -- do nothing special, just fallback to default <CR> behavior
    end, { 'i', 's' }),
  },
})
