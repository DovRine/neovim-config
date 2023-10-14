 return {
    'nvim-telescope/telescope.nvim', tag = '0.1.4',
    dependencies = {
        'nvim-lua/plenary.nvim',
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
            require("telescope").load_extension("fzf")
        end,
    },
    keys = {
        -- add a keymap to browse plugin files
        -- stylua: ignore
        {
            "<leader> ",
            function()
                require('telescope.builtin').find_files({ })
            end,
            desc = "Find file",
        },
        {
            "<leader>s",
            function()
                require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
            end,
            desc = "Search for text in files"
        }
    },
    config = function()
        require("telescope").setup({
            defaults = {
                layout_strategy = "horizontal",
                layout_config = { prompt_position = "top" },
                sorting_strategy = "ascending",
                winblend = 0,
                file_ignore_patterns = {
                    "node_modules",
                    "build",
                    "dist",
                    "__pycache__",
                    "*.pyc",
                    "yarn.lock",
                    "package-lock.json",
                },
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--hidden",
                    "--unrestricted",
                },
            },
        })
    end,
}
