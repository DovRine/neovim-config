return {
    {
        "tpope/vim-fugitive",
        lazy = false,
        keys = {
            { "<leader>gs", ":Git status<CR>", { desc = "git status" } },
            { "<leader>ga", ":Git add -A<CR>", { desc = "git add all" } },
            { "<leader>gc", ":Git commit -m ", { desc = "git commit (wait for message)" } },
            { "<leader>gb", ":Git blame<CR>", { desc = "git blame" } },
            { "<leader>gds", ":Git diff --staged<CR>", { desc = "git diff --staged"} },
            { "<leader>gls", ":Git ls<CR>", { desc = "git log (short)" } },
            { "<leader>glds", ":Git lds<CR>", { desc = "git log (short, timestamp)" } },
        },
    },
}
