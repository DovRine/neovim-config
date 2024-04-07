vim.opt.winbar = "%=%m %f"
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"

vim.opt.foldmethod = "manual"

vim.opt.clipboard = "unnamedplus"

vim.opt.list = true
vim.opt.listchars = "leadmultispace:·.,tab:»·,trail:·"

-- treat all files as bash if the type is unknown
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*",
    callback = function()
        if vim.bo.filetype == '' then
            vim.bo.filetype = 'bash'
        end
    end,
})
