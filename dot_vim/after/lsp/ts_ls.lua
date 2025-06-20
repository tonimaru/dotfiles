---@type vim.lsp.Config
return {
    init_options = {
        provideFormatter = false,
    },
    root_markers = {
        'package.json',
    },
    workspace_required = true,
}
