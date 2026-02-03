---@type vim.lsp.Config
return {
    settings = {
        ["rust-analyzer"] = {
            check = {
                command = "clippy",
            },
            cargo = {
                features = "all",
                targetDir = vim.fn.expand("~/.cache/rust-analyzer/target"),
            },
        },
    },
}
