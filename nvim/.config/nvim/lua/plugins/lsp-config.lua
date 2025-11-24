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
-- https://www.reddit.com/r/neovim/comments/18x2icc/comment/kg1kist/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
				ensure_installed = {
					"lua_ls",
					"bashls",
					"clangd",
					"cmake",
					-- "jsonls",
					"ltex",
					"autotools_ls",
					"markdown_oxide",
					"pyright",
					"lemminx",
					-- "yamlls",
				},
        automatic_enable = false,
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

    --Not supported in Pyright
    --vim.keymap.set('n','<leader>gi',vim.lsp.buf.implementation,{})
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true })
    vim.keymap.set("n", "<S-h>", vim.lsp.buf.hover, {})
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})


-- #######################################################

			-- lspconfig.jsonls.setup({
			-- 	capabilities = capabilities,
			-- })
			--
   --    lspconfig.ltex.setup({
   --        capabilities = capabilities, -- Include capabilities if needed for additional functionality
   --        settings = {
   --              ltex = {
   --                  additionalRules = {
   --                      languageModel = "~/.config/nvim/ngrams_ltex/", -- Specify the path to the language model
   --                  },
   --              },
   --        },
   --    })
			--
			--
			-- lspconfig.texlab.setup({
			-- 	capabilities = capabilities,
   --      on_attach = function(_, bufnr)
   --        vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
   --          vim.lsp.diagnostic.on_publish_diagnostics, {
   --            -- disable virtual text
   --            virtual_text = false,
			--
   --            -- show signs
   --            signs = true,
			--
   --            -- delay update diagnostics
   --            update_in_insert = false,
   --          }
   --        )
   --      end,
			-- })
			-- lspconfig.yamlls.setup({
			-- 	capabilities = capabilities,
			-- })

      -- vim.api.nvim_create_autocmd('FileType', {
      --   pattern = 'sh',
      --   callback = function()
      --     vim.lsp.start({
      --       name = 'bash-language-server',
      --       cmd = { 'bash-language-server', 'start' },
      --     })
      --   end,
      -- })



		end,
	},
}
