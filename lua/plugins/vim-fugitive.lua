return {
    {
        "tpope/vim-fugitive",
        keys = {
            { "<leader>gs", ":Git status<CR>", { desc = "git status" } },
            { "<leader>ga", ":Git add -A<CR>", { desc = "git add all" } },
            { "<leader>gc", ":Git commit -m ", { desc = "git commit (wait for message)" } },
            { "<leader>gb", ":Git blame<CR>", { desc = "git blame" } },
        },
    },
}
