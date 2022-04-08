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


require('nvim-treesitter.configs').setup {
    ensure_installed = 'all',
    highlight = { enable = true },
    textobjects = { enable = true },
    indent = { enable = true },
}
