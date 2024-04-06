local opt = vim.opt
local cmd = vim.cmd


cmd('colorscheme darcula')
opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.scrolloff = 5

opt.undofile = true
opt.exrc = true

cmd([[
filetype indent plugin on
syntax enable
]])
local tab_width = 4
opt.expandtab = true
opt.shiftwidth = tab_width
opt.tabstop = tab_width
opt.smartindent = true

opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.foldlevel = 99

opt.completeopt = 'menu'


require('nvim-treesitter.configs').setup {
    ensure_installed = {
        -- Language
        "bash",
        "c",
        "cpp",
        "go",
        "javascript",
        "lua",
        "lua",
        "python",
        "rust",
        "sql",
        "swift",
        "typescript",

        -- Language specific
        "cmake",
        "gomod",
        "gosum",

        -- Formats, tools, instruments
        "css",
        "csv",
        "diff",
        "dockerfile",
        "git_config",
        "gitcommit",
        "gitignore",
        "html",
        "json",
        "make",
        "markdown",
        "scss",
        "toml",
        "tsv",
        "vimdoc",
        "xml",
        "yaml",
    },
    highlight = { enable = true },
    textobjects = { enable = true },
}


require('nvim_comment').setup {
    create_mappings = false,
}

-- vim-test/vim-test
vim.g['test#strategy'] = "neovim"
