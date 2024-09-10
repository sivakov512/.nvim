local lsp_on_attach = function(_, bufnr)
    local nmap = function(lhs, rhf)
        vim.keymap.set("n", lhs, rhf, { buffer = bufnr, silent = true, noremap = true })
    end

    vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

    for _, goto_declaration_cmd in pairs { "gD", "<C-}>" } do
        nmap(goto_declaration_cmd, vim.lsp.buf.declaration)
    end
    for _, goto_definition_cmd in pairs { "gd", "<C-]>" } do
        nmap(goto_definition_cmd, vim.lsp.buf.definition)
    end
    nmap("K", vim.lsp.buf.hover)
    nmap("gi", vim.lsp.buf.implementation)
    nmap("<C-k>", vim.lsp.buf.signature_help)
    nmap("gt", vim.lsp.buf.type_definition)
    nmap("<leader>rn", vim.lsp.buf.rename)
    nmap("<leader>ca", vim.lsp.buf.code_action)
    nmap("gr", vim.lsp.buf.references)
    nmap("<leader>i", function()
        vim.lsp.buf.format()
    end)

    require("lsp_signature").on_attach {
        bind = true,
        handler_opts = {
            border = "single",
        },
        hint_prefix = "",
        padding = " ",
    }
end

require("lsp_signature").status_line(80)

for _, lsp in pairs { "clangd", "gopls", "lua_ls", "pylsp", "rust_analyzer", "sourcekit" } do
    local args = {
        on_attach = lsp_on_attach,
        flags = {
            debounce_text_changes = 150,
        },
    }
    if (lsp == "lua_ls")
    then
        args["settings"] = {
            Lua = {
                completion = { keywordSnippet = "Disable" },
                runtime = "LuaJIT",
                workspace = {
                    checkThirdParty = "Disable",
                    library = vim.api.nvim_get_runtime_file("", true)
                }
            }
        }
    elseif (lsp == "rust_analyzer")
    then
        args["settings"] = {
            ["rust-analyzer"] = {
                cargo = { buildScripts = { enable = true } },
                check = { allTargets = false, command = "clippy" },
            },
        }
    end

    require("lspconfig")[lsp].setup(args)
end

local null_ls = require("null-ls")
null_ls.setup {
    temp_dir = "/tmp",
    sources = {
        -- python
        require("none-ls.diagnostics.ruff"),
        null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        -- yaml, json
        null_ls.builtins.diagnostics.yamllint,
        null_ls.builtins.formatting.prettier,
        -- golang
        null_ls.builtins.diagnostics.golangci_lint,
        null_ls.builtins.formatting.gofmt,
        null_ls.builtins.formatting.goimports,
        -- c, cpp
        null_ls.builtins.formatting.clang_format,
        -- protobuf
        null_ls.builtins.diagnostics.buf,
        null_ls.builtins.diagnostics.protolint,
        null_ls.builtins.formatting.buf,
        null_ls.builtins.formatting.protolint,
    },
    on_attach = lsp_on_attach,
}
