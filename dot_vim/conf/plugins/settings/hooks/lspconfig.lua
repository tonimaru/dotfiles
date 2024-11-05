--- lua_source {{{
local function lsp_client_settings(client)
    if client.name == 'tsserver' then
        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup({ filter_out_diagnostics_by_code = { 80001 } })
        ts_utils.setup_client(client)
        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false
    elseif client.name == 'eslint' or client.name == 'volar' or client.name == 'intelephense' then
        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false
    end
end

function Ignore_fmts(client)
    local ignore_fmts = { ["tsserver"] = true }
    return not ignore_fmts[client.name]
end

local function lsp_buf_keymap(bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    local opts = { noremap = true, silent = true }
    buf_set_keymap('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)

    buf_set_keymap('n', 'gl', '<cmd>lua vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'gT', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', 'gR', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '[prefix]lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '[prefix]la', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '<c-p>', '<cmd>lua vim.diagnostic.goto_prev({float=false})<CR>', opts)
    buf_set_keymap('n', '<c-n>', '<cmd>lua vim.diagnostic.goto_next({float=false})<CR>', opts)
    buf_set_keymap('n', '==', '<cmd>lua vim.lsp.buf.format({ filter = Ignore_fmts })<CR>', opts)
end

local function on_attach(client, bufnr)
    lsp_client_settings(client)

    local success, is_attached = pcall(vim.api.nvim_buf_get_var, bufnr, 'is_nivm_lsp_attached')
    if success and is_attached or false then
        return
    end
    vim.api.nvim_set_option('updatetime', 300)
    vim.api.nvim_buf_set_var(bufnr, 'is_nivm_lsp_attached', true)

    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    lsp_buf_keymap(bufnr)
end

vim.diagnostic.config({
    update_in_insert = true,
})

local lspconfig = require("lspconfig")

local is_node_dir = function()
    return lspconfig.util.root_pattern('package.json')(vim.fn.getcwd())
end

local servers = {
    ["gopls"]            = {},
    ["sqls"]             = {
        on_attach = function(client, bufnr)
            require("sqls").on_attach(client, bufnr)
            on_attach(client, bufnr)
        end,
    },
    ["bufls"]            = {
        cmd = { 'buf', 'beta', 'lsp' },
    },
    ["ts_ls"]            = {
        on_attach = function(client, bufnr)
            if not is_node_dir() then
                client.stop()
            end
            on_attach(client, bufnr)
        end,
        single_file_support = false,
        root_dir = lspconfig.util.root_pattern("package.json"),
    },
    ["eslint"]           = {
        root_dir = lspconfig.util.root_pattern(".eslintrc.*", "package.json"),
    },
    ["lua_ls"]           = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim' },
                },
            },
        },
    },
    ["denols"]           = {
        on_attach = function(client, bufnr)
            if is_node_dir() then
                client.stop()
            end
            on_attach(client, bufnr)
        end,
        single_file_support = false,
        root_dir = lspconfig.util.root_pattern("deno.json", "denops"),
        init_options = {
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
    },
    ["rust_analyzer"]    = {
        settings = {
            ["rust_analyzer"] = {
                cargo = {
                    allFeatures = true,
                    loadOutDirsFromCheck = true
                },
                procMacro = { enable = true },
                checkOnSave = { command = "clippy" },
            },
        },
    },
    ["yamlls"]           = {
        settings = {
            yaml = {
                format = {
                    enable = true,
                },
                keyOrdering = false,
            },
        },
    },
    ["golangci_lint_ls"] = {
        filetypes = { 'go' }
    },
    ["pylsp"]            = {
        settings = {
            pylsp = {
                plugins = {
                    pycodestyle = {
                        ignore = { 'E501' },
                    },
                },
            },
        },
    },
    ["graphql"]          = {
        root_dir = lspconfig.util.root_pattern("package.json", "go.mod", ".git"),
    },
    ["fsautocomplete"]   = {
        single_file_support = true,
    },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

for server_name, server_opt in pairs(servers) do
    ---@type table<any, any>
    local opt = {
        on_attach = on_attach,
        capabilities = capabilities,
    }
    for k, v in pairs(server_opt) do opt[k] = v end
    lspconfig[server_name].setup(opt)
end
--- }}}
