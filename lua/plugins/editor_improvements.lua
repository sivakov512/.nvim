return {
    { "tpope/vim-surround" },
    {
        "terrortylor/nvim-comment",
        config = function()
            require('nvim_comment').setup {
                create_mappings = false,
            }
        end
    },
    { "cohama/lexima.vim" },
    {
        "NeogitOrg/neogit",
        dependencies = {
            'nvim-lua/plenary.nvim',
            'sindrets/diffview.nvim',
            'nvim-telescope/telescope.nvim',
        },
        config = function()
            require('neogit').setup {}
        end,
    },
}
