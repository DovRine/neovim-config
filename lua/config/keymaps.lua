local vim = vim

vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move selected lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move selected lines up" })

-- use blackhole registers when deleting
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "use blackhole registers to delete" })

-- copy to system clipboard
vim.keymap.set("n", "<leader>y", "+y")
vim.keymap.set("v", "<leader>y", "+y")
vim.keymap.set("n", "<leader>Y", "+Y")
vim.keymap.set("v", "<leader>Y", "+Y")

-- allow moving selected lines in visual mode
vim.keymap.set("n", "<leader>d", '"_d', { desc = "use blackhole registers to delete" })

-- cursor motions
vim.keymap.set("n", "J", "mzJ`z")           -- join lines without moving the cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz")     -- jump down half a page: keep the cursor in the middle of the screen
vim.keymap.set("n", "<C-u>", "<C-u>zz")     -- jump up half a page: keep the cursor in the middle of the screen
vim.keymap.set("n", "n", "nzzzv")           -- keep the cursor in the middle of the screen while searching
vim.keymap.set("n", "N", "Nzzzv")           -- keep the cursor in the middle of the screen while searching

-- auto insert quotes, parens, braces, and brackets --
vim.keymap.set("v", "(", "s()<esc>Pll")
vim.keymap.set("v", "[", "s[]<esc>Pll")
vim.keymap.set("v", "{", "s{}<esc>Pll")
vim.keymap.set("v", "'", "s''<esc>Pll")
vim.keymap.set("v", '"', 's""<esc>Pll')

-- insert blank line above removing any auto-added chars
vim.keymap.set("n", "<leader>na", "O<esc>0d$j", { desc = "insert blank line above" })

-- insert blank line below
vim.keymap.set("n", "<leader>nb", "o<esc>0d$k", { desc = "insert blank line below" })

-- select entire buffer
vim.keymap.set("n", "<leader><C-a>", "gg<S-v>G", { desc = "select all" })

-- format json in the current buffer
vim.keymap.set("n", "<leader>fj", ":%! jq .<CR>", { desc = "format json in current buffer" })

-- splits
vim.keymap.set("n", "<leader>-", ":split<CR>", { desc = "split horizontal" })
vim.keymap.set("n", "<leader>|", ":vsplit<CR>", { desc = "split vertical" })
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", { desc = "focus split up" })
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", { desc = "focus split down" })
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", { desc = "focus split left" })
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", { desc = "focus split right" })

-- buffers
local cmd_next = ":bnext<CR>"
local cmd_prev = ":bprev<CR>"
local last_cmd = cmd_next
vim.keymap.set("n", "bb", function()
        if (last_cmd == cmd_next) then
            last_cmd = cmd_prev
        else
            last_cmd = cmd_next
        end

        vim.cmd.normal(vim.api.nvim_replace_termcodes(last_cmd, true, true, true))
    end,
    { desc = "toggle between last 2 open buffers" })

-- show popup for linter errors to show complete message
vim.keymap.set('n', '<leader>k', ':lua vim.diagnostic.open_float()<cr>')
