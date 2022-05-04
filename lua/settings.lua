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
    ensure_installed = 'all',
    ignore_install = { 'phpdoc' },
    highlight = { enable = true },
    textobjects = { enable = true },
    indent = { enable = false },  -- https://github.com/nvim-treesitter/nvim-treesitter/issues/1136
}


require('nvim_comment').setup {
    create_mappings = false,
}


local null_ls = require('null-ls')
null_ls.setup {
    sources = {
        -- python
        null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.black,
        null_ls.builtins.diagnostics.mypy,
        -- yaml, json
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.diagnostics.yamllint,
        null_ls.builtins.diagnostics.jsonlint,
        -- golang
        null_ls.builtins.diagnostics.golangci_lint,
        null_ls.builtins.formatting.gofmt,
        null_ls.builtins.formatting.goimports,
        -- lua
        null_ls.builtins.diagnostics.luacheck,
        -- protobuf
        null_ls.builtins.diagnostics.protolint,
        null_ls.builtins.formatting.protolint,
    }
}
