return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "williamboman/mason.nvim", config = true },
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp", -- Otomatik tamamlama için köprü
    },
    config = function()
        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(event)
                local opts = { buffer = event.buf }
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
            end,
        })

        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "pyright" }, -- Otomatik kurulacak sunucular
            handlers = {
                function(server_name)
                    vim.lsp.config(server_name, { capabilities = capabilities })
                    vim.lsp.enable(server_name)
                end,
                ["lua_ls"] = function()
                    vim.lsp.config("lua_ls", {
                        capabilities = capabilities,
                        settings = {
                            Lua = { diagnostics = { globals = { "vim" } } }
                        }
                    })
                    vim.lsp.enable("lua_ls")
                end,
            }
        })
    end
}
