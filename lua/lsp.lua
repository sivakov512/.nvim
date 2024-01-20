local util = require('vim.lsp.util')

local lsp_on_attach = function(client, bufnr)
    local nmap = function(lhs, rhf)
        vim.keymap.set('n', lhs, rhf, { buffer = bufnr, silent = true, noremap = true })
    end

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    for _, goto_declaration_cmd in pairs { 'gD', '<C-}>' } do
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
    nmap('<leader>i', function()
        vim.lsp.buf.format { async = true }
    end, opts)

    require('lsp_signature').on_attach {
        handler_opts = {
            border = 'none',
        }
    }
end

for _, lsp in pairs { 'pylsp', 'gopls', 'rust_analyzer' } do
  require('lspconfig')[lsp].setup {
    on_attach = lsp_on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    settings = {
        ['rust-analyzer'] = {
            cargo = {buildScripts = {enable = true}},
            check = {allTargets = true, command = 'clippy'}},
    },
  }
end
