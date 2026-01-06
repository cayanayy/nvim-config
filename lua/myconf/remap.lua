vim.g.mapleader = " "

vim.keymap.set("n", "<leader>gb", vim.cmd.Ex) -- stands for "go back"
vim.keymap.set("n", "<ESC>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<left>", '<cmd>echo "use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "use j to move!!"<CR>')

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("v", "<leader>gy", '"+y') -- stands for "global yank"


vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename SymbRename Symbolol" }) -- stands for "global yank"
