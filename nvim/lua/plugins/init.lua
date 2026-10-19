local fn = vim.fn
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Core plugin manager itself
  { "folke/lazy.nvim" },

  -- Utility plugins
  "vim-scripts/copypath.vim",
  "hashivim/vim-terraform",
  "tpope/vim-eunuch",
  "tpope/vim-surround",
  "tpope/vim-sleuth",
  "tpope/vim-unimpaired",
  {
    "tpope/vim-fugitive",
    config = function()
      local u = require("config.utils")
      u.augroup("VimFugitive", "BufReadPost", "fugitive://* ", "set bufhidden=delete")
    end,
  },

  "google/vim-searchindex",
  "christoomey/vim-tmux-navigator",
  "jszakmeister/vim-togglecursor",
  "godlygeek/tabular",

  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
  },
  { "lifepillar/vim-solarized8", branch = "neovim" },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "calind/selenized.nvim", priority = 1000 },
  -- Follows the macOS appearance live, like Ghostty and herdr.
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      set_dark_mode = function()
        vim.o.background = "dark"
        vim.cmd.colorscheme("catppuccin-macchiato")
      end,
      set_light_mode = function()
        vim.o.background = "light"
        vim.cmd.colorscheme("selenized")
      end,
      update_interval = 3000,
    },
  },

  {
    "tamago324/lir.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = {
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      require("plugins.fzf")
    end,
  },

  {
    "RRethy/vim-illuminate",
    lazy = false,
    keys = {
      {
        "<A-n>",
        '<cmd>lua require"illuminate".next_reference{wrap=true}<CR>',
        desc = "Next reference",
      },
      {
        "<A-p>",
        '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<CR>',
        desc = "Previous reference",
      },
    },
  },

  {
    "tpope/vim-projectionist",
    config = function()
      require("plugins.projectionist")
    end,
  },
  "theprimeagen/harpoon",
  "theprimeagen/refactoring.nvim",
  "mbbill/undotree",
  "towolf/vim-helm",
  "windwp/nvim-ts-autotag",

  "RRethy/nvim-treesitter-endwise",
  -- Treesitter plugins
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- main branch does not support lazy-loading
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "bash",
        "c",
        "diff",
        "html",
        "css",
        "ruby",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
        "embedded_template",
        "go",
      })
      vim.treesitter.language.register("json", "jsonc")

      -- Highlighting and indentation for every filetype with an installed parser
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(ev)
          if not pcall(vim.treesitter.start, ev.buf) then
            return
          end
          vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      -- Incremental selection (built into Neovim 0.12)
      vim.keymap.set({ "n", "x" }, "<C-space>", function()
        vim.treesitter.select("parent", vim.v.count1)
      end, { desc = "Increment Selection" })
      vim.keymap.set("x", "<bs>", function()
        vim.treesitter.select("child", vim.v.count1)
      end, { desc = "Decrement Selection" })
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  { "JoosepAlviste/nvim-ts-context-commentstring", ft = { "typescript", "typescriptreact" } },

  -- LSP plugins
  "nvim-lua/plenary.nvim",
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
    },
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      -- Autocompletion
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",

      -- Snippets
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    opts = {},
    config = function()
      require("mason-lspconfig").setup({
        automatic_enable = false,
        ensure_installed = {
          "ts_ls",
          "gopls",
          "lua_ls",
          "ruby_lsp",
          "jsonls",
          -- "yamlls",
          "html",
          "cssls",
          "bashls",
          "dockerls",
        },
      })
      require("mason-tool-installer").setup({
        ensure_installed = {
          "prettierd",
          "prettier",
          "stylua",
          "gofumpt",
          "goimports",
          "isort",
        },
        run_on_start = true,
      })
    end,
  },

  {
    "github/copilot.vim",
    config = function()
      vim.keymap.set("i", "<C-j>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
        desc = "Accept Copilot suggestion",
      })
    end,
  },
  {
    "Vigemus/iron.nvim",
  },
  {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
      require("plugins.conform")
    end,
  },
  {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
      require("plugins.mini")
    end,
  },
  -- lazy.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      -- "rcarriga/nvim-notify",
    },
    config = function()
      require("plugins.noice")
    end,
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = vim.fn.expand("~/Library/Mobile Documents/com~apple~CloudDocs/personal-vault/personal"),
        },
        {
          name = "work",
          path = vim.fn.expand("~/Library/Mobile Documents/com~apple~CloudDocs/personal-vault/work"),
        },
      },

      -- see below for full list of options 👇
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>.",
        function()
          Snacks.scratch()
        end,
        desc = "Toggle Scratch Buffer",
      },
      {
        "<leader>Z",
        function()
          Snacks.zen()
        end,
        desc = "Toggle Zen Mode",
      },
      {
        "<leader>z",
        function()
          Snacks.zen.zoom()
        end,
        desc = "Toggle Zoom",
      },
      {
        "<leader>bd",
        function()
          Snacks.bufdelete()
        end,
        desc = "Delete Buffer",
      },
      {
        "<leader>S",
        function()
          Snacks.scratch.select()
        end,
        desc = "Select Scratch Buffer",
      },
      {
        "<leader><space>",
        function()
          Snacks.picker.smart()
        end,
        desc = "Smart Find Files",
      },
      {
        "<leader>:",
        function()
          Snacks.picker.command_history()
        end,
        desc = "Command History",
      },
      {
        "<leader>n",
        function()
          Snacks.picker.notifications()
        end,
        desc = "Notification History",
      },
      {
        "<leader>e",
        function()
          Snacks.explorer()
        end,
        desc = "File Explorer",
      },
      -- find
      {
        "<leader>fp",
        function()
          Snacks.picker.projects()
        end,
        desc = "Projects",
      },
      -- git
      {
        "<leader>gl",
        function()
          Snacks.picker.git_log()
        end,
        desc = "Git Log",
      },
      {
        "<leader>gL",
        function()
          Snacks.picker.git_log_line()
        end,
        desc = "Git Log Line",
      },
      {
        "<leader>gs",
        function()
          Snacks.picker.git_status()
        end,
        desc = "Git Status",
      },
      {
        "<leader>gS",
        function()
          Snacks.picker.git_stash()
        end,
        desc = "Git Stash",
      },
      {
        "<leader>gf",
        function()
          Snacks.picker.git_log_file()
        end,
        desc = "Git Log File",
      },
      -- Grep
      {
        "<leader>sB",
        function()
          Snacks.picker.grep_buffers()
        end,
        desc = "Grep Open Buffers",
      },
      -- search
      {
        '<leader>s"',
        function()
          Snacks.picker.registers()
        end,
        desc = "Registers",
      },
      {
        "<leader>s/",
        function()
          Snacks.picker.search_history()
        end,
        desc = "Search History",
      },
      {
        "<leader>sa",
        function()
          Snacks.picker.autocmds()
        end,
        desc = "Autocmds",
      },
      {
        "<leader>sd",
        function()
          Snacks.picker.diagnostics()
        end,
        desc = "Diagnostics",
      },
      {
        "<leader>sD",
        function()
          Snacks.picker.diagnostics_buffer()
        end,
        desc = "Buffer Diagnostics",
      },
      {
        "<leader>sH",
        function()
          Snacks.picker.highlights()
        end,
        desc = "Highlights",
      },
      {
        "<leader>si",
        function()
          Snacks.picker.icons()
        end,
        desc = "Icons",
      },
      {
        "<leader>sj",
        function()
          Snacks.picker.jumps()
        end,
        desc = "Jumps",
      },
      {
        "<leader>sk",
        function()
          Snacks.picker.keymaps()
        end,
        desc = "Keymaps",
      },
      {
        "<leader>sM",
        function()
          Snacks.picker.man()
        end,
        desc = "Man Pages",
      },
      {
        "<leader>sR",
        function()
          Snacks.picker.resume()
        end,
        desc = "Resume",
      },
      {
        "<leader>uC",
        function()
          Snacks.picker.colorschemes()
        end,
        desc = "Colorschemes",
      },
      -- LSP
      {
        "<leader>sS",
        function()
          Snacks.picker.lsp_workspace_symbols()
        end,
        desc = "LSP Workspace Symbols",
      },
    },
    opts = {
      scratch = { enabled = true },
      picker = {
        enabled = true,
        -- Match the in-picker keys of fzf-lua
        win = {
          input = {
            keys = {
              ["<C-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
              ["<C-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
              ["<C-e>"] = { "toggle_preview", mode = { "i", "n" } },
            },
          },
        },
      },
      zen = { enabled = true },
      toggle = { enabled = true },
      styles = {
        scratch = {
          width = 0.6,
          height = 0.4,
        },
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    optional = true,
    keys = {
      {
        "<leader>st",
        function()
          Snacks.picker.todo_comments()
        end,
        desc = "Todo",
      },
      {
        "<leader>sT",
        function()
          Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
        end,
        desc = "Todo/Fix/Fixme",
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({})
    end,
  },
  require("plugins.lazygit"),
})

