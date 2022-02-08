vim.cmd("packadd packer.nvim")
return require("packer").startup(function()
    use({ "wbthomason/packer.nvim", opt = true })

    local config = function(name)
        return string.format("require('plugins.%s')", name)
    end

    local use_with_config = function(path, name)
        use({ path, config = config(name) })
    end

    use({
        "ibhagwan/fzf-lua", -- fzf plugin with lua api
        requires = {
            "vijaymarupudi/nvim-fzf",
            "kyazdani42/nvim-web-devicons",
        },
        config = config("fzf"),
    })
    -- lsp
    use("neovim/nvim-lspconfig") -- makes lsp configuration easier
    use_with_config("RRethy/vim-illuminate", "illuminate") -- highlights and allows moving between variable references
    -- use("jose-elias-alvarez/null-ls.nvim") -- allows using neovim as language server
    use({
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require("null-ls").setup()
        end,
        requires = { "nvim-lua/plenary.nvim" },
    })

    use("junegunn/vim-peekaboo")

    -- development
    use("jose-elias-alvarez/nvim-lsp-ts-utils") -- improve typescript experience

    -- use("MunifTanjim/nui.nvim")
    -- use_with_config("vuki656/package-info.nvim", "package-info") -- show versions in package.json

    use("windwp/nvim-ts-autotag")

    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    }

    -- treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = config("treesitter"),
    })
    use({
        "RRethy/nvim-treesitter-textsubjects", -- adds smart text objects
        ft = { "lua", "typescript", "typescriptreact", "ruby" },
    })
    use({ "JoosepAlviste/nvim-ts-context-commentstring", ft = { "typescript", "typescriptreact" } }) -- makes jsx comments actually work
      
    -- use {
      -- "code-biscuits/nvim-biscuits",
      -- config = function()
        -- require("nvim-biscuits").setup {
        -- }
      -- end
    -- }
    -- use({
        -- "nvim-telescope/telescope.nvim",
        -- config = config("telescope"),
        -- requires = { { "nvim-telescope/telescope-fzy-native.nvim", run = "make" } },
    -- })

    -- telescope dependencies
    -- use('nvim-lua/popup.nvim')
    use('nvim-lua/plenary.nvim')

end)
