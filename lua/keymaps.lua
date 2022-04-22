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


local lsp_on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    for _, goto_declaration_cmd in pairs { 'gD', '<C-[>' } do
        vim.api.nvim_buf_set_keymap(bufnr, 'n', goto_declaration_cmd, '<cmd>lua vim.lsp.buf.declaration()<CR>', default_opts)
    end
    for _, goto_definition_cmd in pairs { 'gd', '<C-]>' } do
        vim.api.nvim_buf_set_keymap(bufnr, 'n', goto_definition_cmd, '<cmd>lua vim.lsp.buf.definition()<CR>', default_opts)
    end
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', default_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', default_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', default_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', default_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', default_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', default_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', default_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>i', '<cmd>lua vim.lsp.buf.formatting()<CR>', default_opts)
end

for _, lsp in pairs { 'pylsp' } do
  require('lspconfig')[lsp].setup {
    on_attach = lsp_on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end


map('n', [[<C-\>]], '<cmd>CommentToggle<cr>j', default_opts)
map('v', [[<C-\>]], [[:CommentToggle<cr>]], default_opts)
