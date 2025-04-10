local map, map_opts = require("helpers").unpack({ "map", "map_opts" })

return {
    { "tpope/vim-surround" },
    {
        "terrortylor/nvim-comment",
        config = function()
            require("nvim_comment").setup {
                create_mappings = false,
            }

            map("n", [[<C-\>]], "<cmd>CommentToggle<cr>j", map_opts)
            map("v", [[<C-\>]], [[:CommentToggle<cr>]], map_opts)
        end
    },
    { "cohama/lexima.vim" },
}
