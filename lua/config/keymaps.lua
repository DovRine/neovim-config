vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move selected lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move selected lines up" })

-- use blackhole registers when deleting
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "use blackhole registers to delete" })

-- allow moving selected lines in visual mode
vim.keymap.set("n", "<leader>d", '"_d', { desc = "use blackhole registers to delete" })

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
