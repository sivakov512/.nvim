return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup {
                auto_install = true,
                highlight = { enable = true },
                incremental_selection = { enable = true },
                textobjects = { enable = true },
            }

            vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        end
    },
}
