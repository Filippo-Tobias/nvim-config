require "nvchad.mappings"

local map = vim.keymap.set

-- unmap default buffer cycling

vim.keymap.del("n", "<Tab>")
vim.keymap.del("n", "<S-Tab>")

map("n", "<A-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<A-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
local cmp = require('cmp')

local mapping = cmp.mapping

cmp.setup({
  mapping = {
    ['<A-j>'] = mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<A-k>'] = mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ['<Tab>'] = mapping.confirm({ select = true }),
    ['<C-a>'] = mapping.complete(),
    ['<CR>'] = mapping(function(fallback)
      fallback() -- do nothing special, just fallback to default <CR> behavior
    end, { 'i', 's' }),
  },
})
