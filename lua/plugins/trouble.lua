return {
    {
        "folke/trouble.nvim",
        keys = {
            { "<leader>xx", ":TroubleToggle<CR>",  desc = "toggle Trouble" },
            { "<leader>xr", ":TroubleRefresh<CR>", desc = "refresh Trouble" },
        },
        opts = {
            use_diagnostic_signs = true,
        }
    },
}
