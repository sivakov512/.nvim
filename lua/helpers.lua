local M = {}

M.pseudo_markdown_servers = { "clangd" }

function M.active_pseudo_markdown_server()
    local clients = vim.lsp.get_clients()
    local current_buf = vim.api.nvim_get_current_buf()

    for _, client in ipairs(clients) do
        if client.attached_buffers[current_buf] and vim.tbl_contains(M.pseudo_markdown_servers, client.name) then
            return client.name
        end
    end
    return false
end

function M.convert_markdown(doc)
    if doc and doc.value then
        if M.active_pseudo_markdown_server() then
            doc.value = doc.value:gsub("\\n", "\n")
            doc.value = doc.value:gsub("@brief%s+(.-)\n", "### %1\n\n")
            doc.value = doc.value:gsub("@param%s+(%w+)%s+(.-)\n", "- **`%1`**: %2\n")
            doc.value = doc.value:gsub("@return%s+(.-)\n", "\n**Returns**: %1\n")
            doc.value = doc.value:gsub("@code%s*{c}", "```c\n"):gsub("@endcode", "```\n")
            doc.value = doc.value:gsub("Example Usage:%s*\n```c", "### Example Usage\n\n```c")
            doc.value = doc.value:gsub("\\\\ingroup%s+(%w+)", ""):gsub("\\\\", "")
            doc.value = doc.value:gsub(" +\n", "\n"):gsub("\n\n+", "\n\n")
        end
    end
    return doc
end

function M.fill_completion_item_details(entry)
    if M.active_pseudo_markdown_server() then
        entry.completion_item.labelDetails = entry.completion_item.labelDetails or {}
        if not entry.completion_item.labelDetails.description then
            entry.completion_item.labelDetails.description = entry.completion_item.labelDetails.detail
        end
        entry.completion_item.detail = string.format("%s %s", entry.completion_item.detail,
            entry.completion_item.labelDetails.description)
    end
end

return M
