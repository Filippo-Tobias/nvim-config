-- lua/tab_telescope.lua
local M = {}
local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    mappings = {
      n = {
        ["<Tab>"] = function(bufnr) M.open_buffer(bufnr) end,
        ["<S-Tab>"] = false,
      },
    },
  },
})

function M.open_buffer(bufnr)
  actions.select_default(bufnr)
end

-- Handle tab press
function M.on_tab()
  -- Open telescope buffers
  require("telescope.builtin").buffers()

  -- Immediately leave insert mode in Telescope
  vim.schedule(function()
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
      "n",
      true
    )
  end)
end

-- Setup keymap
function M.setup()
  vim.api.nvim_set_keymap("n", "<Tab>", "", { noremap = true, silent = true, callback = M.on_tab })
end

return M
