local map, map_opts = require("helpers").unpack({ "map", "map_opts" })

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
    {
        "vim-test/vim-test",
        config = function()
            vim.g["test#strategy"] = "neovim"

            map("n", "<C-k>f", [[:TestFile<cr>]], map_opts)
            map("n", "<C-k>l", [[:TestLast<cr>]], map_opts)
            map("n", "<C-k>n", [[:TestNearest<cr>]], map_opts)
            map("n", "<C-k><C-k>", [[:TestNearest<cr>]], map_opts)
            map("n", "<C-k>k", [[:TestNearest<cr>]], map_opts)
            map("n", "<C-k>s", [[:TestSuite<cr>]], map_opts)
        end
    },
}
