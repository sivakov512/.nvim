local util = require('vim.lsp.util')
local default_opts = { noremap = true, silent = true }

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

    require('lsp_signature').on_attach {
        handler_opts = {
            border = 'none',
        }
    }
end

for _, lsp in pairs { 'pylsp', 'gopls' } do
  require('lspconfig')[lsp].setup {
    on_attach = lsp_on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

vim.lsp.handlers['textDocument/publishDiagnostics'] = function() end


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
    },
    on_attach = function(client, bufnr)
        vim.keymap.set('n', '<leader>i', function()
            local params = util.make_formatting_params({})
            client.request('textDocument/formatting', params, nil, bufnr)
        end, { buffer = bufnr, silent = true })
    end
}
