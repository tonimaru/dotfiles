local function lsp_buf_keymap(bufnr)
    local float_opts = {
        focusable = true,
        close_events = { "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre" },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
    }
    local map_opts = {
        buffer = bufnr,
        noremap = true,
        silent = true
    }
    vim.keymap.set('n', '<c-]>', function() vim.lsp.buf.definition() end, map_opts)
    vim.keymap.set('n', 'gl', function() vim.diagnostic.open_float(float_opts) end, map_opts)
    vim.keymap.set('n', 'gd', function() vim.lsp.buf.declaration() end, map_opts)
    vim.keymap.set('n', 'gD', function() vim.lsp.buf.definition() end, map_opts)
    vim.keymap.set('n', 'gI', function() vim.lsp.buf.implementation() end, map_opts)
    vim.keymap.set('n', 'gT', function() vim.lsp.buf.type_definition() end, map_opts)
    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover(float_opts) end, map_opts)
    vim.keymap.set('n', '[prefix]lr', function() vim.lsp.buf.rename() end, map_opts)
    vim.keymap.set('n', '<c-p>', function() vim.diagnostic.jump({ count = -1, float = true }) end, map_opts)
    vim.keymap.set('n', '<c-n>', function() vim.diagnostic.jump({ count = 1, float = true }) end, map_opts)
    vim.keymap.set('n', '==', function() vim.lsp.buf.format() end, map_opts)

    if (vim.fn.exists("*ddu#start")) then
        vim.keymap.set('n', 'go', '<cmd>call ddu#start(#{ sources: [#{ name: "lsp_documentSymbol" }] })<CR>', map_opts)
        vim.keymap.set('n', 'gR', '<cmd>call ddu#start(#{ sources: [#{ name: "lsp_references" }] })<CR>', map_opts)
        vim.keymap.set('n', 'gw', '<cmd>call ddu#start(#{ sources: [#{ name: "lsp_workspaceSymbol" }] })<CR>', map_opts)
        vim.keymap.set('n', '[prefix]la',
            '<cmd>call ddu#start(#{sources: [#{ name: "lsp_codeAction" }], kindOptions: #{ lsp_codeAction: #{defaultAction: "apply" }}})<CR>',
            map_opts)
    else
        vim.keymap.set('n', 'go', function() vim.lsp.buf.document_symbol() end, map_opts)
        vim.keymap.set('n', 'gR', function() vim.lsp.buf.references() end, map_opts)
        vim.keymap.set('n', 'gw', function() vim.lsp.buf.workspace_symbol() end, map_opts)
        vim.keymap.set('n', '[prefix]la', function() vim.lsp.buf.code_action() end, map_opts)
    end
end

local function on_attach(_, bufnr)
    local success, is_attached = pcall(vim.api.nvim_buf_get_var, bufnr, 'is_nivm_lsp_attached')
    if success and is_attached or false then
        return
    end
    vim.api.nvim_buf_set_var(bufnr, 'is_nivm_lsp_attached', true)

    local function buf_set_option(k, v) vim.api.nvim_set_option_value(k, v, { buf = bufnr }) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    lsp_buf_keymap(bufnr)
end

vim.api.nvim_create_autocmd("LspAttach", {
    group = "my_vimrc",
    callback = function(args)
        local buf = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        on_attach(client, buf)
    end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config('*', {
    capabilities = capabilities
})

vim.lsp.enable({
    'buf_ls',
    'denols',
    'gopls',
    'lua_ls',
    'rust_analyzer',
    'sqls',
    'ts_ls',
    'vimls',
    'yamlls',
})
