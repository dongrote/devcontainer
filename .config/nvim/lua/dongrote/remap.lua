vim.g.mapleader = " "

-- open file explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.NvimTreeToggle, { desc = "File Tree Toggle", })

-- set executable bit on current file
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- csharp (dotnet) shell commands
vim.keymap.set("n", "<leader>cst", "<cmd>!dotnet test<CR>")
vim.keymap.set("n", "<leader>csr", "<cmd>!dotnet restore<CR>")

-- nodejs shell commands
vim.keymap.set("n", "<leader>npmb", "<cmd>!npm run build<CR>")
vim.keymap.set("n", "<leader>npmt", "<cmd>!npm test<CR>")

vim.keymap.set("n", "<leader>lsp", "<cmd>LspRestart<CR>")

-- vim.keymap.set("n", "<leader>gd", "<cmd>lua require('omnisharp_extended').telescope_lsp_definition({ jump_type = 'vsplit' })<CR>")
