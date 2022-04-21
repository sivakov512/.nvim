require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use 'doums/darcula'

    use 'tpope/vim-surround'
    use 'cohama/lexima.vim'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        },
    }

    use 'neovim/nvim-lspconfig'
end)

require('telescope').load_extension('fzf')
