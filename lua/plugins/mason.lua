return {
    "williamboman/mason.nvim",
    keys = {
        { "<leader>m", ":Mason<CR>", desc = "Mason" },
    },
    priority = 200, -- ensure that mason is configured before lspconfig
    config = function()
        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                },
            },
        })
    end,
}
