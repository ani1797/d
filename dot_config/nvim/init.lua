-- Neovim configuration entry point
-- Plugin manager: lazy.nvim
-- Structure: lua/config/ for settings, lua/plugins/ for plugin specs

-- Bootstrap lazy.nvim and load config
require("config.options")
require("config.lazy")

-- Keymaps and autocommands load after plugins (via lazy.nvim events)
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("config.keymaps")
    require("config.autocmds")
  end,
})
