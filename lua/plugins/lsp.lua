local function getBufferOpts(ev, tbl)
    local opts = {buffer = ev.buf}
    for k, v in pairs(tbl) do
        opts[k] = v
    end

    return opts
end

local function goToDefinitionInVerticalSplit()
    vim.cmd("vsplit")
    -- Retrieve the list of all window IDs after the split
    local windows = vim.api.nvim_list_wins()

    -- The new window is assumed to be the last in the list of window IDs
    local new_win_id = windows[#windows]

    -- Explicitly set focus to the new window
    vim.api.nvim_set_current_win(new_win_id)

    -- Delay the execution of vim.lsp.buf.definition to ensure the new window is ready
    vim.defer_fn(function()
        vim.lsp.buf.definition()
    end, 10) -- Delay in milliseconds, adjust as needed
end

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local defaultOpts = { desc = "" }
        vim.keymap.set("n", "<C-g>", function() vim.lsp.buf.definition() end, getBufferOpts(ev, {desc = "go to definition"}))
        vim.keymap.set("n", "<C-s>", goToDefinitionInVerticalSplit, getBufferOpts(ev, {desc = "go to definition in vertical split"}))
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, getBufferOpts(ev, defaultOpts))
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, getBufferOpts(ev, defaultOpts))
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, getBufferOpts(ev, defaultOpts))
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, getBufferOpts(ev, defaultOpts))
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, getBufferOpts(ev, defaultOpts))
        vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, getBufferOpts(ev, defaultOpts))
        vim.keymap.set("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, getBufferOpts(ev, defaultOpts))
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, getBufferOpts(ev, defaultOpts))
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, getBufferOpts(ev, defaultOpts))
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, getBufferOpts(ev, defaultOpts))
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, getBufferOpts(ev, defaultOpts))
        vim.keymap.set('n', '<leader>tl', function()
                vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
            end,
            {}
        )
    end,
})

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        {
            "towolf/vim-helm",
            ft = "helm"
        },
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "bashls",
                "clangd",
                "cmake",
                "cssls",
                "cssmodules_ls",
                -- "diagnosticls",
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
                -- default handler
                function(server_name)
                    require('cmp').setup {
                        sources = {
                            { name = 'nvim_lsp' }
                        }
                    }
                    local cmp = require("cmp_nvim_lsp")
                    local capabilities = vim.tbl_deep_extend(
                        "force",
                        {},
                        vim.lsp.protocol.make_client_capabilities(),
                        cmp.default_capabilities()
                    )
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                -- dedicated handlers
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" },
                                }
                            }
                        }
                    }
                end,
                ['helm_ls'] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.helm_ls.setup {
                        settings = {
                            ['helm-ls'] = {
                                logLevel = "info",
                                valuesFiles = {
                                    mainValuesFile = "values.yaml",
                                    lintOverlayValuesFile = "values.lint.yaml",
                                    additionalValuesFilesGlobPattern = "values*.yaml"
                                },
                                yamlls = {
                                    enabled = true,
                                    diagnosticsLimit = 50,
                                    showDiagnosticsDirectly = false,
                                    path = "yaml-language-server",
                                    config = {
                                        schemas = {
                                            kubernetes = "templates/**",
                                        },
                                        completion = true,
                                        hover = true,
                                        -- any other config from https://github.com/redhat-developer/yaml-language-server#language-server-settings
                                    }
                                }
                            }
                        }
                    }
                    lspconfig.yamlls.setup {}
                end,
            },
        })
    end,
}
