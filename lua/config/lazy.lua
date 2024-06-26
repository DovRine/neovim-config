local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

vim.opt.guifont = "FiraCode Nerd Font Mono:h12"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

vim.keymap.set("n", "<leader>l", ":Lazy<CR>", { desc = "Open Lazy.nvim" })

require("lazy").setup("plugins")
