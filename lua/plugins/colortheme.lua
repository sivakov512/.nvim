return {
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = function()
            require("gruvbox").setup({
                bold = false
            })
            vim.cmd("colorscheme gruvbox")
        end
    }
}
