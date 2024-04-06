require('packer').startup(function()
    -- Plugin manager
    use 'wbthomason/packer.nvim'

    -- Color theme
    use 'doums/darcula'

    -- Editor improvemenets
    use 'tpope/vim-surround'
    use 'terrortylor/nvim-comment'
    use 'cohama/lexima.vim'

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
        run = ':TSUpdate'
    }
    use 'vim-test/vim-test'

    -- Search and navigation
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        },
    }
end)

require('telescope').load_extension('fzf')
