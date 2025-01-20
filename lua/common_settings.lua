local map, map_opts = require("helpers").unpack({ "map", "map_opts" })

local opt = vim.opt
local cmd = vim.cmd

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

opt.foldmethod = "expr"
opt.foldlevel = 99

opt.completeopt = "menu"
vim.g.mapleader = [[\]]

map("n", "<leader>do", [[<cmd>lua vim.diagnostic.open_float()<cr>]], map_opts)


map("n", "<leader>e", "<cmd>e %:h<cr>", map_opts)
map("n", ",/", "<cmd>nohlsearch<cr>", map_opts)

map("i", "<C-f>", "<Right>", map_opts)
map("i", "<C-b>", "<Left>", map_opts)
map("i", "<C-p>", "<Up>", map_opts)
map("i", "<C-n>", "<Down>", map_opts)
map("c", "<C-f>", "<Right>", { noremap = true, silent = false })
map("c", "<C-b>", "<Left>", { noremap = true, silent = false })
