require('packer').startup(function(use)
    -- Plugin manager
    use 'wbthomason/packer.nvim'

    -- Color theme
    use {
        'ellisonleao/gruvbox.nvim',
        config = function()
            vim.cmd([[colorscheme gruvbox]])
        end
    }

    -- Editor improvemenets
    use 'tpope/vim-surround'
    use {
        'terrortylor/nvim-comment',
        config = function()
            require('nvim_comment').setup {
                create_mappings = false,
            }
        end
    }
    use 'cohama/lexima.vim'
    use {
        'NeogitOrg/neogit',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'sindrets/diffview.nvim' },
            { 'nvim-telescope/telescope.nvim' },
        },
        config = function()
            require('neogit').setup {}
        end,
    }

    -- LSP
    use 'neovim/nvim-lspconfig'
    use {
        'nvimtools/none-ls.nvim',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvimtools/none-ls-extras.nvim' },
        },
    }
    use 'ray-x/lsp_signature.nvim'

    -- Extra syntax and languages
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                auto_install = true,
                highlight = { enable = true },
                incremental_selection = { enable = true },
                textobjects = { enable = true },
            }
        end
    }
    use {
        'vim-test/vim-test',
        config = function()
            vim.g['test#strategy'] = "neovim"
        end
    }

    -- Search and navigation
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        },
    }
    use {
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup {
                columns = { "icon", "permissions", "size", "mtime" },
                view_options = { show_hidden = true },
            }
        end
    }
end)

require('telescope').load_extension('fzf')
