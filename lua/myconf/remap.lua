vim.g.mapleader = " "

vim.keymap.set("n", "<leader>gb", vim.cmd.Ex)
vim.keymap.set("n", "<ESC>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<left>", '<cmd>echo "use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "use j to move!!"<CR>')
