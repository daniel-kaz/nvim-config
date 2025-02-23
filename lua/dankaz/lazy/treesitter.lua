return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            -- a list of parsers to be installed
            ensure_installed = { "c", "lua", "vimdoc", "rust", "cpp", "javascript", "bash", "python"},
            auto_install = true,
            sync_install = false,
            highlight = { enable = true},
            indent = { enable = true },
            modules = {},
            ignore_install = {},
        })
    end,
}
