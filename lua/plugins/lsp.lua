-- Helper functions
local function getBufferOpts(ev, tbl)
    local opts = { buffer = ev.buf }
    for k, v in pairs(tbl) do
        opts[k] = v
    end
    return opts
end

local function goToDefinitionInVerticalSplit()
    vim.cmd("vsplit")
    local windows = vim.api.nvim_list_wins()
    local new_win_id = windows[#windows]
    vim.api.nvim_set_current_win(new_win_id)
    vim.defer_fn(function()
        vim.lsp.buf.definition()
    end, 10)
end

-- LSP Attach configuration
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local defaultOpts = { desc = "" }
        vim.keymap.set("n", "<C-g>", function() vim.lsp.buf.definition() end,
            getBufferOpts(ev, { desc = "go to definition" }))
        vim.keymap.set("n", "<C-s>", goToDefinitionInVerticalSplit,
            getBufferOpts(ev, { desc = "go to definition in vertical split" }))
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, getBufferOpts(ev, defaultOpts))
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, getBufferOpts(ev, defaultOpts))
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, getBufferOpts(ev, defaultOpts))
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, getBufferOpts(ev, defaultOpts))
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, getBufferOpts(ev, defaultOpts))
        vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, getBufferOpts(ev, defaultOpts))
        vim.keymap.set("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end,
            getBufferOpts(ev, defaultOpts))
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, getBufferOpts(ev, defaultOpts))
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, getBufferOpts(ev, defaultOpts))
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, getBufferOpts(ev, defaultOpts))
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, getBufferOpts(ev, defaultOpts))
        vim.keymap.set('n', '<leader>tl', function()
            vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
        end, {})
    end,
})

-- Plugin configuration
return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        {
            "towolf/vim-helm",
            ft = "helm"
        },
    },
    config = function()
        -- Mason setup
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "bashls",
                "clangd",
                "cmake",
                "cssls",
                "cssmodules_ls",
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
                "pylsp",
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
        })

        -- CMP setup
        local cmp = require 'cmp'
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = {
                ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<C-e>'] = cmp.mapping.abort(),
            },
            sources = {
                { name = 'nvim_lsp' },
                { name = 'buffer' },
                { name = 'path' },
                { name = 'luasnip' },
            },
        })

        -- LSP setup
        local lspconfig = require('lspconfig')
        local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

        local on_attach = function(client, bufnr)
            if client.server_capabilities.did_change_watched_files then
                vim.cmd('doautocmd User LspAttachBuffers')
            end
        end

        -- Setup each LSP server
        local servers = {
            "bashls",
            "clangd",
            "cmake",
            "cssls",
            "cssmodules_ls",
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
            "pylsp",
            "rust_analyzer",
            "sqlls",
            "tailwindcss",
            "taplo",
            "tsserver",
            "vuels",
            "lemminx",
            "yamlls",
            "zls",
        }

        for _, lsp in ipairs(servers) do
            if lsp == "tsserver" then
                lsp = 'ts_ls'
            end
            lspconfig[lsp].setup {
                capabilities = capabilities,
                on_attach = on_attach,
            }
        end

        -- Specific configurations for some LSPs
        lspconfig.lua_ls.setup {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
            capabilities = capabilities,
            on_attach = on_attach,
        }

        lspconfig.pylsp.setup {
            settings = {
                pylsp = {
                    plugins = {
                        black = { enabled = true },
                        pyls_isort = { enabled = true },
                    },
                },
            },
            capabilities = capabilities,
            on_attach = on_attach,
        }

        lspconfig.eslint.setup {
            settings = {
                validate = "on",
                packageManager = "npm",
                autoFixOnSave = true,
                codeActionOnSave = {
                    enable = true,
                    mode = "all",
                },
                format = true,
                workingDirectory = { mode = "auto" },
            },
            capabilities = capabilities,
            on_attach = on_attach,
        }
    end,
}
