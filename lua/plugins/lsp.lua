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
            "L3MON4D3/LuaSnip",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
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
                mapping = {
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-x><C-o>"] = cmp.mapping.complete(),
                    ["<C-n>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<C-p>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<C-e>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.abort()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping.confirm({ select = true }),
                },
                sources = cmp.config.sources({
                    { name = "luasnip" },
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                }),
                experimental = {
                    ghost_text = true,
                },
            })
        end
    },
    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        config = function()
            local lusanip = require("luasnip")

            for _, kmp in pairs { "<C-k>", "<Tab>" } do
                vim.keymap.set({ "i", "s" }, kmp, function()
                    if lusanip.expand_or_jumpable() then
                        lusanip.expand_or_jump()
                    else
                        return kmp
                    end
                end, { silent = true, expr = true })
            end

            for _, kmp in pairs { "<C-j>", "<S-Tab>" } do
                vim.keymap.set({ "i", "s" }, kmp, function()
                    if lusanip.jumpable(-1) then
                        lusanip.jump(-1)
                    else
                        return kmp
                    end
                end, { silent = true, expr = true })
            end

            vim.keymap.set({ "i", "s" }, "<C-E>", function()
                if lusanip.choice_active() then
                    lusanip.change_choice(1)
                end
            end, { silent = true })
        end
    }
}
