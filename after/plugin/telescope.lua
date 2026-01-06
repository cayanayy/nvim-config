local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff',
    function() builtin.find_files({ hidden = true,no_ignore = true, file_ignore_patterns = { "node_modules", ".git/" } }) end,
    { desc = 'Telescope find files' })

vim.keymap.set('n', '<leader>fs', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { desc = "Telescope find references" })
