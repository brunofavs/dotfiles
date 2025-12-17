return{
     -- Filetypes to automatically attach to.
     filetypes = { 'tex', 'md', 'txt' },

        settings = {
              ltex = {
                  additionalRules = {
                      languageModel = "~/.config/nvim/ngrams_ltex/", -- Specify the path to the language model
                  },
              },
        },
  }
