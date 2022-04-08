return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use 'doums/darcula'

    use 'tpope/vim-surround'
    use 'cohama/lexima.vim'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
end)
