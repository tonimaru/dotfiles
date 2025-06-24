local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local function lsp_buf_keymap(bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    local opts = { noremap = true, silent = true }
    buf_set_keymap('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)

    buf_set_keymap('n', 'gl', '<cmd>lua vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'gT', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '[prefix]lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<c-p>', '<cmd>lua vim.diagnostic.goto_prev({float=false})<CR>', opts)
    buf_set_keymap('n', '<c-n>', '<cmd>lua vim.diagnostic.goto_next({float=false})<CR>', opts)
    buf_set_keymap('n', '==', '<cmd>lua vim.lsp.buf.format()<CR>', opts)

    if (vim.fn.exists("*ddu#start")) then
        buf_set_keymap('n', 'go', '<cmd>call ddu#start(#{ sources: [#{ name: "lsp_documentSymbol" }] })<CR>', opts)
        buf_set_keymap('n', 'gR', '<cmd>call ddu#start(#{ sources: [#{ name: "lsp_references" }] })<CR>', opts)
        buf_set_keymap('n', 'gw', '<cmd>call ddu#start(#{ sources: [#{ name: "lsp_workspaceSymbol" }] })<CR>', opts)
        buf_set_keymap('n', '[prefix]la',
            '<cmd>call ddu#start(#{sources: [#{ name: "lsp_codeAction" }], kindOptions: #{ lsp_codeAction: #{defaultAction: "apply" }}})<CR>',
            opts)
    else
        buf_set_keymap('n', 'go', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
        buf_set_keymap('n', 'gR', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        buf_set_keymap('n', 'gw', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
        buf_set_keymap('n', '[prefix]la', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    end
end

local function on_attach(client, bufnr)
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

vim.lsp.config('*', {
    capabilities = capabilities
})

vim.lsp.enable({
    'buf_ls',
    'denols',
    'gopls',
    'lua_ls',
    'sqls',
    'ts_ls',
    'vimls',
    'yamlls',
})
