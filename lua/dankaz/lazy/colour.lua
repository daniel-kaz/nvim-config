function ColourMyScreen(color)
    local colour = color or "rose-pine-moon"
    vim.cmd.colorscheme(colour)
    vim.api.nvim_set_hl(0,"Normal", {bg = "#181b1c"})
    vim.api.nvim_set_hl(0, "NormalFloat",{bg = "#181b1c"} )
    vim.api.nvim_set_hl(0, "NormalNC",{bg = "#181b1c"} )
end

return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        disable_background = true,
        opts = { styles = { italic = false } },
        config = function(_, opts)
            require("rose-pine").setup(opts)
            ColourMyScreen()
        end,
    },

}
