return {
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
    priority = 100, -- ensure that mason is configured before lsp
    keys = {
        { "<leader>m", ":Mason<CR>", desc = "Mason" },
    },
    dependencies = {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig",
    },
    config = function()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "bashls",
                "clangd",
                "cmake",
                "cssls",
                "cssmodules_ls",
                "diagnosticls",
                "dockerls",
                "docker_compose_language_service",
                "dotls",
                "emmet_ls",
                "eslint",
                "golangci_lint_ls",
                "gopls",
                "gradle_ls",
                "grammarly",
                "graphql",
                "groovyls",
                "helm_ls",
                "html",
                "htmx",
                "jqls",
                "kotlin_language_server",
                "lua_ls",
                "marksman",
                "phpactor",
                "puppet",
                "pyright",
                "rust_analyzer",
                "sqlls",
                "tailwindcss",
                "taplo",
                "tsserver",
                "vuels",
                "lemminx",
                "yamlls",
                "zls",
            },
            handlers = {
                function(server_name)
                    print("setting up ", server_name)
                    require("lspconfig")[server_name].setup {}
                end,
            }
        })
        print('loading lsp()')
        require("lazy_nvim").lsp()
    end,
}
