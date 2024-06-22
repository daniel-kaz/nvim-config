return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            -- a list of parsers to be installed
            ensured_installed = { "c", "lua", "vimdoc", "rust", "cpp", "javascript"},
            sync_install = false,
            highlight = { enable = true},
            indent = { enable = true },
        })
    end,
}
