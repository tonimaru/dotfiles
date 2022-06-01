function on_attach(client, bufnr)
  if client.name == 'tsserver' then
    local ts_utils = require("nvim-lsp-ts-utils")
    ts_utils.setup({ filter_out_diagnostics_by_code = { 80001 } })
    ts_utils.setup_client(client)
    client.server_capabilities.document_formatting = false
  elseif client.name == 'volar' then
    client.server_capabilities.document_formatting = false
  end
  if client.name == 'intelephense' then
    client.server_capabilities.document_formatting = false
  end

  local success, is_attached = pcall(vim.api.nvim_buf_get_var, bufnr, 'is_nivm_lsp_attached')
  if success and is_attached or false then
    return
  end
  vim.api.nvim_buf_set_var(bufnr, 'is_nivm_lsp_attached', true)

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local opts = { noremap = true, silent = true }
  buf_set_keymap('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '[lang]i', '<cmd>lua vim.lsp.buf.implementation()<CR>', {})
  buf_set_keymap('n', '[lang]D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', {})
  buf_set_keymap('n', '[lang]r', '<cmd>lua vim.lsp.buf.rename()<CR>', {})
  buf_set_keymap('n', '[lang]a', '<cmd>lua vim.lsp.buf.code_action()<CR>', {})
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<c-p>', '<cmd>lua vim.diagnostic.goto_prev({float=false})<CR>', opts)
  buf_set_keymap('n', '<c-n>', '<cmd>lua vim.diagnostic.goto_next({float=false})<CR>', opts)
  buf_set_keymap('n', '==', '<cmd>lua vim.lsp.buf.format()<CR>', opts)

  vim.cmd [[Au CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]
end

function hook_post_source()
  vim.diagnostic.config({
    virtual_text = false,
    update_in_insert = true,
  })

  local nvim_lsp = require('lspconfig')
  nvim_lsp.remark_ls.setup {
    on_attach = on_attach,
    cmd = { "remark-language-server", "--stdio" },
    filetypes = { "markdown" },
    single_file_support = true,
  }

  local lsp_installer = require("nvim-lsp-installer")
  lsp_installer.on_server_ready(function(server)
    local server_opts = {
      ["tsserver"] = {
        autostart = false,
      },
      ["eslint"] = {
        autostart = false,
      },
      ["denols"] = {
        autostart = false,
        single_file_support = true,
        init_options = {
          lint = true,
          unstable = true,
        },
      },
      ["rust_analyzer"] = {
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true
            },
            procMacro = {
              enable = true
            },
            checkOnSave = {
              command = "clippy",
            },
          },
        },
      },
      ["efm"] = {
        filetypes = {
          'javascript',
          'typescript',
          'javascriptreact',
          'typescriptreact',
          'vue',
          'html',
          'json',
          'yaml',
        },
      },
      ["sumneko_lua"] = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            }
          }
        },
      },
    }

    local opts = server_opts[server.name] or {}
    opts.on_attach = on_attach
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    opts.capabilities = capabilities

    server:setup(opts)
  end)

  vim.cmd [[Au FileType typescript,javascript lua start_ts_js_server()]]
  vim.cmd [[Au FileType vue lua start_vue_server()]]
end

function attach_lsp(server_name)
  local nvim_lsp = require('lspconfig')
  local lsp_installer_servers = require 'nvim-lsp-installer.servers'
  local server_available, requested_server = lsp_installer_servers.get_server(server_name)
  if server_available then
    if not requested_server:is_installed() then
      requested_server:install()
    end
    local server = nvim_lsp[server_name]
    server.manager.try_add()
  end
end

function start_ts_js_server()
  local nvim_lsp = require('lspconfig')
  local path = vim.fn.expand('%:p:h')
  local pkg_dir = nvim_lsp.util.find_package_json_ancestor(path)
  local is_node = pkg_dir ~= nil
  if is_node then
    attach_lsp('tsserver')
    attach_lsp('eslint')
  else
    attach_lsp('denols')
  end

end

function start_vue_server()
  attach_lsp('eslint')
end
