local util = require('vim.lsp.util')

local lsp_on_attach = function(client, bufnr)
    local nmap = function(lhs, rhf)
        vim.keymap.set('n', lhs, rhf, { buffer = bufnr, silent = true, noremap = true })
    end

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    for _, goto_declaration_cmd in pairs { 'gD', '<C-[>' } do
        nmap(goto_declaration_cmd, vim.lsp.buf.declaration)
    end
    for _, goto_definition_cmd in pairs { 'gd', '<C-]>' } do
        nmap(goto_definition_cmd, vim.lsp.buf.definition)
    end
    nmap('K', vim.lsp.buf.hover)
    nmap('gi', vim.lsp.buf.implementation)
    nmap('<C-k>', vim.lsp.buf.signature_help)
    nmap('gt', vim.lsp.buf.type_definition)
    nmap('<leader>rn', vim.lsp.buf.rename)
    nmap('<leader>ca', vim.lsp.buf.code_action)
    nmap('gr', vim.lsp.buf.references)

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
