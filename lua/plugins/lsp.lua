return {
    { "neovim/nvim-lspconfig" },
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvimtools/none-ls-extras.nvim",
        },
    },
    {
        "ray-x/lsp_signature.nvim"
    },
}
