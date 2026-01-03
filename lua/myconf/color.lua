vim.opt.termguicolors = true
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ff9e64", bold = true })
        vim.api.nvim_set_hl(0, "LineNr", { fg = "#565f89" })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    end,
})
vim.cmd([[colorscheme tokyonight]])
