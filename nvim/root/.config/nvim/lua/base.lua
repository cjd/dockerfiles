vim.o.undofile=true
vim.o.confirm=true
vim.o.mouse="a"

vim.o.backspace=[[indent,eol,start]] -- Let me delete it all
vim.o.incsearch=true -- Incremental search
vim.o.hlsearch = true --Set highlight on search:w
vim.o.timeoutlen = 300	--	Time in milliseconds to wait for a mapped sequence to complete.
vim.o.laststatus=2 -- Always show status line
vim.o.ruler=true -- Show cursor position
vim.o.wildmenu=true -- Enable autocompletion
vim.o.wildmode="longest:full,full" -- Enable autocompletion to longest common
vim.o.scrolloff=4 -- Ensure there is always one line visible before/after current
vim.o.sidescroll=1 -- Same for side scrolling
vim.o.sidescrolloff=2 -- Same for side scrolling
vim.wo.relativenumber = true -- show relative line numbers
vim.wo.number = true -- but not for current line :P
vim.o.tabstop=2
vim.o.shiftwidth=2
vim.o.softtabstop=2
vim.o.expandtab=true
vim.o.smarttab=true
vim.o.showmatch=true
vim.o.ignorecase=true
vim.o.smartcase=true
vim.o.incsearch=true
vim.o.number=true
vim.g.syntax_on=true
vim.o.foldmethod="marker"
vim.g.showtabline=1

-- disable netrw since going to use neotree/telescope
--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1
vim.g.netrw_liststyle = 1 -- treeview
vim.g.netrw_banner = 0 -- Remove top banner

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- Use space as leader
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.api.nvim_set_option("clipboard","unnamedplus")
