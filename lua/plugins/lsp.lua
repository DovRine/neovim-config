vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set('n', '<leader>tl', function()
                vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
            end,
            bufopts
        )
    end,
})

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        print('lsp setup')
        require("mason").setup()
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
                    require("lspconfig")[server_name].setup {}
                end
            },
        })
    end,
}