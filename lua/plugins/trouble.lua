return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
    keys = {
        { "<leader>xx", ":TroubleToggle<CR>",                           desc = "toggle Trouble" },
        { "<leader>xr", ":TroubleRefresh<CR>",                          desc = "refresh Trouble" },
        { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Open trouble workspace diagnostics" },
        { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>",  desc = "Open trouble document diagnostics" },
        { "<leader>xq", "<cmd>TroubleToggle quickfix<CR>",              desc = "Open trouble quickfix list" },
        { "<leader>xl", "<cmd>TroubleToggle loclist<CR>",               desc = "Open trouble location list" },
        { "<leader>xt", "<cmd>TodoTrouble<CR>",                         desc = "Open todos in trouble" },
    },
    opts = {
        use_diagnostic_signs = true,
    }
}
