vim.cmd([[
syntax on
filetype plugin indent on
let spell_language_list = "british"
color desert

command! Ka !kubectl apply -f %
command! Kd !kubectl delete -f %
command! Gt terminal lazygit
]])

vim.o.backspace=indent,eol,start -- Let me delete it all
vim.o.incsearch=true -- Incremental search
vim.o.mouse=a -- Enable mouse support
-- Use CTRL-L to clear the highlighting of 'hlsearch' (off by default) and call :diffupdate.
vim.api.nvim_set_keymap(
  "n",
  "<C-l>",
  ":nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>",
  { noremap = true }
  )

vim.o.laststatus=2 -- Always show status line
vim.o.ruler=true -- Show cursor position
vim.o.wildmenu=true -- Enable autocompletion
vim.o.wildmode="longest:full,full" -- Enable autocompletion to longest common
vim.o.scrolloff=1 -- Ensure there is always one line visible before/after current
vim.o.sidescroll=1 -- Same for side scrolling
vim.o.sidescrolloff=2 -- Same for side scrolling

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
vim.o.background=light
vim.o.guifont=Monospace
vim.o.foldmethod="marker"
vim.g.airline_powerline_fonts = 1
vim.g.netrw_liststyle = 3 -- treeview
vim.g.netrw_banner = 0 -- Remove top banner

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  use 'dense-analysis/ale'
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'powerline',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
