---@type vim.lsp.Config
return {
    init_options = {
        provideFormatter = false,
        unstable = true,
        suggest = {
            imports = {
                hosts = {
                    ["https://deno.land"] = true,
                    ["https://cdn.nest.land"] = true,
                    ["https://crux.land"] = true,
                },
            },
        },
    },
    single_file_support = true,
    root_markers = {
        'deno.json',
        'deno.jsonc',
        'deps.ts',
    },
    workspace_required = true,
}
