local map = vim.api.nvim_set_keymap

local default_opts = { noremap = true, silent = true }

vim.g.mapleader = [[\]]

map('n', '<C-b>', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], default_opts)
map('n', '<C-f>', [[<cmd>lua require('telescope.builtin').find_files()<cr>]], default_opts)
map('n', '<C-s>', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], default_opts)

map('n', '<leader>e', '<cmd>e %:h<cr>', default_opts)

map('i', '<C-f>', '<Right>', default_opts)
map('i', '<C-b>', '<Left>', default_opts)
map('i', '<C-p>', '<Up>', default_opts)
map('i', '<C-n>', '<Down>', default_opts)


map('n', [[<C-\>]], '<cmd>CommentToggle<cr>j', default_opts)
map('v', [[<C-\>]], [[:CommentToggle<cr>]], default_opts)
