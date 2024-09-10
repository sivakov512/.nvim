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
