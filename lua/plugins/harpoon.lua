return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope.nvim",
            tag = '0.1.6',
            branch = '0.1.x',
        }
    },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup({})

        -- telescope config
        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers").new({}, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table({
                    results = file_paths,
                }),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
            }):find()
        end

        vim.keymap.set("n", "<leader>hh", function() toggle_telescope(harpoon:list()) end,
            { desc = "Open harpoon window" })
        vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end,
            { desc = "append to harpoon" })
        vim.keymap.set("n", "<leader>hd", function() harpoon:list():remove() end,
            { desc = "remove from harpoon" })
        vim.keymap.set("n", "<leader>he", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = "toggle harpoon quick menu" })
        vim.keymap.set("n", "<leader>hj", function() harpoon:list():select(1) end,
            { desc = "select harpoon 1" })
        vim.keymap.set("n", "<leader>hk", function() harpoon:list():select(2) end,
            { desc = "select harpoon 2" })
        vim.keymap.set("n", "<leader>hl", function() harpoon:list():select(3) end,
            { desc = "select harpoon 3" })
        vim.keymap.set("n", "<leader>h;", function() harpoon:list():select(4) end,
            { desc = "select harpoon 4" })
        vim.keymap.set("n", "<leader>hn", function() harpoon:list():prev() end,
            { desc = "harpoon previous" })
        vim.keymap.set("n", "<leader>hm", function() harpoon:list():next() end,
            { desc = "harpoon next" })
    end,
}
