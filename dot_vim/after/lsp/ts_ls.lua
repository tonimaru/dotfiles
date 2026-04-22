---@type vim.lsp.Config
return {
    on_init = function(client)
        client.server_capabilities.documentFormattingProvider = false
    end,
    init_options = {
        provideFormatter = false,
    },
    root_markers = {
        'package.json',
    },
    workspace_required = true,
}
