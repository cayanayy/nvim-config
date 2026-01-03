local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)
vim.g.maplocalleader = "\\"

require("lazy").setup({
	spec = {
		{
			'nvim-telescope/telescope.nvim', tag = 'v0.2.1',
			dependencies = {
				'nvim-lua/plenary.nvim',
				{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
			}
		},
		{
			"folke/tokyonight.nvim",
			lazy = false,
			priority = 1000,
			opts = {},
			config = function(_, opts)
				require("tokyonight").setup(opts)
			end,
		},
        { "rose-pine/neovim", name = "rose-pine" },
        {'akinsho/toggleterm.nvim', version = "*", opts = {}},
        {
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
        },
        {
            "hrsh7th/nvim-cmp",
            dependencies = {
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
            },
            config = function()
                local cmp = require('cmp')
                cmp.setup({
                    sources = {
                        { name = 'nvim_lsp' },
                        { name = 'buffer' },
                        { name = 'path' },
                    },
                    mapping = cmp.mapping.preset.insert({
                        ['<CR>'] = cmp.mapping.confirm({ select = true }),
                        ['<Tab>'] = cmp.mapping.select_next_item(),
                        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                        ['<C-Space>'] = cmp.mapping.complete(),
                    }),
                    snippet = {
                        expand = function(args)
                            vim.snippet.expand(args.body)
                        end,
                    },
                })
            end
        },
        {
            'nvim-treesitter/nvim-treesitter',
            lazy = false,
            build = ':TSUpdate'
        },
        {
            "stevearc/conform.nvim",
            opts = {
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "isort", "black" }, -- Önce sırala, sonra formatla
                    javascript = { "prettierd", "prettier", stop_after_first = true },
                },
                format_on_save = {
                    -- Kaydettiğinde otomatik çalışması için:
                    timeout_ms = 500,
                    lsp_fallback = true,
                },
            },
        },
--        {
--            "nvim-tree/nvim-tree.lua",
--            version = "*",
--            lazy = false,
--            dependencies = {
--                "nvim-tree/nvim-web-devicons", -- Dosya ikonları için gerekli
--            },
--            config = function()
--                require("nvim-tree").setup({
--                    sort_by = "case_sensitive",
--                    view = {
--                        width = 30, -- Genişlik
--                        side = "left", -- Sol tarafta açılacak
--                    },
--                    renderer = {
--                        group_empty = true,
--                        icons = {
--                            show = {
--                                file = true,
--                                folder = true,
--                                folder_arrow = true,
--                                git = true,
--                            },
--                        },
--                    },
--                    filters = {
--                        dotfiles = false, -- Gizli dosyaları göster (istersen true yapabilirsin)
--                    },
--                })
--
--                -- nvim-tree'yi açıp kapatmak için kısayol
--                vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Explorer (Toggle)' })
--                vim.keymap.set('n', '<leader>er', ':NvimTreeFocus<CR>', { desc = 'Explorer (Focus)' })
--            end,
--        },
    },
	checker = { enabled = true },
})
