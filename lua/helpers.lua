local M = {}

--
-- for more stylish require

function M.unpack(keys)
    local unpack = table.unpack or unpack

    local values = {}
    for _, key in ipairs(keys) do
        table.insert(values, M[key])
    end
    return unpack(values)
end

--
-- Keymap helpers

M.map = vim.api.nvim_set_keymap

M.map_opts = { noremap = true, silent = true }


return M
