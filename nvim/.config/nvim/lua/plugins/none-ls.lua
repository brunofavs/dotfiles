return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
      debug = true,
			sources = {
				null_ls.builtins.formatting.stylua,

        -- English writting
        -- null_ls.builtins.diagnostics.proselint,
        -- null_ls.builtins.code_actions.proselint,
        null_ls.builtins.diagnostics.write_good,

				-- Python
				null_ls.builtins.formatting.black,
				-- Imports
				null_ls.builtins.formatting.isort,
			},
		})

		vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, {})
	end,
}
