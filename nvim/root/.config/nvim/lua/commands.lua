vim.api.nvim_create_user_command('Lgit', function()
  require('FTerm').scratch({ cmd = {'lazygit'}})
end , { bang = true })
vim.api.nvim_create_user_command('Kapply', function()
  require('FTerm').scratch({ cmd = {'kubectl', 'apply', '-f', vim.fn.expand("%:p")}})
end , { bang = true })
vim.api.nvim_create_user_command('Kdelete', function()
  require('FTerm').scratch({ cmd = {'kubectl', 'delete', '-f', vim.fn.expand("%:p")}})
end , { bang = true })
vim.cmd [[
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()
]]
