return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        {"j-hui/fidget.nvim", opts = {} },
        { 'folke/neodev.nvim', opts = {} },
    },

    config = function()
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())
        local servers = {
            lua_ls = {
                -- cmd = {...},
                -- filetypes = { ...},
                -- capabilities = {},
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = 'Replace',
                        },
                    },
                },
            },
            clangd = {},
            rust_analyzer = {},
            tsserver = {},
            matlab_ls = {
                cmd = {'matlab-language-server', '--stdio'},
                filetypes = {'matlab'},
                root_dir = function(fname)
                    return require("lspconfig.util").root_pattern('.git')(fname) or vim.fn.getcwd()
                end,
                settings = {
                    matlab = {
                        indexWorkspace = true,
                        installPath = "",
                        matlabConnectionTiming = 'onStart',
                        telemetry = true,
                    },
                },
                single_file_support = true,
            }
        }

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = vim.tbl_keys(servers or {}),

            handlers = {
                function(server_name) -- default handler (optional)
                    local server = servers[server_name] or {}
                    server.capabilites = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                    require("lspconfig")[server_name].setup(server)
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                    }
                end,
            }
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = true,
                header = "",
                prefix = "",
            },
        })
    end,
    {
        "github/copilot.vim",

    },
}
