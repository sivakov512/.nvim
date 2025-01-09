local map, map_opts = require("helpers").unpack({ "map", "map_opts" })

return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make"
            },
        },
        config = function()
            map("n", "<C-b>", [[<cmd>lua require("telescope.builtin").buffers()<cr>]], map_opts)
            map("n", "<C-f>", [[<cmd>lua require("telescope.builtin").find_files()<cr>]], map_opts)
            map("n", "<C-s>", [[<cmd>lua require("telescope.builtin").live_grep()<cr>]], map_opts)
            map("n", "<C-e>", [[<cmd>lua require("telescope.builtin").diagnostics()<cr>]], map_opts)
        end
    },
    {
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup {
                columns = { "icon", "permissions", "size", "mtime" },
                view_options = { show_hidden = true },
            }
        end
    },
}
