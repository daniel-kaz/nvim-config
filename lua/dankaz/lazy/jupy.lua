
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.wo.foldmethod = "expr"
    vim.wo.foldexpr = "v:lua.MarkdownDocstringFolds()"
    vim.wo.foldlevel = 99 -- Open all folds by default
    vim.wo.foldenable = true
    vim.api.nvim_set_hl(0, "CursorLine",{bg = "#181b1c"} )
  end
})


--- @class LineRange
--- @field startLine number
--- @field endLine number

function _G.MarkdownDocstringFolds()
    local line = vim.fn.getline(vim.v.lnum)
    local prev_line = vim.fn.getline(vim.v.lnum - 1)
    local next_line = vim.fn.getline(vim.v.lnum + 1)

    -- Start fold on '# %% [markdown]'
    if line:match("^# %%%% %[markdown%]") then
        return '>1' -- Start a new fold
    end

    if prev_line:match("^# %%%%% %[markdown%]") and line:match([[^"""]]) then
        return 1
    end
    -- Continue fold until the closing triple quotes
    if (vim.fn.foldlevel(vim.v.lnum - 1) > 0) then
        if next_line:match("^# %%%%") then
            return 0
        end
        if not line:match([[^"""]]) then
            return '1'
        else
            return '<1'
        end
    end

    return 0 -- No fold
end


return {
    {
        "Vigemus/iron.nvim",
        config = function()
            local iron = require("iron.core")
            iron.setup({
                config = {
                    repl_definition = {
                        python = {
                            command = {"ipython"},
                            format = require("iron.fts.common").bracketed_paste_python,
                            block_deviders = {"# %%", "#%%"}
                        },
                    },
                    repl_open_cmd= "vsplit",
                },
                keymaps = {
                    send_motion = "<leader>sc",
                    visual_send = "<leader>sc",
                    send_file = "<leader>sf",
                    send_code_block = "<leader>sb",
                    interrupt = "<space>s<space>",
                },
                ignore_blank_lines = true
            })
        end,
    },
    {
        "kiyoon/jupynium.nvim",
        build = "pip3 install --user .",
        -- build = "uv pip install . --python=$HOME/.virtualenvs/jupynium/bin/python",
        -- build = "conda run --no-capture-output -n jupynium pip install .",
    },
}
