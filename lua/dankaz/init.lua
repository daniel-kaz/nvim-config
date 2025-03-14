require("dankaz.mappings")
require("dankaz.lazy_init")

-- options

vim.opt.nu = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.breakindent =true
vim.opt.smartindent = true
vim.opt.hlsearch = false
vim.incsearch = true
local home = ""
if vim.fn.has('win32') ~= 0 then
    home = os.getenv("USERPROFILE") or ""
else
    home = os.getenv('HOME') or ""
end
print(os.getenv('HOME') or "")
vim.opt.undodir = home .. '/.vim/undodir'
vim.opt.undofile = true
vim.opt.termguicolors = true
vim.opt.updatetime = 50

vim.o.scrolloff = 8
--autocmds

local augroup = vim.api.nvim_create_augroup
local dankazGroup = augroup('dankaz', {})
local autocmd = vim.api.nvim_create_autocmd

autocmd('LspAttach', {
    group = dankazGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "gD", function () vim.lsp.buf.declaration() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
-- Vim jump not implemented on version 0.10.4
        -- vim.keymap.set("n", "[d", function() vim.diagnostic.jump({count=1, float=true}) end, opts)
        -- vim.keymap.set("n", "]d", function() vim.diagnostic.jump({count=-1, float=true}) end, opts)
        vim.keymap.set("n", "[d", function ()
            vim.diagnostic.goto_next()
        end)
        vim.keymap.set("n", "]d", function ()
            vim.diagnostic.goto_prev()
        end)
    end
})

autocmd("TextYankPost", {
    group = dankazGroup,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({higroup='incsearch', timeout=200})
    end,
})

-- python stuff
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr"
vim.o.foldlevel = 99


local function close_markdown_folds()
  local total_lines = vim.fn.line('$')
  for i = 1, total_lines do
    local fold_level = vim.fn.foldlevel(i)
    if fold_level == 2 then
      vim.fn.execute(i .. 'foldclose')
    end
  end
end

vim.keymap.set('n', '<leader>z', close_markdown_folds)
