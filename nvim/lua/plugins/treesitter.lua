require("nvim-treesitter.configs").setup({
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  ensure_installed = {
    "ruby",
    "javascript",
    "typescript",
    "tsx",
    "go",
    "lua",
    "json",
    "jsonc",
    "yaml",
    "graphql",
    "bash",
    "css",
    "html",
  },
  highlight = {
    enable = true,
    disable = { "ruby" },
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    disable = { "ruby", "yaml" },
  },
  matchup = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      disable = { "ruby" }, -- Temporary fix, see: https://is.gd/E00YDa
      lookahead = true,
      keymaps = {
        ["am"] = "@function.outer",
        ["im"] = "@function.inner",
      },
    },
    move = {
      enable = true,
      disable = { "ruby" }, -- Temporary fix, see: https://is.gd/E00YDa
      set_jumps = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
      },
    },
  },
})
