local lsp_on_attach, fill_completion_item_details, convert_markdown = require("helpers").unpack({ "lsp_on_attach",
    "fill_completion_item_details", "convert_markdown" })

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            for _, lsp in pairs { "clangd", "gopls", "lua_ls", "pylsp", "rust_analyzer", "sourcekit" } do
                local args = {
                    on_attach = lsp_on_attach,
                    flags = {
                        debounce_text_changes = 150,
                    },
                    capabilities = capabilities,
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
                elseif (lsp == "clangd")
                then
                    args["cmd"] = { "clangd", "--header-insertion=iwyu", "--pretty" }
                end

                require("lspconfig")[lsp].setup(args)
            end
        end
    },
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvimtools/none-ls-extras.nvim",
        },
        config = function()
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
        end
    },
    {
        "ray-x/lsp_signature.nvim",
        opts = {
            bind = true,
            handler_opts = {
                border = "single",
            },
            hint_prefix = "",
            padding = " ",
        },
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end
                },
                formatting = {
                    fields = { "abbr", "kind" },
                    format = function(entry, item)
                        fill_completion_item_details(entry)
                        convert_markdown(entry.completion_item.documentation)
                        return item
                    end
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-x><C-o>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.abort()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                    ["<Tab>"] = cmp.mapping.confirm({ select = false }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                }),
                experimental = {
                    ghost_text = true,
                },
            })
        end
    }
}
