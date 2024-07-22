vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("n", "<leader>dt", "<cmd>!dotnet test<CR>")
vim.keymap.set("n", "<leader>dr", "<cmd>!dotnet restore<CR>")
vim.keymap.set("n", "<leader>lsp", "<cmd>LspRestart<CR>")
