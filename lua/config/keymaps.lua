local keymap = vim.keymap

vim.g.mapleader = " "
vim.g.python3_host_prog = "/usr/bin/python3"

vim.env.LUA_PATH = "/usr/share/lua/5.1/?.lua;/usr/share/lua/5.1/?/init.lua"
vim.env.LUA_CPATH = "/usr/lib/lua/5.1/?.so"

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move selected lines down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move selected lines up" })

-- use blackhole registers when deleting
keymap.set("x", "<leader>p", '"_dP', { desc = "use blackhole registers to delete" })

-- copy to system clipboard
keymap.set("n", "<leader>y", "+y", { desc = "copy to default clipboard (normal mode)"})
keymap.set("v", "<leader>y", "+y", { desc = "copy to default clipboard (visual mode)"})
keymap.set("n", "<leader>Y", "+Y", { desc = "copy to system clipboard (normal mode)"})
keymap.set("v", "<leader>Y", "+Y", { desc = "copy to system clipboard (visual mode)"})

-- allow moving selected lines in visual mode
keymap.set("n", "<leader>d", '"_d', { desc = "use blackhole registers to delete" })

-- cursor motions
keymap.set("n", "J", "mzJ`z", { desc = "join next line w/o moving cursor"})
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down half a page (keep cursor centered)"})
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up half a page (keep cursor centered)"})
keymap.set("n", "n", "nzzzv", { desc = "next search result (keep cursor centered)"})
keymap.set("n", "N", "Nzzzv", { desc = "prev search result (keep cursor centered)"})

-- auto insert quotes, parens, braces, and brackets --
keymap.set("v", "(", "s()<esc>Pll", { desc = "wrap selection with parens"})
keymap.set("v", "[", "s[]<esc>Pll", { desc = "wrap selection with square braces"})
keymap.set("v", "{", "s{}<esc>Pll", { desc = "wrap selection with curly braces"})
keymap.set("v", "'", "s''<esc>Pll", { desc = "wrap selection with single quotes"})
keymap.set("v", '"', 's""<esc>Pll', { desc = "wrap selection with double quotes"})

-- insert blank line above removing any auto-added chars
keymap.set("n", "<leader>na", "O<esc>0d$j", { desc = "insert blank line above" })

-- insert blank line below
keymap.set("n", "<leader>nb", "o<esc>0d$k", { desc = "insert blank line below" })

-- select entire buffer
keymap.set("n", "<leader><C-a>", "gg<S-v>G", { desc = "select all" })

-- format json in the current buffer
keymap.set("n", "<leader>fj", ":%! jq .<CR>", { desc = "format json in current buffer" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "close current split" })

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "prev tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "open current buffer in new tab" })

keymap.set("n", "<C-k>", ":wincmd k<CR>", { desc = "focus split up" })
keymap.set("n", "<C-j>", ":wincmd j<CR>", { desc = "focus split down" })
keymap.set("n", "<C-h>", ":wincmd h<CR>", { desc = "focus split left" })
keymap.set("n", "<C-l>", ":wincmd l<CR>", { desc = "focus split right" })

-- buffers
local cmd_next = ":bnext<CR>"
local cmd_prev = ":bprev<CR>"
local last_cmd = cmd_next
keymap.set("n", "bb", function()
        if (last_cmd == cmd_next) then
            last_cmd = cmd_prev
        else
            last_cmd = cmd_next
        end

        vim.cmd.normal(vim.api.nvim_replace_termcodes(last_cmd, true, true, true))
    end,
    { desc = "toggle between last 2 open buffers" })

-- show popup for linter errors to show complete message
keymap.set('n', '<leader>k', ':lua vim.diagnostic.open_float()<cr>', { desc = "show selection popup"})

-- close current buffer without closing the window
keymap.set('n', '<leader>bb', ':bp<bar>sp<bar>bn<bar>bd<CR>', { desc = "close current buffer" })

-- turn off all highlights
keymap.set('n', '<leader>z', ':noh<CR>', { desc = "remove all highlights" })
