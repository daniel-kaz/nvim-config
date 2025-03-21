vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Launch netrw/file explorer"})
-- like alt arrow key in vs code
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move the current line down one line"})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv",{ desc = "Move the current line down one line"})

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = "Yanks into global paste buffer" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yanks remaining line into global paste buffer"})
-- insertleave auto cmd bs
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set({"n", "v"}, "<leader>d", "\"_d", {desc = "Deletes without moving into window paste buffer"})

vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x % <CR>", { desc = "Sets the current file to an executable"})

-- window mappings
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
