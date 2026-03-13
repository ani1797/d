-- Treesitter: syntax highlighting, text objects, indent
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local ensure = {
        "bash",
        "c",
        "css",
        "diff",
        "dockerfile",
        "fish",
        "gitcommit",
        "gitignore",
        "go",
        "html",
        "javascript",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "rust",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      }

      -- Install missing parsers
      local installed = require("nvim-treesitter.install").installed_parsers()
      local to_install = vim.tbl_filter(function(lang)
        return not vim.tbl_contains(installed, lang)
      end, ensure)
      if #to_install > 0 then
        vim.cmd("TSInstall " .. table.concat(to_install, " "))
      end

      -- Enable treesitter highlight and indent
      vim.treesitter.start = vim.treesitter.start or function() end
    end,
  },
}
