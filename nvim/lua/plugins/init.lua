local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_bootstrap = false

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Load packer.nvim
vim.cmd("packadd packer.nvim")

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local u = require('config.utils')

return require("packer").startup(function()
    use({ "wbthomason/packer.nvim", opt = true })

    local config = function(name)
        return string.format("require('plugins.%s')", name)
    end

    local use_with_config = function(path, name)
        use({ path, config = config(name) })
    end

    use 'vim-scripts/copypath.vim'
    use 'hashivim/vim-terraform'
    use 'tpope/vim-eunuch'
    use 'tpope/vim-surround'
    use 'tpope/vim-sleuth'
    use 'tpope/vim-unimpaired'
    use_with_config('tpope/vim-fugitive', 'fugitive')

    use 'vim-ruby/vim-ruby'

    use 'google/vim-searchindex'
    use 'yggdroot/indentline'
    use 'christoomey/vim-tmux-navigator'
    use 'jszakmeister/vim-togglecursor'
    use 'godlygeek/tabular'


    use('scrooloose/nerdcommenter')
      vim.g.NERDSpaceDelims = 1

    use('foosoft/vim-argwrap')
      u.nmap('<leader>a', ':ArgWrap<CR>')

    use {
      'altercation/vim-colors-solarized',
      config = function()
        vim.cmd('colorscheme solarized')
        vim.opt.background = 'light'
      end
    }

    -- use_with_config('justinmk/vim-dirvish', 'dirvish')

    use({
        'tamago324/lir.nvim',
      requires = {
          "kyazdani42/nvim-web-devicons",
      }
    })

    use({
        "ibhagwan/fzf-lua", -- fzf plugin with lua api
        requires = {
            "vijaymarupudi/nvim-fzf",
            "kyazdani42/nvim-web-devicons",
        },
        config = config("fzf"),
    })
    use_with_config("RRethy/vim-illuminate", "illuminate") -- highlights and allows moving between variable references
    use_with_config("tpope/vim-projectionist", "projectionist")
    -- lsp

    -- use("neovim/nvim-lspconfig") -- makes lsp configuration easier

    -- use({
        -- "jose-elias-alvarez/null-ls.nvim",
        -- requires = { "nvim-lua/plenary.nvim" },
        -- config = function()
            -- require("null-ls").setup()
        -- end,
    -- })

    -- use("jose-elias-alvarez/nvim-lsp-ts-utils") -- improve typescript experience

    use("theprimeagen/harpoon")
    use("theprimeagen/refactoring.nvim")
    use("mbbill/undotree")

    use("windwp/nvim-ts-autotag")

    use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v1.x',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},
	  }
  }


    -- treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = config("treesitter"),
    })
    use {
      'RRethy/nvim-treesitter-endwise',
      config = function()
        require('nvim-treesitter.configs').setup {
            highlight = { enable = true },
            endwise = {
                enable = true,
            },
        }
      end
    }
    use({
        "RRethy/nvim-treesitter-textsubjects", -- adds smart text objects
        ft = { "lua", "typescript", "typescriptreact", "ruby" },
    })
    use({ "JoosepAlviste/nvim-ts-context-commentstring", ft = { "typescript", "typescriptreact" } }) -- makes jsx comments actually work
      

    use('nvim-lua/plenary.nvim')

    -- use {
      -- 'hrsh7th/nvim-cmp',
      -- requires = {
        -- { 'onsails/lspkind-nvim' },
        -- { 'hrsh7th/cmp-nvim-lsp' },
        -- { 'hrsh7th/cmp-buffer' },
        -- { 'hrsh7th/cmp-path' },
        -- { 'hrsh7th/cmp-cmdline' },
        -- { 'quangnguyen30192/cmp-nvim-tags' }
      -- },
      -- config = config('cmp'),
    -- }
    use_with_config("nathom/filetype.nvim", "filetype")

    if packer_bootstrap then
      require('packer').sync()
    end
end)

