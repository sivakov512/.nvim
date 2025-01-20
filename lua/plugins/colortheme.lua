return {
    {
        "ellisonleao/gruvbox.nvim",
        -- lazy = false,
        priority = 1000,
        config = function()
            require("gruvbox").setup({
                bold = false
            })
            vim.cmd("colorscheme gruvbox")
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            local lualine = require('lualine')
            local separator = lualine.get_config().options.component_separators.left or ''

            lualine.setup({
                options = { theme = "auto" },
                sections = {
                    lualine_c = {
                        function()
                            local ok, winbar = pcall(require('lspsaga.symbol.winbar').get_bar)
                            if ok and winbar ~= nil then
                                return winbar .. ' ' .. separator
                            end
                            return ''
                        end,
                    },
                }
            })

            vim.o.showmode = false
        end
    }
}
