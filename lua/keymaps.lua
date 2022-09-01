local map = vim.api.nvim_set_keymap

local default_opts = { noremap = true, silent = true }

vim.g.mapleader = [[\]]

map('n', '<C-b>', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], default_opts)
map('n', '<C-f>', [[<cmd>lua require('telescope.builtin').find_files()<cr>]], default_opts)
map('n', '<C-s>', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], default_opts)
map('n', '<C-e>', [[<cmd>lua require('telescope.builtin').diagnostics()<cr>]], default_opts)

map('n', '<leader>do', [[<cmd>lua vim.diagnostic.open_float()<cr>]], default_opts)
map('n', '<leader>dn', [[<cmd>lua vim.diagnostic.goto_next()<cr>]], default_opts)
map('n', '<leader>dp', [[<cmd>lua vim.diagnostic.goto_prev()<cr>]], default_opts)

map('n', '<leader>e', '<cmd>e %:h<cr>', default_opts)
map('n', ',/', '<cmd>nohlsearch<cr>', default_opts)

map('i', '<C-f>', '<Right>', default_opts)
map('i', '<C-b>', '<Left>', default_opts)
map('i', '<C-p>', '<Up>', default_opts)
map('i', '<C-n>', '<Down>', default_opts)
map('c', '<C-f>', '<Right>', { noremap = true, silent = false })
map('c', '<C-b>', '<Left>', { noremap = true, silent = false })


map('n', [[<C-\>]], '<cmd>CommentToggle<cr>j', default_opts)
map('v', [[<C-\>]], [[:CommentToggle<cr>]], default_opts)

map('n', '<C-k>f', [[:TestFile<cr>]], default_opts)
map('n', '<C-k>l', [[:TestLast<cr>]], default_opts)
map('n', '<C-k>n', [[:TestNearest<cr>]], default_opts)
map('n', '<C-k><C-k>', [[:TestNearest<cr>]], default_opts)
map('n', '<C-k>k', [[:TestNearest<cr>]], default_opts)
map('n', '<C-k>s', [[:TestSuite<cr>]], default_opts)
