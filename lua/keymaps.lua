local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

map('n', '<C-b>', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], default_opts)
map('n', '<C-f>', [[<cmd>lua require('telescope.builtin').find_files()<cr>]], default_opts)
map('n', '<C-s>', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], default_opts)
