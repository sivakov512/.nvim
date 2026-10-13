-- nvim-treesitter was rewritten on the `main` branch, which requires Neovim 0.12+.
-- Older Neovim (e.g. 0.11 from Ubuntu apt) stays on the frozen `master` branch.
local has_main = vim.fn.has("nvim-0.12") == 1

local function setup_main()
    local ts = require("nvim-treesitter")

    local available = {}
    for _, lang in ipairs(ts.get_available()) do
        available[lang] = true
    end
    local installing = {}

    -- Replacement for `auto_install` + `highlight`: install a missing parser on
    -- first use, then start highlighting. Incremental selection is built into
    -- Neovim 0.12 (`an` / `in` in visual mode).
    vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
        callback = function(args)
            local lang = vim.treesitter.language.get_lang(args.match)
            if not lang then
                return
            end

            local function start()
                return vim.api.nvim_buf_is_valid(args.buf) and pcall(vim.treesitter.start, args.buf, lang)
            end

            if start() or not available[lang] or installing[lang] then
                return
            end

            installing[lang] = true
            ts.install(lang):await(function()
                installing[lang] = nil
                vim.schedule(start)
            end)
        end,
    })
end

local function setup_master()
    require("nvim-treesitter.configs").setup {
        auto_install = true,
        highlight = { enable = true },
        incremental_selection = { enable = true },
    }
end

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = has_main and "main" or "master",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            if has_main then
                setup_main()
            else
                setup_master()
            end

            vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        end
    },
}
