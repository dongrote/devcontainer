vim.g.mapleader = " "

-- open file explorer
vim.keymap.set("n", "<leader>us", "<cmd>:setlocal spell<CR>", { desc = "Spellcheck On", })
vim.keymap.set("n", "<leader>uS", "<cmd>:setlocal nospell<CR>", { desc = "Spellcheck Off", })

-- open file explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.NvimTreeToggle, { desc = "File Tree Toggle", })

-- set executable bit on current file
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- clear highlight
vim.keymap.set("n", "<leader>ch", "<cmd>noh<CR>", { desc = "Clear Highlight", })

-- csharp (dotnet) shell commands
vim.keymap.set("n", "<leader>cst", "<cmd>!dotnet test<CR>", { desc = "Run C# Tests", })
vim.keymap.set("n", "<leader>csb", "<cmd>!dotnet build<CR>", { desc = "C# Build", })
vim.keymap.set("n", "<leader>csr", "<cmd>!dotnet restore<CR>", { desc = "C# Restore", })

-- nodejs shell commands
vim.keymap.set("n", "<leader>npmb", "<cmd>!npm run build<CR>")
vim.keymap.set("n", "<leader>npmt", "<cmd>!npm test<CR>")

vim.keymap.set("n", "<leader>lr", "<cmd>LspRestart<CR>")
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format", })

-- vim.keymap.set("n", "<leader>gd", "<cmd>lua require('omnisharp_extended').telescope_lsp_definition({ jump_type = 'vsplit' })<CR>")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
