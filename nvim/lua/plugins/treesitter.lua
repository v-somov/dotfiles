require("nvim-treesitter.configs").setup({
  indent = {
    enable = true,
  },
  ensure_installed = {
    "ruby",
    "javascript",
    "typescript",
    "tsx",
    "lua",
    "json",
    "jsonc",
    "yaml",
    "graphql",
  },
  highlight = { enable = false },
  -- plugins
  autopairs = { enable = true },
  context_commentstring = {
    enable = true,
  },
  textsubjects = {
    enable = true,
    keymaps = {
        ["."] = "textsubjects-smart",
        [","] = "textsubjects-container-outer",
    },
  },
  matchup = {
    enable = true,
  },
  autotag = {
    enable = true,
  }
})
