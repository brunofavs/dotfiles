return {
	"nvim-lualine/lualine.nvim",
   dependencies = {
        "meuter/lualine-so-fancy.nvim",
    },
	config = function()
		local function show_macro_recording()
			local recording_register = vim.fn.reg_recording()
			if recording_register == "" then
				return ""
			else
				return "Recording @" .. recording_register
			end
		end
          -- Load the lualine configuration
          local lualine = require('lualine')

          -- Get the default configuration
          local default_config = lualine.get_config()

          -- Ensure the theme is set to "dracula"
          default_config.options.theme = "dracula"

          -- Add the new section to lualine_b
          table.insert(default_config.sections.lualine_b, {
            "macro-recording",
            fmt = show_macro_recording,
          })

          table.insert(default_config.sections.lualine_x, { "fancy_searchcount" })

          -- Setup lualine with the updated configuration
          lualine.setup(default_config)

    -- This method doens't work to insert new values without reseting the defaults
		-- require("lualine").setup({
		-- 	options = { theme = "dracula" },
		-- 	sections = {
		-- 		lualine_b = { "branch", "diff", "diagnostics",
  --           {
		-- 				"macro-recording",
		-- 				fmt = show_macro_recording,
		-- 			  }
  --       },
		-- 	},
		-- })
		--

		vim.api.nvim_create_autocmd("RecordingEnter", {
			callback = function()
				lualine.refresh({
					place = { "statusline" },
				})
			end,
		})

		vim.api.nvim_create_autocmd("RecordingLeave", {
			callback = function()
				-- This is going to seem really weird!
				-- Instead of just calling refresh we need to wait a moment because of the nature of
				-- `vim.fn.reg_recording`. If we tell lualine to refresh right now it actually will
				-- still show a recording occuring because `vim.fn.reg_recording` hasn't emptied yet.
				-- So what we need to do is wait a tiny amount of time (in this instance 50 ms) to
				-- ensure `vim.fn.reg_recording` is purged before asking lualine to refresh.
				--
				local timer = vim.loop.new_timer()
				timer:start(
					50,
					0,
					vim.schedule_wrap(function()
						lualine.refresh({
							place = { "statusline" },
						})
					end)
				)
			end,
		})
	end,
}
