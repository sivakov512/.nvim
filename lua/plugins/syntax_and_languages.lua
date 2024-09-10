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
        end
    },
    {
        "vim-test/vim-test",
        config = function()
            vim.g["test#strategy"] = "neovim"
        end
    },
}
