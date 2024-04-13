local opt = vim.opt

opt.swapfile = false
opt.winbar = "%=%m %f"
opt.wrap = false

opt.number = true
opt.relativenumber = true

-- backspace
opt.backspace = "indent,eol,start"

-- tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- undo
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

-- appearance
opt.cursorline = true
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.colorcolumn = "80"

opt.foldmethod = "manual"

-- clipboard
opt.clipboard:append("unnamedplus")

-- splits
opt.splitright = true
opt.splitbelow = true

opt.list = true
opt.listchars = "leadmultispace:·.,tab:»·,trail:·"

-- treat all files as bash if the type is unknown
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*",
    callback = function()
        if vim.bo.filetype == '' then
            vim.bo.filetype = 'bash'
        end
    end,
})
