-- Use CTRL-L to clear the highlighting of 'hlsearch' (off by default) and call :diffupdate.
vim.api.nvim_set_keymap("n", "<C-l>",
                        ":nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>",
                        {noremap = true})

-- leader+s will select current word and regex for you to replace it
vim.keymap.set("n", "<leader>s",
               [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace current word"})
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", {silent = true})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- move selection down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- move selection up

vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
vim.keymap.set("n", "<leader>y>", "\"+y")
vim.keymap.set("v", "<leader>y>", "\"+y")
vim.keymap.set("n", "<leader>Y>", "\"+Y")

vim.keymap.set("n", "<leader>tn", ":tabnew<cr>")
vim.keymap.set("n", "<leader>t<leader>", ":tabnext<cr>")
vim.keymap.set("n", "<leader>tm", ":tabmove")
vim.keymap.set("n", "<leader>tc", ":tabclose<cr>")
vim.keymap.set("n", "<leader>to", ":tabonly<cr>")

vim.keymap.set("n", "g=", ":lua vim.lsp.buf.format()<cr>", {silent = true})
vim.keymap.set("v", "g=", function() vim.lsp.buf.format({async=true}) end, {silent=true})
vim.keymap.set("n", "ga", ":lua vim.lsp.buf.code_action()<cr>", {silent = true})
vim.keymap.set("n", "gA", ":lua vim.lsp.buf.code_action({apply=true})<cr>",
               {silent = true})
vim.keymap.set("n", "gr", ":lua vim.lsp.buf.rename()<cr>", {silent = true})
vim.keymap.set("n", "gd", ":lua vim.diagnostic.open_float()<cr>",
               {silent = true})
vim.keymap
    .set("n", "g,", ":lua vim.diagnostic.goto_prev()<cr>", {silent = true})
vim.keymap
    .set("n", "g.", ":lua vim.diagnostic.goto_next()<cr>", {silent = true})
vim.keymap.set("n", "gt", ":TroubleToggle<cr>", {silent = true})

-- make mouse selection auto copy to xclip
vim.keymap.set("v", "<LeftRelease>", '"*ygv', {silent = true})

vim.keymap.set("i",'jk', '<Esc>') -- map jk to escape?
