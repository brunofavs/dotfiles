return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
      focus = true,
      modes = {
        preview_float_errors = {
            mode = "diagnostics",
            preview = {
              type = "float",
              relative = "editor",
              border = "rounded",
              title = "Preview",
              title_pos = "center",
              position = { 0, -2 },
              size = { width = 0.3, height = 0.3 },
              zindex = 200,
            },
            filter = {
              any = {
                -- buf = 0, -- current buffer
                {
                  severity = vim.diagnostic.severity.ERROR, -- errors only
                  -- limit to files in the current project
                  function(item)
                    return item.filename:find((vim.loop or vim.uv).cwd(), 1, true)
                  end,
                },
              },
            },
        },
        preview_float_other = {
            mode = "diagnostics",
            preview = {
              type = "float",
              relative = "editor",
              border = "rounded",
              title = "Preview",
              title_pos = "center",
              position = { 0, -2 },
              size = { width = 0.3, height = 0.3 },
              zindex = 200,
            },
            filter = {
              any = {
                -- buf = 0, -- current buffer
                {
                  severity = {
                    vim.diagnostic.severity.WARN,
                    vim.diagnostic.severity.INFO,
                    vim.diagnostic.severity.HINT,
                  },
                  -- limit to files in the current project
                  function(item)
                    return item.filename:find((vim.loop or vim.uv).cwd(), 1, true)
                  end,
                },
              },
            },
        }
      },
  },
  cmd = "Trouble",
  keys = {
    {
      "<leader>xw",
      "<cmd>Trouble preview_float_errors toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xd",
      "<cmd>Trouble preview_float_errors toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },

    {
      "<leader>xW",
      "<cmd>Trouble preview_float_other toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xD",
      "<cmd>Trouble preview_float_other toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    -- {
    --   "<leader>xL",
    --   "<cmd>Trouble loclist toggle<cr>",
    --   desc = "Location List (Trouble)",
    -- },
    -- {
    --   "<leader>xq",
    --   "<cmd>Trouble qflist toggle<cr>",
    --   desc = "Quickfix List (Trouble)",
    -- },
  },

}
