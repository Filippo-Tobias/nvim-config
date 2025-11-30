return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        diagnostics = {
          enable = true,
        },
      })
    end,
  },

  -- {
  --   "vim-denops/denops.vim",
  --   lazy = false,
  -- },
  {
    "milanglacier/minuet-ai.nvim",
    config = function()
      require('minuet').setup {
        use_cmp = false,
        cmp = { auto_trigger = false, enabled = false, enable_auto_complete = false, },
        virtualtext = {
          auto_trigger_ft = {},
          keymap = {
            -- accept whole completion
            accept = '<A-A>',
            -- accept one line
            accept_line = '<A-a>',
            -- accept n lines (prompts for number)
            -- e.g. "A-z 2 CR" will accept 2 lines
            accept_n_lines = '<A-z>',
            -- Cycle to prev completion item, or manually invoke completion
            prev = '<A-[>',
            -- Cycle to next completion item, or manually invoke completion
            next = '<A-]>',
            dismiss = '<A-e>',
          },
          show_on_completion_menu = true,
        },
        provider = 'openai_compatible',
        context_window = 256000,
        provider_options = {
          openai_compatible = {
            api_key = 'MOONSHOT_API_KEY',
            end_point = 'https://api.moonshot.ai/v1/chat/completions',
            model = 'kimi-k2-0905-preview',
            name = 'Moonshot',
          }
        },
      }
    end,
    lazy = false,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      if opts and opts.sources then
        -- strip out 'minuet' source
        for i = #opts.sources, 1, -1 do
          if opts.sources[i].name == "minuet" then
            table.remove(opts.sources, i)
          end
        end
      end
      return opts
    end,
  },
  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
