return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"bashls",
					"clangd",
					"cmake",
					"jsonls",
					"ltex",
					"autotools_ls",
					"markdown_oxide",
					"pyright",
					"lemminx",
					"yamlls",
				},
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("mason-tool-installer").setup({
				-- Install these linters, formatters, debuggers automatically
				ensure_installed = {
					-- "black",
					-- "debugpy",
					-- "flake8",
					-- "isort",
					-- "mypy",
					-- "pylint",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            }
          }
        }
			})

			lspconfig.jsonls.setup({
				capabilities = capabilities,
			})

      lspconfig.ltex.setup({
          capabilities = capabilities, -- Include capabilities if needed for additional functionality
          settings = {
                ltex = {
                    additionalRules = {
                        languageModel = "~/.config/nvim/ngrams_ltex/", -- Specify the path to the language model
                    },
                },
          },
      })


			lspconfig.texlab.setup({
				capabilities = capabilities,
        on_attach = function(_, bufnr)
          vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, {
              -- disable virtual text
              virtual_text = false,

              -- show signs
              signs = true,

              -- delay update diagnostics
              update_in_insert = false,
            }
          )
        end,
			})
			lspconfig.yamlls.setup({
				capabilities = capabilities,
			})
			lspconfig.pyright.setup({
          capabilities = capabilities,
          settings = {
              python = {
                analysis = {
                  typeCheckingMode = "standard",

                  diagnosticSeverityOverrides = {
                      -- strictListInference = "warning",
                      -- strictDictionaryInference = "warning",
                      -- strictSetInference = "warning",
                      reportPossiblyUnboundVariable = "none"
                  },

                    extraPaths = {
                      "/home/bruno/ros_ws/atom_ttc_ws/src/atom_annotation_ML/atom_core/src",
                      "/home/bruno/ros_ws/atom_ttc_ws/src/atom_annotation_ML/atom_evaluation/src",
                      "/home/bruno/ros_ws/atom_ttc_ws/src/atom_annotation_ML/atom_calibration/src",
                      "/home/bruno/ros_ws/atom_ttc_ws/src/atom_annotation_ML/atom_msgs/src",
                    }
                }
              }
          }
			})

      lspconfig.dockerls.setup {
          settings = {
            docker = {
              languageserver = {
                formatter = {
                  ignoreMultilineInstructions = true,
                },
              },
            }
          }
      }

			--Not supported in Pyright
			--vim.keymap.set('n','<leader>gi',vim.lsp.buf.implementation,{})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true })
			vim.keymap.set("n", "<S-h>", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

      -- TODO This is cool but annoying, should be a keybind instead
      -- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#show-line-diagnostics-automatically-in-hover-window
			-- -- You will likely want to reduce updatetime which affects CursorHold
			-- -- note: this setting is global and should be set only once
			-- vim.o.updatetime = 250
			-- vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			-- 	group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
			-- 	callback = function()
			-- 		vim.diagnostic.open_float(nil, { focus = false })
			-- 	end,
			-- })

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'sh',
        callback = function()
          vim.lsp.start({
            name = 'bash-language-server',
            cmd = { 'bash-language-server', 'start' },
          })
        end,
      })



		end,
	},
}
