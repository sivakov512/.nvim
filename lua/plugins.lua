require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use 'doums/darcula'

    use 'tpope/vim-surround'
    use 'terrortylor/nvim-comment'
    use 'cohama/lexima.vim'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    use 'aklt/plantuml-syntax'
    use 'weirongxu/plantuml-previewer.vim'

    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        },
    }
    use 'tyru/open-browser.vim'

    use 'neovim/nvim-lspconfig'
    use {
        'nvimtools/none-ls.nvim',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvimtools/none-ls-extras.nvim' },
        },
    }
    use 'ray-x/lsp_signature.nvim'
    use 'vim-test/vim-test'
end)

require('telescope').load_extension('fzf')
